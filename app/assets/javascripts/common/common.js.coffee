$ ->
  $('[data-toggle="tooltip"]').each ->
    options = {}
    placement = $(@).data('placement')
    options.placement = placement if placement

    $(@).tooltip(options)

  languageSelector = $('.modal.language-selector-modal')
  if languageSelector.length == 1
    options = {
                keyboard: false
                backdrop: 'static'
                show: true
              }

    languageSelector.removeClass('hidden').modal(options)


