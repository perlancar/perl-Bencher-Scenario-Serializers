package Bencher::Scenario::Serializers;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    participants => [
        {
            tags => ['json', 'serialize'],
            fcall_template => 'JSON::PP::encode_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::PP::decode_json(<data>)',
        },
        {
            tags => ['json', 'serialize'],
            fcall_template => 'JSON::XS::encode_json(<data>)',
        },
        {
            tags => ['json', 'serialize'],
            fcall_template => 'JSON::XS::decode_json(<data>)',
        },
        {
            tags => ['json', 'serialize'],
            fcall_template => 'JSON::MaybeXS::encode_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::MaybeXS::decode_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::Decode::Regexp::from_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::Decode::Marpa::from_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            code_template => 'state $obj = Pegex::JSON->new; $obj->load(<data>);',
        },
    ],

    datasets => [
        {
            name => 'undef',
            args => {data=>undef},
        },
        {
            name => 'num',
            summary => 'A single number (-1.23)',
            args => {data=>-1.23},
        },
        {
            name => 'str1k',
            summary => 'A string 1024-character long',
            args => {data=>'a' x 1024},
        },
        {
            name => 'array_int10',
            summary => 'A 10-element array containing ints',
            args => {data=>[1..10]},
        },
        # XXX more datasets
    ],
};

1;
# ABSTRACT: Benchmark Perl data serialization modules

=head1 SYNOPSIS

 % bencher -m Serializers [other options]...


=head1 TEMP

   'YAML::Old' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::Old::Dump($_[0]);
        },
        deserialize => sub {
            YAML::Old::Load($_[0]);
        },
    },

    'YAML::Syck' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::Syck::Dump($_[0]);
        },
        deserialize => sub {
            YAML::Syck::Load($_[0]);
        },
    },

    'YAML::XS' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::XS::Dump($_[0]);
        },
        deserialize => sub {
            YAML::XS::Load($_[0]);
        },
    },

    'Storable' => {
        tags => ['binary', 'core'],
        serialize => sub {
            Storable::freeze($_[0]);
        },
        deserialize => sub {
            Storable::thaw($_[0]);
        },
    },

    'Sereal' => {
        tags => ['binary'],
        serialize => sub {
            Sereal::encode_sereal($_[0]);
        },
        deserialize => sub {
            Sereal::decode_sereal($_[0]);
        },
    },

    'Data::MessagePack' => {
        tags => ['binary'],
        serialize => sub {
            state $obj = Data::MessagePack->new;
            $obj->pack($_[0]);
        },
        deserialize => sub {
            state $obj = Data::MessagePack->new;
            $obj->unpack($_[0]);
        },
    },
);


    ],
