#perl

use utf8;
use Encode;
use open ':std', ':encoding(UTF-8)';

open FILE, @ARGV[0] or die $!;

$abbr_dot = "^[\`\'\"\‚\/\(\\\[\{\<\§\‹\«\»\›\…\©\“\„\”\’\‘\°\´]*(A|B|C|D|E|F|G|H|I|II|III|J|K|L|M|N|O|Op|P|Q|R|S|T|U|V|W|X|Y|d|e|etc|m|n|А|Автореф|Б|В|Вопр|Г|Д|Е|Ж|З|Зам|И|Избр|К|Канд|Л|М|Матф|Моск|Н|О|Оп|П|Пер|Полн|Прим|Примеч|Р|Рис|Рос|Рус|С|СПб|Сб|Св|См|Соб|Собр|Сов|Ср|Ст|Стр|Т|У|Указ|Ф|Х|Ц|Цит|Ч|Ш|Э|Ю|Я|абс|авг|ак|англ|ар|арм|арт|б|биол|быв|в|вв|вел|веч|внутр|вод|воен|вост|вступ|вып|выс|г|гв|гв|ген|геогр|гл|гос|гр|д|дек|дес|див|дисс|докт|дол|долл|дор|др|е|ед|ж|жел|з|зав|зам|зап|и|изд|изм|им|ин|иностр|испр|ист|ит|их|к|кав|каз|канд|кар|кат|кб|кв|кн|ком|конф|коп|кр|креп|куб|л|м|мат|математич|мед|мес|мил|милл|мин|минер|мл|млн|млрд|мм|мн|мол|н|напр|нар|наст|науч|нач|неск|ниж|нов|о|об|обл|окт|опубл|отв|отд|оч|п|пед|пер|пех|пог|подп|пом|пос|посл|поч|пр|практ|пред|преп|пресв|прим|примеч|проц|проч|психол|р|ред|реш|рис|род|рт|руб|рус|с|саж|сб|св|сев|сек|сер|сл|след|см|соб|собр|сов|соц|соч|спец|ср|ст|стол|стр|т|т\.е|табл|тел|телеф|техн|тов|тыс|у|уд|ул|ум|ур|уч|ушир|ф|физ|филос|фр|франц|х|хим|хоз|хор|ц|цит|ч|чайн|чел|ш|шт|э|экз|экон|ю|юж|юр|юрид|яз)\\\.\$";

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
        #print "#".$_."#\n";
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




sub cut
{
  my $main_sentence = "";
  my @sub_sentence = ();
  my $i = 0;
  my $main = 1;
  foreach(split('', $sentence))
  {
    if($main == 1 and $_ ne '(')
    {
      $main_sentence = $main_sentence . $_;
    }
    elsif($main == 1 and $_ eq '(')
    {
      $i = $i + 1;
      $sub_sentence[$i] = "";
      $main = 0;
    }
    elsif($main == 0 and $_ ne ')')
    {
      $sub_sentence[$i] = $sub_sentence[$i] . $_;
    }
    elsif($main == 0 and $_ eq ')')
    {
      $main = 1;
    }
  }
  if($main_sentence ne "")
  {
print $main_sentence . "\n";
  }
  my $j = 1;
  while($j <= $i)
  {
    if($sub_sentence[$j] ne "")
    {
      print $sub_sentence[$j] . " sorvég\n";
    }
    $j = $j + 1;
  }
  $sentence = "";
}

sub put
{
  $sentence = $sentence . $_[0] . " ";
}


#Prod., proc. - dałem
#Ps., Red., Ryć., Tab., Ur., ub.r. - nie dałem

#|Abp.|Ad.|Adm.|Adw.|Al.|Arch.|Asp.|Cdn.|Dn.|Doc.|Dol.|Dr.|Dz. Urz.|Ed.|FOT.|Fot.|Gim.|Godz.|Gr.|
#|Hr.|II.|III.|INF.|IV.|IX.|Itd.|KS.|Kat.|Kol.|Kom.|Kpr.|Lp.|M.in.|Mat.|Max.|Med.|Min.|Mon.|Mr.|Mrs.|Mt.|
#|NOT.|Nb.|Not.|Np.|Nr.|OPRAC.|Ob.|Odp.|PKB.|PL.|PROF.|Par.|Pl.|Pol.|Por.|Pos.|Poz.|Prod.|Przeł.|Ps.|Pyt.|Płk.|
#|Q.|Red.|Reż.|Ryc.|Rys.|Ryć.|Sp.|Str.|Szk.|Tab.|Tel.|Th.|TŁUM.|Tłum.|USA, l.|Ul.|Ur.|VAT.|VI.|VII.|VIII.|Vol.|
#|W.K.|Wydz.|X.|XI.|XIII.|XIV.|XV.|XVI.|XVII.|XVIII.|XX.|Zad