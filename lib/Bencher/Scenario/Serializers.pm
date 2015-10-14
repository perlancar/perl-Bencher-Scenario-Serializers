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
            module => 'JSON::PP',
            function => 'encode_json',
            code_template => 'state $json = JSON::PP->new->allow_nonref; $json->encode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            module => 'JSON::PP',
            function => 'decode_json',
            code_template => 'state $json = JSON::PP->new->allow_nonref; $json->decode(<data>)',
        },
        {
            tags => ['json', 'serialize'],
            module => 'JSON::XS',
            function => 'encode_json',
            code_template => 'state $json = JSON::XS->new->allow_nonref; $json->encode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            module => 'JSON::XS',
            function => 'decode_json',
            code_template => 'state $json = JSON::XS->new->allow_nonref; $json->decode(<data>)',
        },
        {
            tags => ['json', 'serialize'],
            module => 'JSON::MaybeXS',
            function => 'encode_json',
            code_template => 'state $json = JSON::MaybeXS->new(allow_nonref=>1); $json->encode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            module => 'JSON::MaybeXS',
            function => 'decode_json',
            code_template => 'state $json = JSON::MaybeXS->new(allow_nonref=>1); $json->decode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::Decode::Regexp::from_json(<data>)',
        },
        {
            tags => ['json', 'deserialize', 'cant_handle_scalar'],
            fcall_template => 'JSON::Decode::Marpa::from_json(<data>)',
        },
        {
            name => 'Pegex::JSON',
            tags => ['json', 'deserialize'],
            module => 'Pegex::JSON',
            code_template => 'state $obj = Pegex::JSON->new; $obj->load(<data>);',
        },
    ],

    datasets => [
        {
            name => 'undef',
            summary => 'undef',
            args => {data=>undef},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'num',
            summary => 'A single number (-1.23)',
            args => {data=>-1.23},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'str1k',
            summary => 'A string 1024-character long',
            args => {data=>'a' x 1024},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'array_int10',
            summary => 'A 10-element array containing ints',
            args => {data=>[1..10]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },

        {
            name => 'json:null',
            summary => 'null',
            args => {data=>'null'},
            tags => ['deserialize'],
            include_participant_tags => ['deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'json:num',
            summary => 'A single number (-1.23)',
            args => {data=>-1.23},
            tags => ['deserialize'],
            include_participant_tags => ['deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'json:str1k',
            summary => 'A string 1024-character long',
            args => {data=>'"' . ('a' x 1024) . '"'},
            tags => ['deserialize'],
            include_participant_tags => ['deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'json:array_int10',
            summary => 'A 10-element array containing ints',
            args => {data=>'[1,2,3,4,5,6,7,8,9,10]'},
            tags => ['deserialize'],
            include_participant_tags => ['deserialize'],
        },
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
