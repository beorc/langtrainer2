ns = initNamespaces('SITEMPLATE.units')

ns.init = () ->
  sendRequest = (path, extraParams) ->
    params =
      unit: gon.unit
      language: gon.language

    params = $.extend(params, extraParams) if extraParams

    $.ajax
      url: path
      data: params
      type: 'put'
      dataType: 'json'

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

  clearComments = ->
    $('.comment').addClass('hide')

  handleComment = (comment, element) ->
    clearComments()
    if comment
      element.text(comment).removeClass('hide')
    false

  $('.actions a.check').click () ->
    return false if $(@).hasClass('disabled')
    $('.actions').trigger('wait')
    sendRequest(gon.verify_answer_path, { answer: answerInput().val() })
      .done (data) ->
        if data.correct
          handleComment(data.comment, $('.comment.correct'))
          $('.actions').trigger('answeredRight')
        else
          handleComment(data.comment, $('.comment.wrong'))
          $('.actions').trigger('answeredWrong')
      .fail ->
        $('.actions').trigger('error')
    false

  $('.look').click ->
    rightAnswer = currentStep().data('translation')
    answerInput().removeClass('wrong').removeClass('right')
    answerInput().val(rightAnswer)
    sendRequest(gon.show_right_answer_path)
      .done (data) ->
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
      sendRequest(gon.next_step_path)
        .done (data) ->
          $('.step').replaceWith(data.markup)
          answerInput().val('')
          clearComments()
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
    answering:
      defaultState: true
      onEnter: ->
        $('#answer').removeAttr('disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').removeClass('disabled')
        $('.actions .look').removeClass('disabled')
      events:
        rightAnswerShown: 'rightAnswer'
        answeredRight: 'rightAnswer'
        answeredWrong: 'wrongAnswer'
        wait: 'waiting'

    wrongAnswer:
      onEnter: ->
        $('.actions').trigger('startAnswering')
      events:
        rightAnswerShown: 'rightAnswer'
        startAnswering: 'answering'

    rightAnswer:
      onEnter: ->
        $('#answer').attr('disabled', 'disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').removeClass('disabled')
        $('.actions .show-next-word').addClass('disabled')
        $('.actions .look').addClass('disabled')
      events:
        nextStepShown: 'answering'

    waiting:
      onEnter: ->
        $('#answer').attr('disabled', 'disabled');
        $('.actions .check').addClass('disabled')
        $('.actions .next-step').addClass('disabled')
        $('.actions .show-next-word').addClass('disabled')
        $('.actions .look').addClass('disabled')
      events:
        answeredRight: 'rightAnswer'
        answeredWrong: 'wrongAnswer'
        error: 'error'

    error:
      onEnter: ->
        clearComments()
        $('.error.alert').removeClass('hide')

