SitemplateCore.setup do |config|
  # Роль :admin существует по-умолчанию, поэтому нижеследующий код стоит раскомментировать
  # только в случае добавления новых ролей
  #
  # config.roles = [ { id: 0, slug: :admin } ]
end

admin_sidebar_groups = {
  content: {
    items: [
      {
        title: "activerecord.models.course.few",
        url_helper: 'admin_courses_path'
      },
      {
        title: "activerecord.models.unit.few",
        url_helper: 'admin_units_path'
      },
      {
        title: "activerecord.models.step.few",
        url_helper: 'admin_steps_path'
      },
      {
        title: "activerecord.models.step_mapping.few",
        url_helper: 'admin_step_mappings_path(course: Course.first)'
      },
      {
        title: "activerecord.models.useful_link.few",
        url_helper: 'admin_useful_links_path'
      }
    ]
  }
}

SitemplateCore.fetch_sidebar_configuration admin_sidebar_groups

#
# Добавление пунктов меню в сайдбар админки просиходит примерно следующим образом.
# По дефолту есть два пункта:
#   1. content(содержимое) - сюда надо добавлять, все что настраивается в админке,
#      города, офисы, страниицы, статьи.
#   2. management(управление сайтом) - сюда надо добавлять все, что генерируют пользователи.
#      заявки, feedback,  различные настройки, изменяющие работу сайта в рантайме.
#
# Так же, возможно sitemplate_store будет добавлять свою собственную категорию.
#
#
# Пример:
# ------------------------------------------------------------------------------------------
# admin_sidebar_groups = {
#   content: {
#     items: [
#       {
#         title: "activerecord.models.article.few",
#         url_helper: 'admin_articles_path'
#       }
#     ]
#   },
#   store: {
#     title: 'sitemplate_store.admin.sidebar.store.title',
#     icon: 'icon-barcode',
#     position: 2,
#     items: [
#       {
#         title: "activerecord.models.earphone.few",
#         url_helper: 'admin_earphones_path'
#       }
#     ]
#   }
# }
# SitemplateCore.fetch_sidebar_configuration admin_sidebar_groups

