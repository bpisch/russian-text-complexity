use utf8;
use Encode;
use open ':std', ':encoding(UTF-8)';

use strict;
use warnings;

# Stała nazwa pliku wejściowego
my $input_file = 'temp_temp_rus.txt';

# Otwieranie plików
open my $in, '<', $input_file or die "Cannot open $input_file: $!";
open my $out, '>', $ARGV[0] or die "Cannot open $ARGV[0]: $!";

# Wczytujemy cały plik jako jeden ciąg znaków
local $/;  
my $text = <$in>;

# Zamieniamy przypadki: myślnik, spacja i nowa linia w stylu Windows
$text =~ s/^([\-\–\—]) \r?\n/$1 /mg;
$text =~ s/\r?\n([\-\–\—]) ([abcdefghijklmnopqrstuvwxyząćęłńóśźżşáâäçéëíôöřüабвгдеёжзийклмнопрстуфхцчшщэюя])/ $1 $2/mg;
$text =~ s/^ ([\-\–\—]) \r?\n/$1 /mg;
$text =~ s/ +(\r?\n)/$1/mg;

# Zapisujemy wynik
print $out $text;

close $in;
close $out;
