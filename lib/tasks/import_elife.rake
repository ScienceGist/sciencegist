namespace :elife do
  desc 'Imports all eLife executive summaries'
  task :import => :environment do

    page_num = 0
    page = Nokogiri::HTML(open("http://elife.elifesciences.org/browse?page=#{page_num}&keys=&sort=ds_created%20asc&rows=100&filters[0]=%2Bbm_field_highwire_a_subcomponent%3Afalse&filters[1]=%2Bbundle%3Ahighwire_article&path=browse"))

    results = []
    no_more_results = false

    while no_more_results == false
      page.css('.elife-searchlist-results .highwire-article-citation').each do |paper|
        results += [{
          doi: 'doi: ' + paper.css('div.highwire-cite-doi').first.text,
          tag_list: paper.css('.citation-cat-heading').map(&:text).join(', ')
        }]
      end
      page_num += 1
      page = Nokogiri::HTML(open("http://elife.elifesciences.org/browse?page=#{page_num}&keys=&sort=ds_created%20asc&rows=100&filters[0]=%2Bbm_field_highwire_a_subcomponent%3Afalse&filters[1]=%2Bbundle%3Ahighwire_article&path=browse"))
      if page.css('.elife-searchlist-results .highwire-article-citation').size == 0
        no_more_results = true
      end
    end

    elife_user = User.find_by_email!('staff@elifesciences.org')

    results.each_with_index do |paper, i|
      puts "Processing paper #{i}"
      existing_paper = Paper.find_by_identifier(paper[:doi])
      unless existing_paper
        paper_metadata = PaperMetadata::metadata_for(paper[:doi])
        gist = Gist.new
        gist.user = elife_user
        gist.paper = Paper.new(
          identifier: paper[:doi],
          title: paper_metadata[:title],
          authors: paper_metadata[:authors],
          journal: paper_metadata[:journal],
          tag_list: paper[:tag_list]
        )
        summary = PaperSummary::summary_for(paper[:doi])
        gist.content = summary[:summary_text]
        gist.content_html = summary[:summary_html]
        gist.imported_gist = true

        if gist.content.present?
          gist.save!
        else
          puts "Skipped importing paper without executive summary: #{paper[:doi]}"
        end
      end
    end
  end
end