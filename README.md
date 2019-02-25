# InfluxDB2::FLUX - Perl Mod to interact with InfluxData2.0


## Not ready for production yet!

InfluxDB2::FLUX module allows you to interact with the FLUX API. The module is STILL
under heavy development. and does not have much today. Only one InfluxDB2 FLUX API
endpoint for <health>.


## INSTALLATION

To install this module, run the following commands:

	perl Makefile.PL
	make
	make test
	make install

## SYNOPSIS

Passing <host> and <port> is optional, defaulting to the InfluxDB2 defaults. Returns
an instance of InfluxDB2::FLUX.

```
    use InfluxDB2::FLUX;

    my $influx = InfluxDB2::FLUX->new();

    my $server_health = $influx->health();
    print "$server_health_result\n";

```
