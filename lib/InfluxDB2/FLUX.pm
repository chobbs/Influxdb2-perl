package InfluxDB2::FLUX;

use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = ();
our @EXPORT    = ();

use JSON::MaybeXS;
use LWP::UserAgent;
use Object::Result;
use URI;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my %args = (
        host => 'localhost',
        port => 9999,
        timeout => 180,
        @_,
    );
    my ($host, $port, $timeout) = @args{'host', 'port', 'timeout'};

    my $self = {
        host => $host,
        port => $port,
    };

    my $ua= LWP::UserAgent->new();
    $ua->agent("InfluxDB2-FLUX/$VERSION");
    $ua->timeout($timeout);
    $self->{lwp_user_agent} = $ua;

    bless $self, $class;

    return $self;
}

sub get_lwp_useragent {
    my ($self) = @_;
    return $self->{lwp_user_agent};
}

sub health {
    my ($self) = @_;
    my $uri = $self->_get_influxdb_flux_api_uri('health');
    my $response = $self->{lwp_user_agent}->head($uri->canonical());

    if (! $response->is_success()) {
        my $error = $response->message();
        result {
                raw    { return $response; }
                error  { return $error; }
                <STR>  { return "Error checking server health of InfluxDB2: $error"; }
                <BOOL> { return; }
        }
    }

    my $pass = $response->message();
    result {
            raw     { return $response; }
            <STR>   { return "Health successful: $pass"; }
            <BOOL>  { return 1; }
    }
}

sub _get_influxdb_flux_api_uri {
    my ($self, $endpoint) = @_;

    die "Missing argument 'endpoint'" if !$endpoint;

    my $uri = URI->new();

    $uri->scheme('http');
    $uri->host($self->{host});
    $uri->port($self->{port});
    $uri->path($endpoint);

    return $uri;
}

1;

__END__

=head1 NAME

InfluxDB2::FLUX - The Perl way to interact with InfluxDB2!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

InfluxDB2::FLUX allows you to interact with the InfluxDB2 FLUX API. The module essentially provides
one method per InfluxDB2 FLUX API endpoint, that is C<health>.

    use InfluxDB::FLUX;

    my $influx = InfluxDB2::FLUX->new();

    my $health_result = $influx->health();
    print "$health_result\n";

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

=head2 new host => 'localhost', port => 9999, timeout => 600

Passing C<host>, C<port> and/or C<timeout> is optional, defaulting to the InfluxDB defaults or
to 3 minutes for the timeout. The timeout is in seconds.

Returns an instance of InfluxDB2::FLUX.

=head2 health

Health the InfluxDB2 instance configured in the constructor (i.e. by C<host> and C<port>).

Returned object evaluates to pass or fail depending on whether the health was successful or not.
If pass, then it contains a C<message> attribute that indicates the health  of
the server.

    my $health = $influx->health();

=head2 get_lwp_useragent

Returns the internally used LWP::UserAgent instance for possible modifications
(e.g. to configure an HTTP proxy).

=head1 AUTHOR

Craig Hobbs, C<< <chobbs10@me.com> >>
