#!/usr/bin/perl

use warnings;
use strict;

my $news_feed = `curl https://www.archlinux.org/feeds/news/ 
2>/dev/null`;
$news_feed =~ s/\n//g;
my @titles = ();
while ($news_feed =~ m/<item>.*?<title>(.*?)<\/title>.*?<\/item>/g)
{
    push @titles,$1;
}
my $n = $ARGV[0];
if (defined($n) and $n !~ m/\D/ and $n > 0)
{
    @titles = @titles[0..$ARGV[0]-1];
}
print join "\n",@titles;
