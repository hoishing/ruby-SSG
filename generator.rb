# encoding: utf-8

require 'plist'

class Generator
  attr_accessor :content
  def initialize(lang=:zh)
    @template_var = prepare_locale(lang)
    @template = File.open("template.htm").read
    @books = Plist::parse_xml(lang.to_s + '_books.plist')
    @chants = Plist::parse_xml(lang.to_s + '_chants.plist')
    @content = ''
    @op = ''
    parse
    write_file(lang)
  end
  
  def prepare_locale(lang)
    urls = {
      zh: 'http://audio.fbm.hk/buddhaAudio/',
      cn: 'http://audio.menic2.com/buddhaAudioSC/'
    }
    @base_url = urls[lang]

    locale_set = {
      zh: ['認識佛教', '粵語有聲書', '講經說法', '讀誦持名', '歡迎複製流通　功德無量'],
      cn: ['认识佛教', '有声书系列', '讲经说法', '读诵持名', '欢迎复制流通　功德无量']
    }
    locale_title = [:title, :sub_title, :books_header, :chants_header, :footer]
    Hash[locale_title.zip(locale_set[lang])]
  end

  def parse
    nav_list = ''
    {books_header: @books, chants_header: @chants}.each do |header, plist|
      nav_list += '<li class="nav-header">'+ @template_var[header] +"</li>\n"
      plist.each do |audio|
        chi_name = audio['ChiFolderName']
        nav_list += "<li><a href='##{chi_name}'><i class='icon-chevron-right'></i>#{chi_name}</a></li>\n"
        prepare_content(audio, chi_name)
      end
    end
    @template_var[:nav_list] = nav_list
    @template_var[:content] = @content

    @op = @template.gsub(/@(\w*)/) do
      @template_var[$1.to_sym]
    end
  end

  def prepare_content(audio, chi_name)
    book = audio['EngFolderName']
    chapters = audio['chapters']
    @content += "<a name='#{chi_name}'></a><h3>#{chi_name}</h3>\n"
    @content += "<p>#{audio['author']}</p><hr>\n"
    @content += '<table id="content-tb" class="table table-striped table-bordered">' + "\n"
    i = 0
    while i < chapters.size
      @content += '<tr>'
      for j in 0..2
        if chapter = chapters[i]
          suffix = chapter['EngSuffix']
          url = @base_url + "#{book}/#{book}" + suffix
          display_name = suffix.sub(/^-/, '')
          @content += "<td><a href='#{url}'>#{display_name}</a></td>"          
        else
          @content +='<td>&nbsp;</td>'
        end
        i += 1
      end
      @content += "</tr>\n"
    end
    @content += "</table>\n"
  end

  def write_file(lang)
    filename = 'index_' + lang.to_s + '.htm'
    File.open(filename, "w") { |file| file.write(@op) }
  end

end


Generator.new(:zh)
Generator.new(:cn)

