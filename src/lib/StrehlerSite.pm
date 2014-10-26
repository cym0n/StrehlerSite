package StrehlerSite;
use Dancer2;
use StrehlerSite::Element::MarkdownArticle;

our $VERSION = '1.0';

set layout => 'main';

get '/' => sub {
    my $news = StrehlerSite::Element::MarkdownArticle->get_last_by_date('news', 'en');
    my %news_data = ();
    if($news)
    {
        %news_data = $news->get_ext_data('en');
    }
    my $release = StrehlerSite::Element::MarkdownArticle->get_last_by_date('releases', 'en');
    my %release_data = ();
    if($release)
    {
        %release_data = $release->get_ext_data('en');
    }
    template 'index', { adhoc_stylesheet => 'homepage', 
                        news => \%news_data,
                        release => \%release_data,
                        page_title => "Strehler CMS - A light-weight, nerdy, smart CMS in perl based on Perl Dancer2 framework",
                        page_description => "Design your sites with Perl Dancer2 Framework and add to them a user friendly backend with no effort"
                };
};
get '/about' => sub {
    template 'about', { page_title => "Strehler CMS - What is it?",
                        page_description => "A briefly description of Strehler and what it will do to you after installation" };
};
get '/news' => sub {
    my $page = params->{page} || 1;
    my $releases = StrehlerSite::Element::MarkdownArticle->get_list({ entries_per_page => -1, category => 'releases', language => 'en', ext => 1, published => 1, order => 'desc', order_by => 'publish_date'});
    my $news = StrehlerSite::Element::MarkdownArticle->get_list({ entries_per_page => 4, category => 'news', language => 'en', ext => 1, published => 1, order => 'desc', order_by => 'publish_date', page => $page});
    template 'news', { adhoc_stylesheet => 'blog', 
                       releases => $releases->{'to_view'},
                       news => $news->{'to_view'},
                       page => $page,
                       last_page => $news->{'last_page'},
                       page_title => "Strehler CMS - News",
                       page_description => "Latest news about Strehler development"
                     };
};
get '/todo' => sub {
    my $todo = StrehlerSite::Element::MarkdownArticle->get_list({ entries_per_page => -1, category => 'todo', language => 'en', ext => 1, published => 1, order => 'asc', order_by => 'display_order'});
    template 'todo', { todo => $todo->{'to_view'},
                       page_title => "Strehler CMS - TODO",
                       page_description => "All the evolutions that still need work. Collaborate!" };
};
get '/users-manual' => sub {
    template 'underconstruction', 
             { adhoc_stylesheet => 'homepage', 
               sitecolor => 'yellow',
               title => "USER'S MANUAL",
               subtitle => 'See it on GitHub Wiki <a href="https://github.com/cym0n/strehler/wiki/interface">here</a>',
               page_title => "Strehler CMS - User's manual",
               page_description => "This page is under construction"  };
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
