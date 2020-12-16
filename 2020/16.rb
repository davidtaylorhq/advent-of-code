raw_rules, my, nearby = DATA.read.split("\n\n")

rules = {}
raw_rules
  .split("\n")
  .each do |line|
    _, name, *ranges = line.match(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/).to_a
    rules[name] = ranges.map(&:to_i)
  end

my = my.split("\n")[1].split(',').map(&:to_i)
nearby = nearby.split("\n").drop(1).map { |t| t.split(',').map(&:to_i) }

invalid_sum = 0

nearby_fields = []
nearby.each do |values|
  fields =
    values.map do |v|
      rules.filter do |rule, ranges|
        ranges.each_slice(2).any? { |min, max| v >= min && v <= max }
      end.keys
    end

  fields
    .each_with_index
    .filter { |v, _| v.empty? }
    .each { |_, i| invalid_sum += values[i] }

  nearby_fields << fields if fields.none?(&:empty?)
end

puts "Invalid sum is #{invalid_sum}"

possible = nearby_fields.transpose.map { |f| f.reduce(&:&) }

while single_option = possible.find { |i| i.is_a?(Array) && i.length == 1 }
  index = possible.index(single_option)
  possible[index] = single_option[0]
  possible.each { |p| p.delete(single_option[0]) }
end

product = 1
possible.each_with_index do |name, index|
  product *= my[index] if name.start_with? 'departure'
end

puts "Product of departure fields is #{product}"

__END__
departure location: 28-184 or 203-952
departure station: 43-261 or 283-958
departure platform: 43-549 or 564-970
departure track: 30-724 or 732-970
departure date: 37-650 or 657-973
departure time: 28-911 or 922-965
arrival location: 41-855 or 863-970
arrival station: 26-304 or 324-970
arrival platform: 45-896 or 903-963
arrival track: 34-458 or 466-962
class: 43-337 or 363-954
duration: 33-239 or 260-973
price: 34-600 or 606-961
route: 25-686 or 711-973
row: 36-101 or 124-963
seat: 25-794 or 806-949
train: 38-139 or 164-952
type: 37-619 or 627-956
wagon: 35-62 or 75-963
zone: 40-479 or 490-960

your ticket:
89,137,223,97,61,167,181,53,179,139,211,127,229,227,173,101,83,131,59,79

nearby tickets:
170,218,811,107,747,184,411,426,594,629,764,509,287,385,734,853,646,474,937,773
683,727,850,596,125,222,334,774,778,567,427,90,478,385,174,497,184,745,646,88
405,582,670,456,607,504,924,850,674,219,500,22,134,479,92,832,220,750,780,449
646,572,467,337,515,380,736,130,850,686,649,96,742,579,61,88,381,725,814,226
55,534,61,866,895,169,260,170,216,230,566,208,763,759,805,366,636,421,762,885
931,892,738,294,56,887,619,718,609,450,164,223,502,286,740,230,570,784,23,821
179,475,428,87,766,749,618,382,77,595,910,498,847,328,338,871,432,210,333,285
681,337,949,101,227,817,273,814,425,884,570,637,905,330,171,97,929,519,512,83
756,22,90,543,420,783,53,125,490,831,877,331,636,508,518,443,334,674,610,619
896,366,581,402,392,679,138,327,384,382,865,627,394,515,266,170,209,825,659,724
130,208,542,778,631,168,331,94,500,848,435,839,65,215,567,385,126,600,891,753
418,474,395,829,649,382,907,172,583,584,493,490,691,393,887,807,577,586,234,617
547,430,743,598,421,947,183,736,432,836,396,549,9,534,100,635,579,608,641,431
444,594,458,235,931,84,184,832,511,662,483,881,667,91,839,397,674,719,942,413
479,125,645,132,380,479,718,734,788,638,779,566,253,599,753,834,774,593,566,567
378,781,522,853,582,851,858,889,674,845,363,286,287,610,518,415,672,219,415,809
759,805,904,661,522,905,261,166,721,492,672,454,565,827,761,586,947,629,833,634
443,526,792,137,752,627,579,408,835,286,99,532,878,243,844,607,771,669,423,382
504,597,425,827,50,737,220,418,62,364,402,72,671,549,444,518,641,390,222,504
435,633,547,677,841,304,749,398,597,725,924,926,527,658,532,490,590,676,598,869
299,416,454,477,510,377,899,479,444,836,665,374,432,206,872,213,753,436,99,372
364,752,507,397,388,628,790,134,205,394,136,716,895,272,175,81,724,332,939,130
929,388,908,687,767,469,784,135,794,570,679,304,178,89,935,941,640,639,544,390
98,759,820,932,853,946,930,454,379,831,856,867,427,283,467,440,457,666,166,627
417,762,751,928,419,773,834,721,721,630,83,596,929,386,211,930,171,506,604,433
903,947,475,872,168,325,215,236,96,233,840,839,675,331,878,947,483,571,475,870
516,203,126,849,331,415,411,1,566,713,207,906,575,637,780,520,864,830,59,892
793,364,586,414,660,261,847,738,526,381,893,105,879,591,532,529,644,840,396,819
579,719,181,522,549,669,302,472,837,448,987,591,637,99,945,372,518,129,399,787
610,606,501,330,418,865,290,468,782,670,577,718,296,803,748,515,864,53,841,299
125,833,456,509,253,836,872,722,746,58,896,414,470,813,720,597,675,97,504,630
680,794,875,96,450,873,409,568,98,89,810,374,882,646,417,50,109,832,839,627
205,788,527,61,618,300,210,932,814,877,678,991,659,934,613,91,826,509,414,327
537,634,923,773,232,181,329,378,219,587,183,55,592,556,391,450,779,628,443,433
506,303,294,671,650,633,781,418,534,379,845,490,845,224,442,929,649,602,882,84
825,58,60,586,418,67,415,439,96,223,234,631,399,894,949,865,512,887,203,389
822,817,746,96,226,675,133,855,929,381,772,628,895,648,424,235,78,219,872,74
890,611,826,894,831,332,752,303,5,184,855,766,641,405,374,547,288,295,817,77
612,388,292,533,171,506,260,609,813,385,678,629,825,929,233,600,780,82,931,120
408,102,589,298,385,852,333,333,169,885,287,492,567,82,131,737,932,213,537,670
334,384,947,128,538,893,867,87,790,522,891,844,944,649,620,775,499,734,745,684
493,924,184,943,746,849,435,448,83,678,94,636,430,120,619,548,774,380,62,518
934,302,297,721,209,98,81,664,96,442,173,511,939,203,725,82,545,940,937,751
543,642,924,675,443,458,385,297,330,940,373,483,790,218,834,767,941,878,449,429
941,391,391,669,98,139,733,685,408,808,15,416,572,209,877,723,547,841,807,504
135,778,764,845,587,598,590,173,815,458,284,923,873,835,881,936,394,902,647,394
164,826,395,752,526,102,182,221,436,514,469,684,208,790,834,94,841,416,494,302
53,865,445,565,56,765,214,637,763,172,507,598,291,975,811,506,466,512,80,297
591,266,165,426,92,333,753,573,635,929,128,820,386,657,411,374,582,208,906,932
373,753,81,303,212,544,777,976,225,878,381,546,180,657,548,414,423,373,734,210
404,922,929,91,535,523,763,758,816,366,606,926,125,864,901,230,739,470,334,396
884,599,719,614,830,224,576,379,815,216,576,412,872,616,661,390,451,654,540,547
505,851,755,410,379,791,64,668,377,336,420,165,675,177,479,225,852,666,638,877
889,546,564,811,423,502,775,589,386,468,896,295,480,337,824,210,169,447,929,392
774,723,732,545,78,7,840,891,165,927,881,375,374,609,239,818,178,387,815,137
406,505,787,476,723,233,446,393,94,89,927,672,531,261,123,492,664,473,389,77
209,330,833,636,533,901,100,635,97,508,535,448,173,98,609,205,428,61,762,549
661,611,58,373,167,579,83,547,896,936,376,497,537,450,141,532,939,179,76,209
840,433,62,811,334,734,493,753,468,296,764,512,176,571,397,229,494,751,894,252
430,426,567,224,63,538,908,504,326,837,925,522,51,843,227,936,821,678,428,214
534,719,51,395,670,477,603,284,594,127,128,131,829,824,927,75,51,948,395,830
427,929,993,865,372,936,532,521,371,825,283,896,417,418,182,440,511,519,723,739
426,578,994,327,414,284,94,83,370,52,852,135,239,830,499,569,300,497,870,437
659,896,297,444,712,100,421,295,770,519,907,415,567,415,652,228,507,793,925,592
478,99,769,905,534,165,545,167,663,832,396,554,62,454,615,783,682,476,478,373
789,830,545,719,410,754,630,786,509,887,930,173,335,741,775,375,547,250,437,884
433,887,770,172,594,330,215,835,945,603,636,784,84,744,422,172,512,438,284,806
619,992,538,591,398,748,495,512,425,373,133,168,583,597,204,736,592,815,57,748
735,936,324,589,432,573,98,374,597,578,717,514,212,328,907,686,410,976,893,447
129,579,847,216,391,334,177,619,779,918,501,782,78,835,855,578,927,472,811,493
426,423,387,233,379,512,592,377,750,865,589,916,822,762,540,124,420,635,844,775
904,170,826,933,297,764,233,330,788,829,112,607,547,777,451,807,384,852,126,298
511,836,406,779,836,532,8,629,425,840,543,766,929,836,261,372,936,894,686,56
440,575,517,827,173,497,835,498,752,212,752,393,59,831,875,877,902,818,600,414
893,558,503,379,83,648,62,903,903,786,630,129,231,454,647,233,177,773,823,442
949,447,806,275,617,766,909,519,607,302,183,236,58,855,809,629,597,293,526,54
84,89,134,658,662,668,77,926,454,634,496,296,334,232,598,493,8,418,509,783
756,713,214,817,790,808,600,395,768,882,228,942,767,387,79,299,790,336,754,603
788,566,739,325,774,674,564,540,373,62,667,905,100,872,415,575,53,297,859,521
171,613,400,898,942,216,207,774,260,783,575,905,522,889,851,947,437,458,713,549
762,926,902,671,589,174,96,615,409,615,475,733,376,295,511,129,658,475,761,443
203,794,501,514,98,860,79,222,510,792,711,168,646,834,887,208,441,527,289,646
397,807,398,337,532,667,770,77,735,941,639,542,763,647,604,213,337,811,410,867
217,568,779,428,765,754,606,883,787,534,544,759,900,403,497,629,210,591,753,734
130,414,792,410,786,124,833,132,840,653,299,944,137,565,871,236,853,735,514,896
878,683,597,521,51,410,116,806,176,715,385,289,672,936,82,588,95,174,933,375
363,425,409,612,631,830,669,96,615,767,173,386,366,654,742,411,59,736,941,821
520,653,375,83,236,904,720,207,304,762,449,640,527,453,174,549,836,949,545,469
444,500,615,839,814,893,593,944,301,243,94,825,211,233,903,872,299,645,410,224
679,570,627,438,327,994,391,669,751,447,293,126,646,138,178,679,228,636,578,594
549,929,427,373,426,15,668,220,664,776,53,738,941,849,51,52,508,751,406,51
928,670,436,782,722,335,845,611,664,794,982,945,300,223,131,870,184,409,80,575
420,238,823,394,436,439,811,820,520,869,261,588,631,677,294,292,762,619,597,989
824,218,524,766,368,934,815,304,283,266,136,792,412,429,173,750,598,903,746,806
295,785,365,517,422,885,569,825,831,424,591,218,650,682,476,549,788,858,575,834
937,579,529,821,572,888,385,608,548,607,367,195,471,627,544,523,828,679,94,53
437,412,288,372,171,867,506,478,329,786,580,467,610,394,206,453,835,24,616,467
370,864,331,780,86,886,441,571,648,482,372,932,892,415,753,394,444,541,165,100
230,855,612,820,396,131,296,98,649,841,130,778,176,862,453,173,135,548,839,637
794,686,296,285,933,582,679,881,392,515,226,773,763,904,67,439,928,720,610,529
172,932,676,885,937,494,717,826,70,129,931,220,635,176,781,364,583,880,911,785
663,717,515,927,837,505,735,825,902,211,540,640,126,420,217,542,716,896,886,719
868,643,16,472,491,650,933,238,216,613,225,225,865,367,939,433,618,410,477,491
229,635,287,593,261,986,759,57,528,775,887,529,237,942,138,411,739,495,225,810
530,758,510,755,823,17,753,570,865,833,732,90,776,793,773,175,751,389,588,767
474,784,496,719,539,911,566,328,879,928,759,764,819,714,488,532,127,682,512,210
525,98,416,757,888,646,179,564,826,430,610,99,734,165,702,847,423,829,765,442
504,383,172,636,297,826,928,757,419,222,182,591,586,154,442,908,440,771,376,138
982,90,754,495,717,214,56,905,638,531,542,330,876,576,495,329,300,779,712,877
132,761,568,917,235,669,673,175,529,933,753,757,236,612,821,819,749,221,438,234
545,451,454,749,514,522,174,724,135,595,289,531,445,386,661,784,861,506,226,893
334,292,814,939,638,402,878,218,780,72,756,906,864,469,454,401,88,534,823,716
667,447,238,578,86,864,565,947,392,179,684,588,851,772,572,751,879,66,295,822
833,445,855,730,935,237,506,401,888,239,94,811,131,379,739,219,469,606,815,569
403,434,940,633,383,819,237,773,526,910,414,76,630,913,642,524,659,331,791,386
508,864,872,397,499,467,671,617,868,110,816,812,217,681,942,510,733,948,713,598
446,915,58,474,752,512,285,299,894,573,749,287,823,375,808,531,540,714,840,409
137,181,53,496,547,720,714,840,830,829,77,579,167,734,814,447,3,659,432,757
10,221,846,753,131,787,454,78,714,410,327,455,375,785,234,51,872,328,370,617
850,890,258,385,754,585,780,528,548,379,678,818,438,896,879,648,893,946,941,671
539,260,372,127,845,603,711,212,609,366,437,582,239,470,426,540,713,743,785,644
577,527,523,210,300,289,591,937,204,775,875,293,822,602,713,741,386,566,669,334
743,421,593,573,296,659,847,388,512,493,779,514,501,76,472,606,678,110,505,768
898,815,937,384,433,669,513,649,75,260,425,127,679,428,59,658,742,566,383,634
417,366,872,377,545,811,197,788,430,843,173,57,743,164,337,580,469,642,841,451
493,790,650,181,293,536,836,574,631,882,843,431,417,432,849,751,225,456,910,862
392,600,740,847,497,816,658,887,647,910,67,641,774,846,568,893,848,617,381,377
295,587,837,168,670,783,766,81,823,452,777,51,622,218,732,78,53,428,786,50
469,433,929,13,468,134,522,546,181,375,509,213,76,771,773,683,139,937,548,863
852,534,507,547,608,884,564,388,779,811,644,755,653,410,433,101,938,417,174,815
531,166,750,940,593,595,492,991,52,824,415,227,138,949,867,375,922,328,640,101
379,334,444,854,923,575,714,412,678,206,203,426,174,977,409,786,838,514,335,368
52,445,750,778,852,389,787,514,904,659,85,756,727,925,543,203,128,329,495,429
812,923,884,417,840,611,717,748,949,636,423,838,556,534,665,892,431,681,528,523
450,218,424,418,493,169,134,288,93,189,880,868,430,389,716,864,678,545,882,521
789,223,436,540,210,248,55,565,394,59,835,363,509,617,775,535,410,792,684,395
329,429,750,138,423,435,210,450,387,770,134,736,638,784,452,863,500,582,829,982
390,82,295,598,519,333,754,290,56,702,217,642,420,506,208,172,846,586,824,375
418,611,291,496,933,817,730,590,237,501,171,644,588,82,807,172,580,380,499,384
880,419,139,329,467,283,829,774,442,137,513,466,176,924,818,978,785,741,184,214
415,537,511,377,135,100,254,879,425,827,591,629,787,90,495,411,169,523,619,573
378,880,747,744,396,482,446,476,719,497,223,948,940,447,492,168,476,734,834,586
388,86,83,475,409,926,821,874,872,386,566,685,498,526,832,791,81,129,781,12
169,473,739,751,592,681,577,544,512,895,86,296,646,454,56,501,325,807,74,51
939,879,882,572,287,387,585,882,427,564,335,205,505,617,460,411,816,515,931,570
248,229,410,632,828,508,332,441,867,99,470,632,442,825,640,442,665,544,762,647
609,564,494,834,853,590,772,532,634,295,808,564,772,71,388,446,632,540,614,793
225,509,665,234,897,506,777,229,164,768,291,300,545,868,231,733,94,334,521,887
406,577,87,538,841,494,436,368,642,866,713,134,671,763,246,607,909,780,499,372
217,439,904,205,528,879,827,685,722,569,880,443,643,580,882,334,496,265,787,298
98,485,510,893,84,181,567,893,852,849,530,939,84,682,447,638,934,368,716,133
886,821,210,585,51,178,134,431,213,56,371,859,237,777,526,337,420,628,526,506
231,428,610,567,297,678,547,842,569,811,914,167,364,675,831,403,767,329,910,869
455,408,519,715,337,0,84,756,328,466,794,370,868,766,177,437,922,752,326,260
414,687,466,672,834,664,171,391,682,509,611,948,466,600,234,513,863,769,468,941
428,716,677,760,611,430,775,818,374,176,611,601,538,885,547,776,665,666,363,752
751,77,637,133,683,431,378,632,457,62,681,544,62,772,859,578,590,417,863,569
217,777,134,125,781,169,478,869,924,139,97,898,647,576,392,236,775,443,523,717
807,774,324,62,948,789,746,939,855,168,645,927,939,449,916,441,584,681,932,720
210,203,478,220,365,932,333,579,367,424,853,278,591,785,886,218,888,533,99,334
640,431,220,807,207,683,932,407,203,405,365,875,863,221,555,61,778,592,780,129
852,203,616,89,639,24,501,790,772,617,220,754,810,757,791,438,775,777,715,296
449,931,372,750,835,95,206,768,923,907,514,77,601,79,889,433,579,750,217,449
886,534,548,844,59,198,53,425,205,134,896,867,670,420,58,830,177,639,829,610
666,911,752,578,835,443,783,135,889,411,736,289,280,220,825,456,832,944,331,923
806,536,674,788,498,366,633,682,583,134,101,829,196,630,589,433,421,761,669,229
930,832,478,415,659,821,662,66,659,820,220,633,935,674,535,80,682,293,381,387
663,298,457,332,128,763,332,84,564,611,604,909,770,204,924,216,745,841,416,288
781,663,514,858,773,466,719,298,172,825,755,866,453,125,852,826,134,429,648,774
528,294,866,794,332,379,184,296,843,596,832,614,532,7,792,664,789,935,600,734
570,222,426,169,873,231,91,679,325,366,614,2,299,876,83,237,53,472,771,468
84,56,872,684,927,336,820,449,447,902,377,233,86,593,759,403,929,842,169,495
382,671,442,589,929,128,214,847,237,800,684,599,164,415,525,684,849,217,227,887
837,745,370,740,855,638,660,89,56,866,224,593,508,511,191,441,134,939,782,887
814,200,401,891,384,763,885,83,126,478,792,420,910,614,175,822,818,225,764,92
716,716,930,388,111,635,842,505,182,467,591,744,88,414,543,444,611,387,512,675
379,887,80,594,844,629,677,722,632,874,238,940,847,942,776,519,193,905,261,930
433,838,779,208,165,443,477,78,764,521,366,397,612,846,606,747,404,431,106,291
386,650,474,331,939,610,489,650,419,416,442,286,93,365,582,367,334,840,642,394
818,302,50,794,820,755,561,661,884,683,631,130,867,723,419,807,848,610,382,889
928,907,467,614,53,271,511,825,578,827,182,814,431,760,541,765,661,299,51,523
377,602,752,169,83,806,527,544,294,325,228,876,866,367,505,531,288,871,368,866
368,854,817,328,923,139,498,547,503,431,897,733,543,288,774,614,84,169,540,525
599,300,226,628,206,294,638,369,906,527,451,453,937,539,222,367,991,942,881,467
513,93,600,794,166,170,416,863,528,511,77,508,115,598,775,217,629,806,512,928
760,857,415,525,762,420,716,738,371,684,290,285,821,810,777,498,810,944,336,648
105,401,503,565,216,787,548,474,382,939,754,827,924,515,755,438,166,770,773,418
871,843,223,588,739,591,328,541,617,678,541,542,916,182,450,776,807,908,424,764
363,396,96,390,892,572,407,780,738,212,298,785,233,164,807,235,76,213,252,777
565,888,366,557,669,418,778,569,380,447,413,166,907,675,878,810,417,618,401,788
368,592,393,810,382,571,741,285,586,632,240,237,779,331,886,378,765,445,869,135
138,522,637,817,684,176,581,926,755,380,765,304,441,898,231,743,836,379,670,131
291,632,821,659,939,514,643,616,124,579,678,619,367,729,518,768,756,386,167,365
818,240,750,237,87,472,769,213,842,260,225,767,629,593,820,775,838,774,764,466
478,769,88,248,716,584,78,751,372,583,85,218,294,446,328,396,83,130,166,668
444,814,476,67,946,629,911,525,589,864,945,478,180,403,835,474,494,218,177,292
527,947,533,500,658,740,737,87,572,97,501,435,911,621,934,466,260,479,413,288
73,304,911,761,412,863,891,590,869,638,662,132,410,397,711,477,92,56,576,736
89,478,284,203,755,889,237,417,886,424,925,659,713,480,774,56,758,224,62,75
871,455,60,675,606,13,516,378,884,506,236,443,763,176,586,789,377,767,547,167
285,673,284,130,223,327,575,633,582,986,390,855,441,494,719,907,763,794,757,610
507,376,837,101,822,670,466,504,838,595,831,885,405,940,657,62,448,197,757,791
788,564,847,786,55,715,288,818,219,468,905,291,789,459,75,792,337,894,515,868
671,429,286,888,436,647,735,756,324,907,260,780,459,509,513,775,180,781,439,300
90,507,533,401,125,80,590,645,872,89,132,878,502,302,746,941,737,556,874,508
597,884,580,849,431,324,418,767,294,532,405,248,785,940,215,841,403,78,374,721
164,748,435,617,869,936,855,607,515,462,784,453,927,83,532,600,207,379,503,814
15,468,58,223,843,878,633,478,741,224,96,751,784,767,736,531,750,216,643,619
472,523,843,481,849,943,90,543,381,572,382,842,566,335,891,911,630,712,420,533
5,923,539,213,810,869,738,757,285,878,535,385,432,667,793,454,775,659,401,944
518,80,925,723,880,425,914,577,470,475,937,448,409,433,678,794,456,85,889,381
602,823,404,176,842,814,528,136,583,716,834,429,908,627,292,744,833,926,855,545
669,209,366,126,716,747,882,540,825,452,617,588,816,228,136,288,126,918,871,452
865,794,237,654,433,630,722,615,541,790,174,609,128,519,682,232,179,644,527,214
401,894,435,543,717,546,238,205,787,555,905,761,407,524,376,757,443,205,373,869
668,906,228,733,719,835,751,776,515,83,782,851,836,788,570,577,605,500,86,927
759,612,391,602,85,506,946,661,385,408,455,335,363,428,658,416,678,129,853,292
853,228,50,399,576,753,422,770,529,862,181,783,391,300,382,784,217,377,366,819
892,842,432,824,181,286,472,467,57,331,884,467,498,298,881,892,770,333,825,484
853,936,792,598,389,886,11,176,661,444,535,599,89,842,377,908,722,216,421,759
182,685,736,206,368,93,877,674,785,837,291,806,324,705,421,877,819,422,490,834
58,516,178,532,89,580,516,214,503,612,199,379,758,167,723,238,59,865,536,405
564,785,445,176,823,540,884,85,946,890,641,54,834,218,542,928,247,499,229,832
925,414,905,199,649,946,816,735,644,753,761,779,328,661,880,849,769,657,547,58
184,583,534,844,366,300,910,767,873,24,325,947,870,183,806,80,659,79,470,457
885,683,826,722,759,514,52,403,850,178,133,520,214,867,608,618,512,446,900,711
660,747,211,443,607,632,95,77,580,826,576,774,804,533,947,747,59,592,885,852
513,435,73,615,179,91,873,383,61,455,82,181,754,721,635,869,86,947,893,52
937,454,927,932,935,212,227,640,135,762,477,849,415,822,681,577,628,872,9,683
374,909,607,775,934,588,373,290,612,457,337,216,545,495,294,134,443,487,742,84
524,900,87,874,742,671,133,547,82,394,847,444,594,368,751,549,637,237,673,867
456,661,828,85,215,912,720,212,477,90,609,642,847,587,835,905,98,454,780,366
873,292,55,833,285,369,405,52,217,650,293,637,926,199,165,662,824,296,223,526
8,429,574,364,80,184,540,590,680,826,438,399,380,503,180,739,388,641,526,182
756,57,236,212,789,808,571,544,81,722,387,617,862,405,396,518,864,169,455,82
93,402,449,610,641,928,2,212,239,420,838,905,790,55,99,946,181,418,748,941
425,68,840,423,217,790,470,288,847,669,791,546,718,781,415,81,395,809,935,573
21,330,375,595,738,948,523,82,713,335,682,501,296,325,289,90,290,574,426,379
410,51,139,410,534,226,520,422,438,498,614,821,495,850,744,396,169,515,440,901
577,171,878,134,600,368,171,169,450,229,761,843,82,575,870,886,64,455,414,564
