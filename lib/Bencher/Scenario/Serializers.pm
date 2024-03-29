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
            module => 'JSON::Tiny',
            function => 'encode_json',
            code_template => 'JSON::Tiny::encode_json(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            module => 'JSON::Tiny',
            function => 'decode_json',
            code_template => 'JSON::Tiny::decode_json(<data>)',
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
            tags => ['json', 'deserialize'],
            fcall_template => 'PERLANCAR::JSON::Match::match_json(<data>)',
            include_by_default => 0,
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
            tags => ['json', 'serialize'],
            fcall_template => 'MarpaX::ESLIF::ECMA404->encode(<data>)',
        },
        {
            tags => ['json', 'deserialize'],
            fcall_template => 'MarpaX::ESLIF::ECMA404->decode(<data>)',
        },

        {
            tags => ['yaml', 'serialize'],
            fcall_template => 'YAML::Dump(<data>)',
        },
        {
            tags => ['yaml', 'deserialize'],
            fcall_template => 'YAML::Load(<data>)',
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
            tags => ['binary', 'storable', 'serialize', 'cant_handle_scalar'],
            fcall_template => 'Storable::freeze(<data>)',
        },
        {
            tags => ['binary', 'storable', 'deserialize', 'cant_handle_scalar'],
            fcall_template => 'Storable::thaw(<data>)',
        },

        {
            tags => ['binary', 'sereal', 'serialize'],
            fcall_template => 'Sereal::encode_sereal(<data>)',
        },
        {
            tags => ['binary', 'sereal', 'deserialize'],
            fcall_template => 'Sereal::decode_sereal(<data>)',
        },

        {
            name => 'Data::MessagePack::pack',
            tags => ['binary', 'msgpack', 'serialize'],
            module => 'Data::MessagePack',
            function => 'pack',
            code_template => 'state $obj = Data::MessagePack->new; $obj->pack(<data>)',
        },
        {
            name => 'Data::MessagePack::unpack',
            tags => ['binary', 'msgpack', 'deserialize'],
            module => 'Data::MessagePack',
            function => 'unpack',
            code_template => 'state $obj = Data::MessagePack->new; $obj->unpack(<data>)',
        },

        {
            name => 'eval()',
            tags => ['perl', 'deserialize'],
            code_template => 'eval(<data>)',
        },
        {
            name => 'Data::Undump',
            tags => ['perl', 'deserialize'],
            fcall_template => 'Data::Undump::undump(<data>)',
        },
        {
            name => 'Data::Undump::PPI',
            tags => ['perl', 'deserialize'],
            fcall_template => 'Data::Undump::PPI::Undump(<data>)',
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
            summary => 'A non-Unicode string 1024 characters/bytes long',
            args => {data=>'a' x 1024},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
            exclude_participant_tags => ['cant_handle_scalar'],
        },
        {
            name => 'str1k',
            summary => 'A Unicode string 1024 characters (3072-bytes) long',
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
            summary => 'A 10-element array containing 1024-characters/bytes-long non-Unicode strings',
            args => {data=>[('a' x 1024) x 10]},
            tags => ['serialize'],
            include_participant_tags => ['serialize'],
        },
        {
            name => 'array_ustr1k_10',
            summary => 'A 10-element array containing 1024-characters-long (3072-bytes long) Unicode strings',
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
            summary => 'A non-Unicode (ASCII) string 1024-characters/bytes long',
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
            summary => 'A 10-element array containing 1024-characters/bytes-long non-Unicode strings',
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

        {
            name => 'sereal:hash_int_100',
            summary => 'A 100-key hash {1=>0, ..., 100=>0}',
            args => {data=>"=\xF3rl\3\0(*db26\0b63\0b95\0b35\0b13\0b41\0b33\0b73\0b84\0b85\0b94\0b24\0b12\0b72\0b99\0b71\0a6\0b64\0b70\0b50\0b83\0b68\0a8\0b15\0a9\0a5\0b67\0b25\0b10\0a4\0b56\0b89\0b16\0b90\0b66\0b59\0b29\0b54\0b44\0b27\0b77\0b81\0b32\0b37\0b74\0b65\0b36\0b11\0b18\0b86\0a7\0b17\0b21\0b14\0b28\0b47\0b20\0b76\0b98\0b40\0b91\0b75\0b97\0b31\0b55\0b80\0b19\0b92\0b82\0b43\0b30\0b78\0b57\0b38\0b23\0a3\0b69\0b88\0b61\0b51\0b39\0b42\0b58\0b93\0a2\0b62\0a1\0b79\0b34\0b45\0b87\0c100\0b96\0b22\0b49\0b60\0b52\0b53\0b46\0b48\0"},
            tags => ['deserialize'],
            include_participant_tags => ['sereal & deserialize'],
        },

        {
            name => 'perl:hash_int_100',
            summary => 'A 100-key hash {1=>0, ..., 100=>0}',
            args => {data=>'{'.join(',', map {qq($_=>0)} 1..100).'}'},
            tags => ['deserialize'],
            include_participant_tags => ['perl & deserialize'],
        },
    ],
};

1;
# ABSTRACT:
