import 'package:envawareness/data/endangered_species_info.dart';

List<EndangeredSpeciesInfo> get endangeredSpeciesList {
  return endangeredSpeciesJson.map(EndangeredSpeciesInfo.fromJson).toList();
}

const endangeredSpeciesJson = [
  {
    'name': '巴巴里獅',
    'name_en': 'Barbary Lion',
    'name_ja': 'バーバリライオン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Barbary_lion.jpg/1200px-Barbary_lion.jpg',
    'level': 'EW',
  },
  {
    'name': '夏威夷烏鴉',
    'name_en': 'Hawaiian Crow',
    'name_ja': 'ハワイカラス',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Corvus_hawaiiensis_FWS.jpg/1200px-Corvus_hawaiiensis_FWS.jpg',
    'level': 'EW',
  },
  {
    'name': '彎角劍羚',
    'name_en': 'Scimitar Oryx',
    'name_ja': 'サーベルオリックス',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/3/3a/Oryx_Dammah.jpg',
    'level': 'EW',
  },
  {
    'name': '懷俄明蟾蜍',
    'name_en': 'Wyoming Toad',
    'name_ja': 'ワイオミングトード',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/7/79/Anaxyrus_baxteri-3.jpg',
    'level': 'EW',
  },
  {
    'name': '斯皮克斯金剛鸚鵡',
    'name_en': "Spix's Macaw",
    'name_ja': 'スピックスマコウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Cyanopsitta_spixii_-Vogelpark_Walsrode%2C_Walsrode%2C_Germany-1980.jpg/1200px-Cyanopsitta_spixii_-Vogelpark_Walsrode%2C_Walsrode%2C_Germany-1980.jpg',
    'level': 'EW',
  },
  {
    'name': '旋角羚',
    'name_en': 'Addax',
    'name_ja': 'アダックス',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Mendesantilope_1402.JPG/640px-Mendesantilope_1402.JPG',
    'level': 'CR',
  },
  {
    'name': '非洲野驢',
    'name_en': 'African Wild Ass',
    'name_ja': 'アフリカノロバ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/e/e5/Somali_Wild_Ass.JPG',
    'level': 'CR',
  },
  {
    'name': '亞洲獵豹',
    'name_en': 'Asiatic Cheetah',
    'name_ja': 'アジアチーター',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/a/ab/Kooshki_%28Iranian_Cheetah%29_03.jpg',
    'level': 'CR',
  },
  {
    'name': '亞洲山龜',
    'name_en': 'Asian Forest Tortoise',
    'name_ja': 'アジアリクガメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/b/be/Heosemys-depressa.jpg',
    'level': 'CR',
  },
  {
    'name': '墨西哥鈍口螈',
    'name_en': 'Axolotl',
    'name_ja': 'アホロートル',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/d/df/Axolotl.jpg',
    'level': 'CR',
  },
  {
    'name': '雙峰駱駝',
    'name_en': 'Bactrian Camel',
    'name_ja': 'バクトリアンラクダ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/2011_Trampeltier_1528.JPG/1200px-2011_Trampeltier_1528.JPG',
    'level': 'CR',
  },
  {
    'name': '藍喉金剛鸚鵡',
    'name_en': 'Blue-throated Macaw',
    'name_ja': 'アオノドインコ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Ara_glaucogularis.jpg/1200px-Ara_glaucogularis.jpg',
    'level': 'CR',
  },
  {
    'name': '食猿鵰',
    'name_en': 'Philippine Eagle',
    'name_ja': 'フィリピンワシ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Noblest_Flyer_Philippine_Eagle.jpg/1200px-Noblest_Flyer_Philippine_Eagle.jpg',
    'level': 'CR',
  },
  {
    'name': '加州神鷲',
    'name_en': 'California Condor',
    'name_ja': 'カリフォルニアコンドル',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Gymnogyps_californianus_-San_Diego_Zoo-8a.jpg/1200px-Gymnogyps_californianus_-San_Diego_Zoo-8a.jpg',
    'level': 'CR',
  },
  {
    'name': '恆河鱷',
    'name_en': 'Gharial',
    'name_ja': 'ガヴィアル',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/a/ae/Gharial_san_diego.jpg',
    'level': 'CR',
  },
  {
    'name': '暹羅鱷',
    'name_en': 'Siamese Crocodile',
    'name_ja': 'シャムワニ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Crocodylus_siamensis_in_moscow_zoo_01.jpg/1200px-Crocodylus_siamensis_in_moscow_zoo_01.jpg',
    'level': 'CR',
  },
  {
    'name': '揚子鱷',
    'name_en': 'Yangtze Alligator',
    'name_ja': 'ヨウスコウワニ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/2/24/China-Alligator.jpg',
    'level': 'CR',
  },
  {
    'name': '中國大鯢',
    'name_en': 'Chinese Giant Salamander',
    'name_ja': 'チュウゴクオオサンショウウオ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/2009_Andrias_davidianus.JPG/1200px-2009_Andrias_davidianus.JPG',
    'level': 'CR',
  },
  {
    'name': '佛羅里達山獅',
    'name_en': 'Florida Panther',
    'name_ja': 'フロリダパンサー',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/5/59/Puma.jpg',
    'level': 'CR',
  },
  {
    'name': '夏威夷僧海豹',
    'name_en': 'Hawaiian Monk Seal',
    'name_ja': 'ハワイアンモンクシール',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Monachus_schauinslandi.jpg/1200px-Monachus_schauinslandi.jpg',
    'level': 'CR',
  },
  {
    'name': '帝啄木鳥',
    'name_en': 'Imperial Woodpecker',
    'name_ja': 'テンニンゲラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/95/Kaiserspecht_fg02.jpg',
    'level': 'CR',
  },
  {
    'name': '象牙喙啄木鳥',
    'name_en': 'Ivory-billed Woodpecker',
    'name_ja': 'ゾウゲラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Campephilus_principalisAWP066AA2.jpg/1200px-Campephilus_principalisAWP066AA2.jpg',
    'level': 'CR',
  },
  {
    'name': '鴞鸚鵡',
    'name_en': 'Kakapo',
    'name_ja': 'カカポ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/a/aa/Sirocco_full_length_portrait.jpg',
    'level': 'CR',
  },
  {
    'name': '利氏袋鼯',
    'name_en': "Leadbeater's Possum",
    'name_ja': 'リードベターズオポッサム',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Leadbeater%27s_Possum_02_Pengo.jpg/1200px-Leadbeater%27s_Possum_02_Pengo.jpg',
    'level': 'CR',
  },
  {
    'name': '地中海僧海豹',
    'name_en': 'Mediterranean Monk Seal',
    'name_ja': '地中海アザラシ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Monachus_monachus_-_Museo_civico_di_storia_naturale_%28Milan%29.jpg/1200px-Monachus_monachus_-_Museo_civico_di_storia_naturale_%28Milan%29.jpg',
    'level': 'CR',
  },
  {
    'name': '山地大猩猩',
    'name_en': 'Mountain Gorilla',
    'name_ja': 'マウンテンゴリラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Mountain_gorilla_%28Gorilla_beringei_beringei%29_yawn.jpg/1200px-Mountain_gorilla_%28Gorilla_beringei_beringei%29_yawn.jpg',
    'level': 'CR',
  },
  {
    'name': '昆士蘭毛吻袋熊',
    'name_en': 'Northern Hairy-nosed Wombat',
    'name_ja': 'クイーンズランドハリモグラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/0/00/Haarnasenwombat_%28Lasiorhinus_krefftii%29.jpg',
    'level': 'CR',
  },
  {
    'name': '紅狼',
    'name_en': 'Red Wolf',
    'name_ja': 'レッドウルフ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/a/ac/07-03-23RedWolfAlbanyGAChehaw.jpg',
    'level': 'CR',
  },
  {
    'name': '高鼻羚羊',
    'name_en': 'Saiga Antelope',
    'name_ja': 'サイガ',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Saiga.jpg',
    'level': 'CR',
  },
  {
    'name': '藍鰭金槍魚',
    'name_en': 'Bluefin Tuna',
    'name_ja': 'マグロ',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/9/9a/Thmac_u0.gif',
    'level': 'CR',
  },
  {
    'name': '華南虎',
    'name_en': 'South China Tiger',
    'name_ja': 'ナンホクタイガー',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/2012_Suedchinesischer_Tiger.JPG/1200px-2012_Suedchinesischer_Tiger.JPG',
    'level': 'CR',
  },
  {
    'name': '蘇門答臘虎',
    'name_en': 'Sumatran Tiger',
    'name_ja': 'スマトラトラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Sumatran_Tiger_Berlin_Tierpark.jpg/1200px-Sumatran_Tiger_Berlin_Tierpark.jpg',
    'level': 'CR',
  },
  {
    'name': '蘇門答臘象',
    'name_en': 'Sumatran Elephant',
    'name_ja': 'スマトラゾウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Sumatra_elephant_Ragunan_Zoo_3.JPG/1200px-Sumatra_elephant_Ragunan_Zoo_3.JPG',
    'level': 'CR',
  },
  {
    'name': '蘇門答臘犀牛',
    'name_en': 'Sumatran Rhinoceros',
    'name_ja': 'スマトラサイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Sumatran_Rhinoceros_at_Sumatran_Rhino_Sanctuary_Lampung_Indonesia_2013.JPG/1200px-Sumatran_Rhinoceros_at_Sumatran_Rhino_Sanctuary_Lampung_Indonesia_2013.JPG',
    'level': 'CR',
  },
  {
    'name': '爪哇犀牛',
    'name_en': 'Javan Rhinoceros',
    'name_ja': 'ジャワサイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/c/ce/Rhinoceros_sondaicus_in_London_Zoo.jpg',
    'level': 'CR',
  },
  {
    'name': '北白犀',
    'name_en': 'Northern White Rhinoceros',
    'name_ja': 'ホクビャクサイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Ceratotherium.simum.cottoni-01-ZOO.Dvur.Kralove.jpg/1200px-Ceratotherium.simum.cottoni-01-ZOO.Dvur.Kralove.jpg',
    'level': 'CR',
  },
  {
    'name': '黑犀',
    'name_en': 'Black Rhinoceros',
    'name_ja': 'クロサイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Diceros_bicornis.jpg/1200px-Diceros_bicornis.jpg',
    'level': 'CR',
  },
  {
    'name': '小頭鼠海豚',
    'name_en': 'Vaquita',
    'name_ja': 'バキータ',
    'image':
        'https://i0.wp.com/oceangeneration.org/wp-content/uploads/2023/07/meet-the-vaquita-the-most-endangered-marine-mammal.png?fit=1440%2C850&ssl=1',
    'level': 'CR',
  },
  {
    'name': '白鱀豚',
    'name_en': 'Baiji',
    'name_ja': 'ハクジンイルカ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/c/cb/Qiqi%2C_a_Chinese_River_Dolphin_%28Baiji%29_26.jpg',
    'level': 'CR',
  },
  {
    'name': '克羅斯河大猩猩',
    'name_en': 'Cross River Gorilla',
    'name_ja': 'クロスリバーゴリラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/a/a9/Cross_river_gorilla.jpg',
    'level': 'CR',
  },
  {
    'name': '蘇門達臘猩猩',
    'name_en': 'Orangutan',
    'name_ja': 'オランウータン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Orang-utan_bukit_lawang_2006.jpg/1200px-Orang-utan_bukit_lawang_2006.jpg',
    'level': 'CR',
  },
  {
    'name': '玳瑁',
    'name_en': 'Hawksbill Turtle',
    'name_ja': 'タイマイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/b/ba/Hawksbill_Turtle.jpg',
    'level': 'CR',
  },
  {
    'name': '肯氏龜',
    'name_en': "Kemp's Ridley Sea Turtle",
    'name_ja': 'ケンプウミガメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Padre_Island_National_Seashore_-_Kemps_Ridley_Sea_Turtle.jpg/1200px-Padre_Island_National_Seashore_-_Kemps_Ridley_Sea_Turtle.jpg',
    'level': 'CR',
  },
  {
    'name': '亞洲象',
    'name_en': 'Asian Elephant',
    'name_ja': 'アジアゾウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/f/f9/Zoorashia_elephant.jpg',
    'level': 'EN',
  },
  {
    'name': '印度象',
    'name_en': 'Indian Elephant',
    'name_ja': 'インドゾウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Elephas_maximus_%28Bandipur%29.jpg/1200px-Elephas_maximus_%28Bandipur%29.jpg',
    'level': 'EN',
  },
  {
    'name': '錫蘭象',
    'name_en': 'Sri Lankan Elephant',
    'name_ja': 'スリランカゾウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Elephas_maximus_maximus_-_01.jpg/1200px-Elephas_maximus_maximus_-_01.jpg',
    'level': 'EN',
  },
  {
    'name': '黑猩猩',
    'name_en': 'Chimpanzee',
    'name_ja': 'チンパンジー',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/015_Chimpanzee_at_Kibale_forest_National_Park_Photo_by_Giles_Laurent.jpg/1200px-015_Chimpanzee_at_Kibale_forest_National_Park_Photo_by_Giles_Laurent.jpg',
    'level': 'EN',
  },
  {
    'name': '婆羅洲猩猩',
    'name_en': 'Bornean Orangutan',
    'name_ja': 'ボルネオオランウータン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/d/d3/OrangutanP1.jpg',
    'level': 'EN',
  },
  {
    'name': '長鼻猴',
    'name_en': 'Proboscis Monkey',
    'name_ja': 'テングザル',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Proboscis_monkey_%28Nasalis_larvatus%29_male_Labuk_Bay.jpg/1200px-Proboscis_monkey_%28Nasalis_larvatus%29_male_Labuk_Bay.jpg',
    'level': 'EN',
  },
  {
    'name': '丹頂鶴',
    'name_en': 'Red-crowned Crane',
    'name_ja': 'タンチョウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Grus_japonensis_-Hokkaido%2C_Japan_-several-8_%281%29.jpg/1200px-Grus_japonensis_-Hokkaido%2C_Japan_-several-8_%281%29.jpg',
    'level': 'EN',
  },
  {
    'name': '栗頭鳽',
    'name_en': 'Japanese Night Heron',
    'name_ja': 'ヤマシギ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Japanese_night_heron_%28Gorsachius_goisagi%29.jpg/1200px-Japanese_night_heron_%28Gorsachius_goisagi%29.jpg',
    'level': 'EN',
  },
  {
    'name': '紅胸黑雁',
    'name_en': 'Red-breasted Goose',
    'name_ja': 'セイタカガン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Red-breasted_goose_arp.jpg/1200px-Red-breasted_goose_arp.jpg',
    'level': 'EN',
  },
  {
    'name': '李爾氏金剛鸚鵡',
    'name_en': "Lear's Macaw",
    'name_ja': 'ルリコンゴウインコ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/b/b7/Lear%27s_Macaw_Anodorhynchus_leari.jpg',
    'level': 'EN',
  },
  {
    'name': '紫藍金剛鸚鵡',
    'name_en': 'Hyacinth Macaw',
    'name_ja': 'ヒアシンスマカウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Anodorhynchus_hyacinthinus_-Disney_-Florida-8.jpg/1200px-Anodorhynchus_hyacinthinus_-Disney_-Florida-8.jpg',
    'level': 'EN',
  },
  {
    'name': '黑腳企鵝',
    'name_en': 'African Penguin',
    'name_ja': 'アフリカペンギン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Ping%C3%BCino_de_El_Cabo_%28Spheniscus_demersus%29%2C_Playa_de_Boulders%2C_Simon%27s_Town%2C_Sud%C3%A1frica%2C_2018-07-23%2C_DD_11.jpg/1200px-Ping%C3%BCino_de_El_Cabo_%28Spheniscus_demersus%29%2C_Playa_de_Boulders%2C_Simon%27s_Town%2C_Sud%C3%A1frica%2C_2018-07-23%2C_DD_11.jpg',
    'level': 'EN',
  },
  {
    'name': '非洲灰鸚鵡',
    'name_en': 'African Grey Parrot',
    'name_ja': 'アフリカオオコノハズク',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Congo_African_Grey_Parrot_Bali.jpg/1200px-Congo_African_Grey_Parrot_Bali.jpg',
    'level': 'EN',
  },
  {
    'name': '波斯豹',
    'name_en': 'Persian Leopard',
    'name_ja': 'ペルシャヒョウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Persian_Leopard_sitting.jpg/1200px-Persian_Leopard_sitting.jpg',
    'level': 'EN',
  },
  {
    'name': '亞洲獅',
    'name_en': 'Asiatic Lion',
    'name_ja': 'アジアライオン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/5/51/Adult_Asiatic_Lion.jpg',
    'level': 'EN',
  },
  {
    'name': '東北虎',
    'name_en': 'Siberian Tiger',
    'name_ja': 'シベリアトラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/P.t.altaica_Tomak_Male.jpg/1200px-P.t.altaica_Tomak_Male.jpg',
    'level': 'EN',
  },
  {
    'name': '孟加拉虎',
    'name_en': 'Bengal Tiger',
    'name_ja': 'ベンガルトラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/2/2e/Tigerramki.jpg',
    'level': 'EN',
  },
  {
    'name': '伊比利亞猞猁',
    'name_en': 'Iberian Lynx',
    'name_ja': 'イベリアオオヤマネコ',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Linces19.jpg',
    'level': 'EN',
  },
  {
    'name': '漁貓',
    'name_en': 'Fishing Cat',
    'name_ja': 'フィッシングキャット',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/f/f7/Prionailurus_viverrinus_01.jpg',
    'level': 'EN',
  },
  {
    'name': '非洲野犬',
    'name_en': 'African Wild Dog',
    'name_ja': 'アフリカノウサギ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/African_wild_dog_%28Lycaon_pictus_pictus%29.jpg/1200px-African_wild_dog_%28Lycaon_pictus_pictus%29.jpg',
    'level': 'EN',
  },
  {
    'name': '豺',
    'name_en': 'Dhole',
    'name_ja': 'ドール',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/90/Not_a_fox.png',
    'level': 'EN',
  },
  {
    'name': '衣索比亞狼',
    'name_en': 'Ethiopian Wolf',
    'name_ja': 'エチオピアオオカミ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/f/fa/EthiopianWolf1.jpg',
    'level': 'EN',
  },
  {
    'name': '袋獾',
    'name_en': 'Tasmanian Devil',
    'name_ja': 'タスマニアデビル',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Tasdevil_large.jpg/1200px-Tasdevil_large.jpg',
    'level': 'EN',
  },
  {
    'name': '小熊貓',
    'name_en': 'Red Panda',
    'name_ja': 'レッサーパンダ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/RedPandaFullBody.JPG/1200px-RedPandaFullBody.JPG',
    'level': 'EN',
  },
  {
    'name': '巨獺',
    'name_en': 'Giant Otter',
    'name_ja': 'ジャイアントオッター',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Giantotter.jpg/1200px-Giantotter.jpg',
    'level': 'EN',
  },
  {
    'name': '馬來貘',
    'name_en': 'Malayan Tapir',
    'name_ja': 'マレータピール',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Tapirus_indicus_20230407.jpg/1200px-Tapirus_indicus_20230407.jpg',
    'level': 'EN',
  },
  {
    'name': '捻角山羊',
    'name_en': 'Markhor',
    'name_ja': 'マルホール',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/f/f5/Markhor.jpg',
    'level': 'EN',
  },
  {
    'name': '倭河馬',
    'name_en': 'Pygmy Hippopotamus',
    'name_ja': 'ピグミーヒポポタマス',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Zwergflusspferd_-_Pygmy_Hippopotamus_-_Hexaprotodon_liberiensis.jpg/1200px-Zwergflusspferd_-_Pygmy_Hippopotamus_-_Hexaprotodon_liberiensis.jpg',
    'level': 'EN',
  },
  {
    'name': '羅氏長頸鹿',
    'name_en': "Rothschild's Giraffe",
    'name_ja': 'ロスチャイルドキリン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/d/d0/Rothschilds_giraffe_at_paignton_arp.jpg',
    'level': 'EN',
  },
  {
    'name': '細紋斑馬',
    'name_en': "Grévy's Zebra",
    'name_ja': 'グレビーシマウマ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/0/0b/Grevys_zebra.jpg',
    'level': 'EN',
  },
  {
    'name': '普氏野馬',
    'name_en': "Przewalski's Horse",
    'name_ja': 'プジェワルスキウマ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/f/f5/Przewalskis_horse_02.jpg',
    'level': 'EN',
  },
  {
    'name': '火山兔',
    'name_en': 'Volcano Rabbit',
    'name_ja': 'ヴォルカノウサギ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/4/45/Romerolagus_diazi_%28dispale%29_001.jpg',
    'level': 'EN',
  },
  {
    'name': '粗毛兔',
    'name_en': 'Hispid Hare',
    'name_ja': 'ヒスピッドハレ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/CaprolagusHispidusJASB.jpg/1200px-CaprolagusHispidusJASB.jpg',
    'level': 'EN',
  },
  {
    'name': '河水牛',
    'name_en': 'Water Buffalo',
    'name_ja': 'スイギュウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Asianwaterbuffalo.jpg/1200px-Asianwaterbuffalo.jpg',
    'level': 'EN',
  },
  {
    'name': '藍鯨',
    'name_en': 'Blue Whale',
    'name_ja': 'セイウチ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Anim1754_-_Flickr_-_NOAA_Photo_Library.jpg/1200px-Anim1754_-_Flickr_-_NOAA_Photo_Library.jpg',
    'level': 'EN',
  },
  {
    'name': '鯨鯊',
    'name_en': 'Whale Shark',
    'name_ja': 'ジンベイザメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Whale-Shark-Scale-Chart-SVG-Steveoc86.svg/1200px-Whale-Shark-Scale-Chart-SVG-Steveoc86.svg.png',
    'level': 'EN',
  },
  {
    'name': '綠蠵龜',
    'name_en': 'Green Sea Turtle',
    'name_ja': 'アオウミガメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Hawaii_turtle_2.JPG/1200px-Hawaii_turtle_2.JPG',
    'level': 'EN',
  },
  {
    'name': '赤蠵龜',
    'name_en': 'Loggerhead Sea Turtle',
    'name_ja': 'アカウミガメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Loggerhead_sea_turtle.jpg/1200px-Loggerhead_sea_turtle.jpg',
    'level': 'EN',
  },
  {
    'name': '中華鱟',
    'name_en': 'Chinese Horseshoe Crab',
    'name_ja': 'チャイニーズホースシュークラブ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/8/82/Tachypleus_tridentatus.jpg',
    'level': 'EN',
  },
  {
    'name': '科摩多巨蜥',
    'name_en': 'Komodo Dragon',
    'name_ja': 'コモドオオトカゲ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Komodo_dragon_%28Varanus_komodoensis%29_3.jpg/1200px-Komodo_dragon_%28Varanus_komodoensis%29_3.jpg',
    'level': 'EN',
  },
  {
    'name': '藍眼鳳頭鸚鵡',
    'name_en': 'Blue-eyed Cockatoo',
    'name_ja': 'アオメフクロウインコ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/b/bb/Cacatua_ophthalmica_-captive-6a.jpg',
    'level': 'VU',
  },
  {
    'name': '大杓鷸',
    'name_en': 'Madagascar Curlew',
    'name_ja': 'マダガスカルオオハシ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Numenius_madagascariensis_%2824579532551%29_%28cropped%29.jpg/1200px-Numenius_madagascariensis_%2824579532551%29_%28cropped%29.jpg',
    'level': 'VU',
  },
  {
    'name': '大灰啄木鳥',
    'name_en': 'Great Slaty Woodpecker',
    'name_ja': 'オオハシキツツキ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Mulleripicus_pulverulentus.jpg/1200px-Mulleripicus_pulverulentus.jpg',
    'level': 'VU',
  },
  {
    'name': '美洲白頸鴉',
    'name_en': 'White-necked Crow',
    'name_ja': 'ハクジョウガラス',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/0/06/White-necked_Crow_%28Corvus_leucognaphalus%29_%288082803278%29.jpg',
    'level': 'VU',
  },
  {
    'name': '漢波德企鵝',
    'name_en': 'Humboldt Penguin',
    'name_ja': 'ヒュンボルトペンギン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Spheniscus_humboldti_%28Humboldt-Pinguine_-_Humboldt_Penguins%29_-_Weltvogelpark_Walsrode_2013-01.jpg/1200px-Spheniscus_humboldti_%28Humboldt-Pinguine_-_Humboldt_Penguins%29_-_Weltvogelpark_Walsrode_2013-01.jpg',
    'level': 'VU',
  },
  {
    'name': '非洲草原象',
    'name_en': 'African Elephant',
    'name_ja': 'アフリカゾウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/%E9%9D%9E%E6%B4%B2%E8%8D%89%E5%8E%9F%E8%B1%A1%E6%A8%99%E6%9C%AC.jpg/1200px-%E9%9D%9E%E6%B4%B2%E8%8D%89%E5%8E%9F%E8%B1%A1%E6%A8%99%E6%9C%AC.jpg',
    'level': 'VU',
  },
  {
    'name': '印度野牛',
    'name_en': 'Gaur',
    'name_ja': 'インドガウル',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/1/1e/Gaur_bandipur.jpg',
    'level': 'VU',
  },
  {
    'name': '長頸鹿',
    'name_en': 'Giraffe',
    'name_ja': 'キリン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Giraffe_Mikumi_National_Park.jpg/1200px-Giraffe_Mikumi_National_Park.jpg',
    'level': 'VU',
  },
  {
    'name': '河馬',
    'name_en': 'Hippopotamus',
    'name_ja': 'カバ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Hipop%C3%B3tamo_%28Hippopotamus_amphibius%29%2C_parque_nacional_de_Chobe%2C_Botsuana%2C_2018-07-28%2C_DD_82.jpg/1200px-Hipop%C3%B3tamo_%28Hippopotamus_amphibius%29%2C_parque_nacional_de_Chobe%2C_Botsuana%2C_2018-07-28%2C_DD_82.jpg',
    'level': 'VU',
  },
  {
    'name': '印度犀牛',
    'name_en': 'Indian Rhinoceros',
    'name_ja': 'インドサイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/f/ff/Indian_Rhinoceros.jpg',
    'level': 'VU',
  },
  {
    'name': '山魈',
    'name_en': 'Mountain Goblin',
    'name_ja': 'ヤマビル',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/9/93/Mandril.jpg',
    'level': 'VU',
  },
  {
    'name': '鬃毛三趾樹懶',
    'name_en': 'Fur Three-toed Sloth',
    'name_ja': 'モヘアスリーツェドスロース',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/3/30/Bradypus_torquatus_BCN.jpg',
    'level': 'VU',
  },
  {
    'name': '山斑馬',
    'name_en': 'Mountain Zebra',
    'name_ja': 'ヤマシマウマ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/0/06/Zebra.zoo.750pix.jpg',
    'level': 'VU',
  },
  {
    'name': '羚牛',
    'name_en': 'Takin',
    'name_ja': 'ジャコウジカ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/3/3a/Budorcas_taxicolor01.jpg',
    'level': 'VU',
  },
  {
    'name': '氂牛',
    'name_en': 'Yak',
    'name_ja': 'ヤク',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Yak.JPG/1200px-Yak.JPG',
    'level': 'VU',
  },
  {
    'name': '獅',
    'name_en': 'Lion',
    'name_ja': 'ライオン',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lion_waiting_in_Namibia.jpg/1200px-Lion_waiting_in_Namibia.jpg',
    'level': 'VU',
  },
  {
    'name': '雲豹',
    'name_en': 'Clouded Leopard',
    'name_ja': 'ユンヒョウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/93/Clouded_leopard.jpg',
    'level': 'VU',
  },
  {
    'name': '雪豹',
    'name_en': 'Snow Leopard',
    'name_ja': 'ユキヒョウ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Irbis4.JPG/1200px-Irbis4.JPG',
    'level': 'VU',
  },
  {
    'name': '北極熊',
    'name_en': 'Polar Bear',
    'name_ja': 'ホッキョクグマ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Polar_Bear_2004-11-15.jpg/1200px-Polar_Bear_2004-11-15.jpg',
    'level': 'VU',
  },
  {
    'name': '懶熊',
    'name_en': 'Sloth Bear',
    'name_ja': 'ツキノワグマ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/3/37/Sloth_bear_1.jpg',
    'level': 'VU',
  },
  {
    'name': '匙吻鱘',
    'name_en': 'Paddlefish',
    'name_ja': 'スプーンノーズ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Polyodon_spathula_%D1%83_%D0%91%D1%83%D0%B4%D0%B0%D0%BF%D0%B5%D1%88%D1%86%D0%BA%D1%96%D0%BC_%D0%90%D0%BA%D0%B5%D0%B0%D0%BD%D0%B0%D1%80%D1%8B%D1%83%D0%BC%D0%B5_14.JPG/1200px-Polyodon_spathula_%D1%83_%D0%91%D1%83%D0%B4%D0%B0%D0%BF%D0%B5%D1%88%D1%86%D0%BA%D1%96%D0%BC_%D0%90%D0%BA%D0%B5%D0%B0%D0%BD%D0%B0%D1%80%D1%8B%D1%83%D0%BC%D0%B5_14.JPG',
    'level': 'VU',
  },
  {
    'name': '鯉',
    'name_en': 'Carp',
    'name_ja': 'コイ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Cyprinus_rubrofuscus_Bleeker.jpg/1200px-Cyprinus_rubrofuscus_Bleeker.jpg',
    'level': 'VU',
  },
  {
    'name': '敘利亞倉鼠',
    'name_en': 'Syrian Hamster',
    'name_ja': 'シリアンハムスター',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/9d/Goldhamster.jpg',
    'level': 'VU',
  },
  {
    'name': '儒艮',
    'name_en': 'Dugong',
    'name_ja': 'ジュゴン',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/f/f3/Dugong.jpg',
    'level': 'VU',
  },
  {
    'name': '海牛屬',
    'name_en': 'Manatee',
    'name_ja': 'マナティー',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/6/6f/FL_fig04.jpg',
    'level': 'VU',
  },
  {
    'name': '大白鯊',
    'name_en': 'Great White Shark',
    'name_ja': 'オオホホジロザメ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/5/56/White_shark.jpg',
    'level': 'VU',
  },
  {
    'name': '美洲鱷',
    'name_en': 'American Alligator',
    'name_ja': 'アメリカワニ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Crocodylus_acutus_mexico_02.jpg/1200px-Crocodylus_acutus_mexico_02.jpg',
    'level': 'VU',
  },
  {
    'name': '眼鏡王蛇',
    'name_en': 'King Cobra',
    'name_ja': 'キングコブラ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Ophiophagus-hannah-kaeng-krachan-national-park.jpg/1200px-Ophiophagus-hannah-kaeng-krachan-national-park.jpg',
    'level': 'VU',
  },
  {
    'name': '澳洲野犬',
    'name_en': 'Dingo',
    'name_ja': 'ディンゴ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/98/Dingo_walking.jpg',
    'level': 'VU',
  },
  {
    'name': '馬島長尾狸貓',
    'name_en': 'Fossa',
    'name_ja': 'フォッサ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Cryptoprocta_Ferox.JPG/1200px-Cryptoprocta_Ferox.JPG',
    'level': 'VU',
  },
  {
    'name': '熊貓',
    'name_en': 'Giant Panda',
    'name_ja': 'ジャイアントパンダ',
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/8/8d/Lightmatter_panda.jpg',
    'level': 'VU',
  },
];
