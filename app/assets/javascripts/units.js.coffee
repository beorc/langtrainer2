ns = initNamespaces('SITEMPLATE.units')

ns.init = () ->
  sendRequest = (path, options, callback) ->
    default_options = 
    unit: gon.unit
    language: gon.language
    $.ajax
      url: path
      data:
        unit: gon.unit
        language: gon.language
      type: 'put'
      dataType: 'json'
      success: (data) ->
        callback(data) if callback

  answerInput = ->
    $('#answer')

  currentStep = ->
    $('.step')

  enableCommitButton = ->
    $('.actions a.check').removeClass('disabled')

  disableCommitButton = ->
    $('.actions a.check').addClass('disabled')

  verifyAnswer = ->
    input = answerInput()
    answer = input.val()
    rightAnswer = currentStep().data('translation')
    input.removeClass('wrong').removeClass('right')
    if answer.length is 0
      disableCommitButton()
    else if rightAnswer.match("^#{answer}", 'i')
      input.removeClass('wrong').addClass('right')
      enableCommitButton()
    else
      input.removeClass('right').addClass('wrong')
      disableCommitButton()

  answerInput().keyup (e) ->
    verifyAnswer()
    true

  $('.actions a.check').click () ->
    return false if $(@).hasClass('disabled')
    sendRequest gon.verify_answer_path, (data) ->
      if data.correct
        $('.actions a.next-step').removeClass('disabled')
        $('.actions').trigger('rightAnswer')
      else
        $('.actions a.next-step').addClass('disabled')
        $('.actions').trigger('wrongAnswer')
    false

  $('.look').click ->
    rightAnswer = currentStep().data('translation')
    answerInput().removeClass('wrong').removeClass('right')
    answerInput().val(rightAnswer)
    sendRequest gon.show_right_answer_path, (data) ->
      $('.actions').trigger('rightAnswerShown')
    false

  $('.show-next-word').click ->
    rightAnswer = currentStep().data('translation')
    answer = answerInput().val()

    return false if answer.indexOf(rightAnswer) >= 0

    answerRegexp = XRegExp("^#{answer}([\\p{L}\\p{P}]*)\\s*([\\p{L}\\p{P}]*)")
    matches = answerRegexp.exec rightAnswer

    return false if matches is null

    ending = matches[1]

    if ending.length > 0
      answerInput().val("#{answer}#{ending}")
      return false

    nextWord = matches[2]

    answerInput().val("#{answer} #{nextWord}")
    verifyAnswer()
    sendRequest gon.help_next_word_path
    false

  $('.actions a.next-step').click () ->
    if !$(@).hasClass('disabled')
      sendRequest gon.next_step_path, (data) ->
        $('.step').replaceWith(data.markup)
        $('.actions').trigger('nextStepShown')
    false

  goToSelected = ->
    option = $(@).find('option:selected')
    path = option.data('path')
    window.location = path

  $('.courses-list select').change goToSelected

  $('.units-list select').change goToSelected

  $('body').on 'click', '.language-characters button.shift', ->
    language-characters = $(@).closest('.language-characters')
    language-characters.find('a.btn').each (i, button) ->
      $(button).changeCase()

  $('.language-characters a.btn').click ->
    char = $(@).text()
    answer = answerInput().val()

    answerInput().insertAtCaret(char)
    verifyAnswer()
    false

  answerInput().focus () ->
    $(@).addClass 'selected'

  verifyAnswer()
  answerInput().focus()

  answerInput().elastic()

  $('.actions').machine
    setClass: true
    answering:
      defaultState: true
      onEnter: ->
        $('#answer').removeAttr('disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').removeClass('disabled')
        $('.actions .look').removeClass('disabled')
      events: ->
        rightAnswerShown: 'rightAnswer'
        answeredRight: 'rightAnswer'
        answeredWrong: 'wrongAnswer'
        wait: 'waiting'

    wrongAnswer:
      onEnter: ->
        $('#answer').removeAttr('disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').removeClass('disabled')
        $('.actions .look').removeClass('disabled')
      events: ->
        rightAnswerShown: 'rightAnswer'

    rightAnswer:
      onEnter: ->
        $('#answer').attr('disabled', 'disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').removeClass('disabled')
        $('.actions .show-next-word').addClass('disabled')
        $('.actions .look').addClass('disabled')
      events: ->
        nextStepShown: 'answering'

    waiting:
      onEnter: ->
        $('#answer').attr('disabled', 'disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').addClass('disabled')
        $('.actions .look').addClass('disabled')
      events: ->
        answeredRight: 'rightAnswer'
        answeredWrong: 'wrongAnswer'
        error: 'answering'

