#!/usr/bin/perl

use InfluxDB2::FLUX;

my $influx = InfluxDB2::FLUX->new();

my $health_result = $influx->health();
print "$health_result\n";
print $health->raw if ($health);
