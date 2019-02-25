=head1 NAME

InfluxDB2::FLUX - Experimental Perl Module to interact with InfluxData Flux API!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

InfluxDB2::FLUX allows you to interact with the FLUX API. The module is STILL under heavy development
and does not have much today. Only one InfluxDB2 FLUX API endpoint for C<health>.

    use InfluxDB2::FLUX;

    my $influx = InfluxDB2::FLUX->new();

    my $server_health = $influx->health();
    print "$server_health_result\n";

=head1 SUBROUTINES/METHODS

=head2 RETURN VALUES AND ERROR HANDLING

C<Object::Result> is relied upon for returning data from subroutines. The respective result
object can always be used as string and evaluated on a boolean basis. A result object
evaluating to false indicates an error and a corresponding error message is provided in the
attribute C<error>:

    my $health = $influx->health();
    print $health->error unless ($health);

Furthermore, all result objects provide access to the C<HTTP::Response> object that is returned
by InfluxDB2 in the attribute C<raw>.

=head2 new host => 'localhost', port => 9999

Passing C<host> and C<port> is optional, defaulting to the InfluxDB2 defaults.

Returns an instance of InfluxDB2::FLUX.

=head2 health

Health the InfluxDB2 instance configured in the constructor (i.e. by C<host> and C<port>).
