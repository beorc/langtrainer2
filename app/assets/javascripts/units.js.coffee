ns = initNamespaces('SITEMPLATE.units')

ns.init = () ->
  sendRequest = (path, callback) ->
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
    input = ns.answerInput()
    answer = input.val()
    rightAnswer = ns.currentStep().data('translation')
    input.removeClass('wrong').removeClass('right')
    if answer.length is 0
      disableCommitButton()
    else if rightAnswer.match("^#{answer}", 'i')
      input.removeClass('wrong').addClass('right')
      enableCommitButton()
    else
      input.removeClass('right').addClass('wrong')
      disableCommitButton()

  ns.answerInput().keyup (e) ->
    verifyAnswer()
    true

  $('.actions a.check').click () ->
    return false if $(@).hasClass('disabled')
    sendRequest gon.check_answer_path, (data) ->
      $('.actions a.next-step').removeClass('disabled') if data.correct
    false

  $('.look').click ->
    rightAnswer = ns.currentStep().data('translation')
    ns.answerInput().removeClass('wrong').removeClass('right')
    ns.answerInput().val(rightAnswer)
    sendRequest gon.show_right_answer_path
    false

  $('.show-next-word').click ->
    rightAnswer = ns.currentStep().data('translation')
    answer = ns.answerInput().val()

    return false if answer.indexOf(rightAnswer) >= 0

    answerRegexp = XRegExp("^#{answer}([\\p{L}\\p{P}]*)\\s*([\\p{L}\\p{P}]*)")
    matches = answerRegexp.exec rightAnswer

    return false if matches is null

    ending = matches[1]

    if ending.length > 0
      ns.answerInput().val("#{answer}#{ending}")
      return false

    nextWord = matches[2]

    ns.answerInput().val("#{answer} #{nextWord}")
    verifyAnswer()
    sendRequest gon.help_next_word_path
    false

  $('.actions a.next-step').click () ->
    if !$(@).hasClass('disabled')
      ns.rollStep()
      sendRequest gon.next_step_path, (data) ->
        $('.step').replaceWith(data.markup)
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
    answer = ns.answerInput().val()

    ns.answerInput().insertAtCaret(char)
    verifyAnswer()
    false

  ns.answerInput().focus () ->
    $(@).addClass 'selected'

  verifyAnswer()
  ns.answerInput().focus()

  ns.answerInput().elastic()

  $('.actions').machine
    answering:
      defaultState: true
      onEnter: ->
        $('#answer').removeAttr('disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').removeClass('disabled')
        $('.actions .look').removeClass('disabled')
      events: ->
        showRightAnswer: 'showingRightAnswer'

    showingRightAnswer:
      onEnter: ->
        $('#answer').attr('disabled', 'disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').addClass('disabled')
        $('.actions .look').addClass('disabled')
      events: ->
        showNextAnswer: 'answering'

