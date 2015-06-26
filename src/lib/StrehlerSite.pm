package StrehlerSite;
use Dancer2;
use Strehler::Dancer2::Plugin::EX;
use Strehler::Element::Extra::Chapter;
use Strehler::Element::RSS::RSSChannel;

our $VERSION = '1.0';

set layout => 'main';

hook before_template_render => sub {
        my $tokens = shift;
        $tokens->{'google_monitor'} = config->{'google_monitor'};
        $tokens->{'DOMAIN'} = config->{'domain'};
    };

latest_page '/', 'index', { news => { category => 'news' }, release => { category => 'releases' }},
    { adhoc_stylesheet => 'homepage', 
      page_title => "Strehler CMS - A light-weight, nerdy, smart CMS in perl based on Perl Dancer2 framework",
      page_description => "Design your sites with Perl Dancer2 Framework and add to them a user friendly backend with no effort",
      rss_release => Strehler::Element::RSS::RSSChannel->get_link("chapter", "releases"),  
      rss_news => Strehler::Element::RSS::RSSChannel->get_link("chapter", "news"),  
      disqus => 1
    };

get '/about' => sub {
    template 'about', { page_title => "Strehler CMS - What is it?",
                        page_description => "A briefly description of Strehler and what it will do to you after installation" };
};
slug  '/news/:slug', 'news-post', { 'item-type' => 'chapter', category => 'news' }, 
                                  { adhoc_stylesheet => 'blog', 
                                    slugged => 1
                                  };;



get '/news' => sub {
    my $page = params->{page} || 1;
    my $releases = Strehler::Element::Extra::Chapter->get_list({ entries_per_page => 6, category => 'releases', language => 'en', ext => 1, published => 1, order => 'desc', order_by => 'publish_date'});
    my $news = Strehler::Element::Extra::Chapter->get_list({ entries_per_page => 4, category => 'news', language => 'en', ext => 1, published => 1, order => 'desc', order_by => 'publish_date', page => $page});
    template 'news', { adhoc_stylesheet => 'blog', 
                       releases => $releases->{'to_view'},
                       news => $news->{'to_view'},
                       page => $page,
                       last_page => $news->{'last_page'},
                       page_title => "Strehler CMS - News",
                       page_description => "Latest news about Strehler development",
                       rss_release => Strehler::Element::RSS::RSSChannel->get_link("chapter", "releases"),  
                       rss_news => Strehler::Element::RSS::RSSChannel->get_link("chapter", "news"),  
                       disqus => 1
                     };
};

get '/releases' => sub {
    return redirect '/news'
};
get '/releases/:slug' => sub {
    return redirect '/news'
};




list '/todo', 'todo', { category => 'todo', 'entries-per-page' => -1, order => 'asc' }, 
    { page_title => "Strehler CMS - TODO", 
      page_description => "All the evolutions that still need work. Collaborate!" };

list '/other-projects', 'others', { category => 'other-projects', 'entries-per-page' => -1, order => 'asc' }, 
    { page_title => "Strehler CMS - Other projects", 
      page_description => "Other projects related to Strehler" };

get '/users-manual' => sub {
    template 'user-manual-home', 
             { adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual",
               page_description => "Learn here tips about editing and content management"  };
};
get '/users-manual/entities' => sub {
    template 'user-manual-entities', 
             { adhoc_class => 'user-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Entities",
               page_description => "How to create contents"  };
};
get '/users-manual/list' => sub {
    template 'user-manual-list', 
             { adhoc_class => 'user-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - List",
               page_description => "Page that list all contents"  };
};
get '/users-manual/categories' => sub {
    template 'user-manual-categories', 
             { adhoc_class => 'user-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Categories",
               page_description => "Categories management"  };
};
get '/users-manual/dashboard' => sub {
    template 'user-manual-dashboard', 
             { adhoc_class => 'user-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Dashboard",
               page_description => "How to use the Dashboard"  };
};
get '/users-manual/users' => sub {
    template 'user-manual-users', 
             { adhoc_class => 'user-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Users",
               page_description => "Users management"  };
};

get '/tech-manual' => sub {
    template 'tech-manual-home', 
             { adhoc_class => 'tech-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - Tech manual",
               page_description => "A guide for developers that want to work with Strehler!"  };
};
get '/tech-manual/strehler-site-1' => sub {
    template 'tech-manual-strehler-site-1', 
             { adhoc_class => 'tech-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - Tech manual - The Strehler site Tutorial 1/2",
               page_description => "How Strehler site was built step by step - part 1"  };
};
get '/tech-manual/strehler-site-2' => sub {
    template 'tech-manual-strehler-site-2', 
             { adhoc_class => 'tech-manual',
               adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - Tech manual - The Strehler site Tutorial 2/2",
               page_description => "How Strehler site was built step by step - part 2"  };
};





true;
