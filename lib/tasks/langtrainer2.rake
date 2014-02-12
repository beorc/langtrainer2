# rake langtrainer2:move_sentences

namespace :langtrainer2 do
  desc 'Moves sentences from database of previous version of langtrainer'
  task move_sentences: :environment do
    client = Mysql2::Client.new host: 'localhost',
                                username: 'root',
                                password: 'root',
                                database: 'langtrainer_dev'
    client.query('SELECT id, slug FROM exercises where id < 15').each do |exercise|
      course = Course.first
      slug = exercise['slug']
      puts "Processing exercise '#{slug}'..."
      unit = course.units.where(slug: slug, course_id: course.id).first_or_initialize
      unit.title = slug
      unit.save!

      client.query("SELECT * FROM sentences WHERE exercise_id = #{exercise['id']}").each do |sentence|
        puts "Processing step '#{sentence['en']}'..."
        unit.steps.create ru: sentence['ru'],
                          en: sentence['en'],
                          es: sentence['es']
      end
    end
  end

  desc 'Creates snapshots of unit advances'
  task create_snapshots: :environment do
    UnitAdvance.where('updated_at >= ?', Date.today).each do |a|
      a.create_snapshot!
    end
  end
end
