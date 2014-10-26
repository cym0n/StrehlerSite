#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use StrehlerSite;
use Strehler::Admin;

StrehlerSite->dance;
