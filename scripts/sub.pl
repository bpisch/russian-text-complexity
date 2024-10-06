use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

open (FILE, "$ARGV[0]") or die("$ARGV[0] not found");
open (OUTFILE, ">$ARGV[1]") || die "Cannot open $ARGV[0] for append $!\n";

while (<FILE>) {

s/ /\n/g;
s/\n\n/\n/g;
s/(\[[0-9]+\])//g;
s/(\{[0-9]+\})//g;
s/[\!\'\(\)\,\.\:\;\?\[\]\{\}\«\»\–\—\“\„\…\№]//g;
s/ё/е/g;
s/Ё/е/g;
s/А/а/g;
s/Б/б/g;
s/В/в/g;
s/Г/г/g;
s/Д/д/g;
s/Е/е/g;
s/Ж/ж/g;
s/З/з/g;
s/И/и/g;
s/Й/й/g;
s/К/к/g;
s/Л/л/g;
s/М/м/g;
s/Н/н/g;
s/О/о/g;
s/П/п/g;
s/Р/р/g;
s/С/с/g;
s/Т/т/g;
s/У/у/g;
s/Ф/ф/g;
s/Х/х/g;
s/Ц/ц/g;
s/Ч/ч/g;
s/Ш/ш/g;
s/Щ/щ/g;
s/Ъ/ъ/g;
s/Ы/ы/g;
s/Ь/ь/g;
s/Э/э/g;
s/Ю/ю/g;
s/Я/я/g;

my $new_list = "";
foreach my $line (split /\n/, $_) {
if ($line =~ m/^[абвгдежзийклмнопрстуфхцчшщъыьэюя\-]*$/) {
$new_list .= $line . "\n";
}
}
print OUTFILE "$new_list" ;
}

