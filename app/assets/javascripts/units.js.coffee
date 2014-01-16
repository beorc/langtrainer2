ns = initNamespaces('SITEMPLATE.units')

ns.currentStep = null

ns.rollBox = (path) ->
  stepId = ns.currentStep.data('id')
  $.ajax
    url: path
    data:
      course_id: gon.course_id
      step_id: stepId
    type: 'put'
    dataType: 'json'

ns.notifyStatistics = (path) ->
  $.ajax
    url: path
    data:
      unit_statistic_id: gon.unit_statistic_id
    type: 'put'
    dataType: 'json'
    success: (data) ->
      $('.statistics').replaceWith(data.markup)

ns.rollStep = () ->
  ns.currentStep = ns.currentStep.next()

  if ns.currentStep.length == 0
    ns.currentStep = $('.steps .step:first')

  template = $('.template').empty()
  ns.currentStep.clone().appendTo template

  ns.answerInput().val ''

ns.answerInput = ->
  $('#answer')

ns.init = () ->
  ns.currentStep = $('.steps .step:first')

  enableCommitButton = ->
    $('.actions a.check').removeClass('disabled')

  disableCommitButton = ->
    $('.actions a.check').addClass('disabled')

  answerCommited = ->
    $('.actions a.next-step').removeClass('disabled')
    ns.rollBox(gon.box_up_path)
    ns.notifyStatistics(gon.right_answer_path)
    ns.rollStep()

  answerNotCommited = ->
    ns.rollBox(gon.box_down_path)
    ns.notifyStatistics(gon.wrong_answer_path)

  commitAnswer = ->
    input = ns.answerInput()
    regexpString = ns.currentStep.data('regexp')
    answer = input.val()
    if regexpString && regexpString.length > 0
      if answer.match(regexpString, 'i')
        answerCommited()
      else
        answerNotCommited()
    else
      rightAnswer = ns.currentStep.data('translation')
      if rightAnswer.match("^#{answer}", 'i') and rightAnswer.length == answer.length
        answerCommited()
      else
        answerNotCommited()

  verifyAnswer = ->
    input = ns.answerInput()
    answer = input.val()
    rightAnswer = ns.currentStep.data('translation')
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
    if !$(@).hasClass('disabled')
      commitAnswer()
    false

  $('.look').click ->
    rightAnswer = ns.currentStep.data('translation')
    ns.answerInput().removeClass('wrong').removeClass('right')
    ns.answerInput().val(rightAnswer)
    ns.rollBox(gon.box_down_path)
    ns.notifyStatistics(gon.step_helped_path)
    false

  $('.show-next-word').click ->
    rightAnswer = ns.currentStep.data('translation')
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
    ns.notifyStatistics(gon.word_helped_path)
    false

  $('.actions a.next-step').click () ->
    if !$(@).hasClass('disabled')
      ns.rollStep()
      ns.notifyStatistics(gon.step_passed_path)
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

  $('select#course').change () ->
    option = $(@).find('option:selected')
    url = option.data('path')
    window.location = url

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

