Redmine::Plugin.register :sql_report do
  name 'Sql Report plugin'
  author 'Yasuyuki Suzuki'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/ysuzukisra/redmine-sql_report'
  author_url 'https://github.com/ysuzukisra'
  
  menu :top_menu, :repo, { :controller => 'repo', :action => 'index'}
end
