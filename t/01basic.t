use Test::More tests => 13;

BEGIN { use_ok('PerlIO::via::MD5') }

my $file = 't/test.md5';

is( PerlIO::via::MD5->method,'hexdigest',	'check default method' );

ok( open( my $in,'<:via(PerlIO::via::MD5)', $file ), "opening '$file' (hex)" );
is(
 scalar(<$in>),'d3410314beaba3aad299c3448f6e7ad1',
 'check digest in scalar context'
);
ok( close( $in ),			'close handle (hex)' );

is( PerlIO::via::MD5->method('b64digest'),'b64digest','check setting method' );
ok( open( my $in,'<:via(PerlIO::via::MD5)', $file ),"opening '$file' (base64)");
is( PerlIO::via::MD5->method('digest'),'digest','check setting method' );

is( <$in>,'00EDFL6ro6rSmcNEj2560Q',	'check digest in list context' );
ok( close( $in ),			'close handle (base64)' );

ok( open( my $in,'<:via(PerlIO::via::MD5)', $file ),"opening '$file' (binary)");
#open( my $out,">out" ); print {$out} <$in>; close( $out );
is( <$in>,'�A����ҙ�D�nz�',	'check digest in list context' );
ok( close( $in ),			'close handle (binary)' );