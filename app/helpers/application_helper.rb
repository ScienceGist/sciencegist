module ApplicationHelper
  def load_typekit
    '<script type="text/javascript" src="//use.typekit.net/stn4qyl.js"></script>
     <script type="text/javascript">try{Typekit.load();}catch(e){}</script>'.html_safe
  end
end
