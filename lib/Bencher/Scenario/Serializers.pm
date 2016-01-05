package Bencher::Scenario::Serializers;

# DATE
# VERSION

use 5.010001;
use strict;
use utf8;
use warnings;

our $scenario = {
    summary => 'Benchmark Perl data serialization modules',
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
            module => 'Cpanel::JSON::XS',
            function => 'encode_json',
            code_template => 'state $json = Cpanel::JSON::XS->new->allow_nonref; $json->encode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            module => 'Cpanel::JSON::XS',
            function => 'decode_json',
            code_template => 'state $json = Cpanel::JSON::XS->new->allow_nonref; $json->decode(<data>)',
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
        {
            tags => ['json', 'serialize'],
            fcall_template => 'JSON::Create::create_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'JSON::Parse::parse_json(<data>)',
        },

        {
            tags => ['yaml', 'serialize'],
            fcall_template => 'YAML::Old::Dump(<data>)',
        },
        {
            tags => ['yaml', 'deserialize'],
            fcall_template => 'YAML::Old::Load(<data>)',
        },
        {
            tags => ['yaml', 'serialize'],
            fcall_template => 'YAML::Syck::Dump(<data>)',
        },
        {
            tags => ['yaml', 'deserialize'],
            fcall_template => 'YAML::Syck::Load(<data>)',
        },
        {
            tags => ['yaml', 'serialize'],
            fcall_template => 'YAML::XS::Dump(<data>)',
        },
        {
            tags => ['yaml', 'deserialize'],
            fcall_template => 'YAML::XS::Load(<data>)',
        },

        {
            tags => ['binary', 'serialize', 'cant_handle_scalar'],
            fcall_template => 'Storable::freeze(<data>)',
        },
        {
            tags => ['binary', 'deserialize', 'cant_handle_scalar'],
            fcall_template => 'Storable::thaw(<data>)',
        },

        {
            tags => ['binary', 'serialize'],
            fcall_template => 'Sereal::encode_sereal(<data>)',
        },
        {
            tags => ['binary', 'deserialize'],
            fcall_template => 'Sereal::decode_sereal(<data>)',
        },

        {
            name => 'Data::MessagePack::pack',
            tags => ['binary', 'serialize'],
            module => 'Data::MessagePack',
            function => 'pack',
            code_template => 'state $obj = Data::MessagePack->new; $obj->pack(<data>)',
        },
        {
            name => 'Data::MessagePack::unpack',
            tags => ['binary', 'deserialize'],
            module => 'Data::MessagePack',
            function => 'unpack',
            code_template => 'state $obj = Data::MessagePack->new; $obj->unpack(<data>)',
        },
    ],

    # XXX: add more datasets (larger data, etc)
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
            summary => 'A non-Unicode string 1024 bytes long',
            args => {data=>'a' x 1024},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'str1k',
            summary => 'A Unicode string 1024 bytes long',
            args => {data=>'我爱你爱你一辈子' x 128},
            tags => ['serialize', 'unicode'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },

        {
            name => 'array_int_10',
            summary => 'A 10-element array containing ints',
            args => {data=>[1..10]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'array_int_100',
            summary => 'A 100-element array containing ints',
            args => {data=>[1..100]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'array_int_1000',
            summary => 'A 1000-element array containing ints',
            args => {data=>[1..1000]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'array_str1k_10',
            summary => 'A 10-element array containing 1024-bytes-long non-Unicode strings',
            args => {data=>[('a' x 1024) x 10]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'array_ustr1k_10',
            summary => 'A 10-element array containing 1024-bytes-long Unicode strings',
            args => {data=>[('我爱你爱你一辈子' x 128) x 10]},
            tags => ['serialize', 'json'],
            include_participant_tags => ['serialize'],
        },

        {
            name => 'hash_int_10',
            summary => 'A 10-key hash {1=>0, ..., 10=>0}',
            args => {data=>{map {$_=>0} 1..10}},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'hash_int_100',
            summary => 'A 100-key hash {1=>0, ..., 100=>0}',
            args => {data=>{map {$_=>0} 1..100}},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'hash_int_1000',
            summary => 'A 1000-key hash {1=>0, ..., 1000=>0}',
            args => {data=>{map {$_=>0} 1..1000}},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },

        {
            name => 'json:null',
            summary => 'null',
            args => {data=>'null'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'json:num',
            summary => 'A single number (-1.23)',
            args => {data=>-1.23},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'json:str1k',
            summary => 'A non-Unicode (ASCII) string 1024-byte long',
            args => {data=>'"' . ('a' x 1024) . '"'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },

        {
            name => 'json:array_int_10',
            summary => 'A 10-element array containing ints',
            args => {data=>'['.join(',',1..10).']'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
        {
            name => 'json:array_int_100',
            summary => 'A 10-element array containing ints',
            args => {data=>'['.join(',',1..100).']'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
        {
            name => 'json:array_int_1000',
            summary => 'A 1000-element array containing ints',
            args => {data=>'['.join(',',1..1000).']'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
        {
            name => 'json:array_str1k_10',
            summary => 'A 10-element array containing 1024-bytes-long non-Unicode strings',
            args => {data=>'['.join(',',(('"'.('a' x 1024).'"') x 10)).']'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },

        {
            name => 'json:hash_int_10',
            summary => 'A 10-key hash {"1":0, ..., "10":0}',
            args => {data=>'{'.join(',', map {qq("$_":0)} 1..10).'}'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
        {
            name => 'json:hash_int_100',
            summary => 'A 100-key hash {"1":0, ..., "100":0}',
            args => {data=>'{'.join(',', map {qq("$_":0)} 1..100).'}'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
        {
            name => 'json:hash_int_1000',
            summary => 'A 1000-key hash {"1":0, ..., "1000":0}',
            args => {data=>'{'.join(',', map {qq("$_":0)} 1..1000).'}'},
            tags => ['deserialize'],
            include_participant_tags => ['json & deserialize'],
        },
    ],
};

1;
# ABSTRACT:
