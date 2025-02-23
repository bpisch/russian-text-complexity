use utf8;
use Encode;
use open ':std', ':encoding(UTF-8)';

# Sprawdź, czy podano argumenty
if (@ARGV < 1) {
    die "Użycie: perl split_sentences.pl <input.txt>\n";
}

my $input_file = $ARGV[0];
my $output_file = "temp_temp_rus.txt";  # Stała nazwa pliku wyjściowego

open FILE, $input_file or die "Nie można otworzyć pliku: $input_file\n";
open OUTPUT, '>', $output_file or die "Nie można utworzyć pliku: $output_file\n";

$abbr_dot = "^[\`\'\"\‚\/\(\\\[\{\<\§\‹\«\»\›\…\©\“\„\”\’\‘\°\´]*(A|B|C|D|E|F|G|H|I|II|III|J|K|L|M|N|O|Op|P|Q|R|S|T|U|V|W|X|Y|d|e|etc|m|n|А|Автореф|Б|В|Вопр|Г|Д|Е|Ж|З|Зам|И|Избр|К|Канд|Л|М|Матф|Моск|Н|О|Оп|П|Пер|Полн|Прим|Примеч|Р|Рис|Рос|Рус|С|СПб|Сб|Св|См|Соб|Собр|Сов|Ср|Ст|Стр|Т|У|Указ|Ф|Х|Ц|Цит|Ч|Ш|Э|Ю|Я|абс|авг|ак|англ|ар|арм|арт|б|биол|быв|в|вв|вел|веч|внутр|вод|воен|вост|вступ|вып|выс|г|гв|гв|ген|геогр|гл|гос|гр|д|дек|дес|див|дисс|докт|дол|долл|дор|др|е|ед|ж|жел|з|зав|зам|зап|и|изд|изм|им|ин|иностр|испр|ист|ит|их|к|кав|каз|канд|кар|кат|кб|кв|кн|ком|конф|коп|кр|креп|куб|л|м|мат|математич|мед|мес|мил|милл|мин|минер|мл|млн|млрд|мм|мн|мол|н|напр|нар|наст|науч|нач|неск|ниж|нов|о|об|обл|окт|опубл|отв|отд|оч|п|пед|пер|пех|пог|подп|пом|пос|посл|поч|пр|практ|пред|преп|пресв|прим|примеч|проц|проч|психол|р|ред|реш|рис|род|рт|руб|рус|с|саж|сб|св|сев|сек|сер|сл|след|см|соб|собр|сов|соц|соч|спец|ср|ст|стол|стр|т|т\.е|табл|тел|телеф|техн|тов|тыс|у|уд|ул|ум|ур|уч|ушир|ф|физ|филос|фр|франц|х|хим|хоз|хор|ц|цит|ч|чайн|чел|ш|шт|э|экз|экон|ю|юж|юр|юрид|яз)\\.\$";

$sentence = "";
$last_word_ended = 0;
$last_word_num = 0;

while($line = <FILE>)
{
  chop($line);
  if($line ne "")
  {
    @words = split(/\s+/, $line);
    foreach(@words)
    {
      if($last_word_ended and not /^[\`\'\"\‚\/\\\[\{\<\§\‹\«\»\›\…\©\“\„\”\’\‘\°\´]*[a-ząćęłńóśźżşáâäçéëíôöřüабвгдеёжзийклмнопрстуфхцчшщэюя\,\;\:\-\–\—]/ and not ($last_word_num and /^[0-9]/))
      {
        cut(); #end of sentence
      }

      put($_); 

      if(/([\.…!?:]|[\.…!?:][})\]])[\`\'\"\‚\/\(\\\[\{\<\§\‹\«\»\›\…\©\“\„\”\’\‘\°\´]*$/)
      {
        if($_ !~ /$abbr_dot/)
        {
          $last_word_ended = 1;
          if(/^[0-9]*[0-9][\.…!?:]$/)
          {
            $last_word_num = 1;
          }
          else
          {
            $last_word_num = 0;
          }
        }
        else
        {
          $last_word_ended = 0;
        }
      }
      else
      {
        if(not /^[\-\–\—]+$/)
        {
          $last_word_ended = 0;
        }
          $last_word_num = 0;
      }
    }
  }
  else
  {
    cut(); #end of paragraph
  }
}

cut(); #end of file

close(FILE);
close(OUTPUT);

sub cut
{
  if($sentence ne "")
  {
    # Usuń nadmiarowe spacje przed znakami interpunkcyjnymi
    $sentence =~ s/\s+([\.,;:!?])/$1/g;
    # Popraw formatowanie myślników
    $sentence =~ s/\s*\–\s*/ – /g;  # Dodaj spacje przed i po myślniku
    # Usuń niepotrzebne nowe linie przed myślnikiem
    $sentence =~ s/\n\s*\–\s*/ – /g;
    # Dodaj nową linię tylko po zakończeniu zdania
    $sentence =~ s/([\.…!?:])\s*–\s*/$1\n– /g;
    # Usuń nowe linie po myślniku, jeśli następuje po nim tekst
    $sentence =~ s/\–\s*\n\s*/– /g;
    print OUTPUT $sentence . "\n";
  }
  $sentence = "";
}

sub put
{
  $sentence = $sentence . $_[0] . " ";
}
