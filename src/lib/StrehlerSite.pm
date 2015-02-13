package StrehlerSite;
use Dancer2;
use Strehler::Dancer2::Plugin::EX;
use Strehler::Element::Extra::Chapter;

our $VERSION = '1.0';

set layout => 'main';

hook before_template_render => sub {
        my $tokens = shift;
        $tokens->{'google_monitor'} = config->{'google_monitor'};
    };

latest_page '/', 'index', { news => { category => 'news' }, release => { category => 'releases' }},
    { adhoc_stylesheet => 'homepage', 
      page_title => "Strehler CMS - A light-weight, nerdy, smart CMS in perl based on Perl Dancer2 framework",
      page_description => "Design your sites with Perl Dancer2 Framework and add to them a user friendly backend with no effort"
    };

get '/about' => sub {
    template 'about', { page_title => "Strehler CMS - What is it?",
                        page_description => "A briefly description of Strehler and what it will do to you after installation" };
};

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
                       page_description => "Latest news about Strehler development"
                     };
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
             { adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Entities",
               page_description => "How to create contents"  };
};
get '/users-manual/list' => sub {
    template 'user-manual-list', 
             { adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - List",
               page_description => "Page that list all contents"  };
};
get '/users-manual/categories' => sub {
    template 'user-manual-categories', 
             { adhoc_stylesheet => 'homepage', 
               page_title => "Strehler CMS - User's manual - Categories",
               page_description => "Categories management"  };
};



get '/tech-manual' => sub {
    template 'underconstruction', 
             { adhoc_stylesheet => 'homepage', 
               sitecolor => 'yellow',
               title => "TECH MANUAL",
               subtitle => 'Find many hints about developing with Strehler on the <a href="https://github.com/cym0n/strehler/wiki">GitHub Wiki</a>',
               page_title => "Strehler CMS - Tech Manual",
               page_description => "This page is under construction" };
};


true;
