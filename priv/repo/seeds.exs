# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Meetup.Repo.insert!(%Meetup.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Meetup.Repo
alias Meetup.Conf
alias Conf.Speaker

# Insert speakers
Repo.insert!(%Speaker{
  name: "John Doe",
  position: "Software Engineer",
  age: 30,
  is_prepared_well: true,
  super_power: "Elixir",
  company: "Elixir Inc.",
  topic: "Elixir for beginners"
})

speakers = [
  %{
    name: "Нұржан Қабидолла",
    age: 34,
    position: "Инженер-программист",
    is_prepared_well: true,
    super_power: "Кодтау жылдамдығы",
    company: "АлмаTech",
    topic: "Функционалды программалаудағы мүмкіндіктер"
  },
  %{
    name: "Айжан Ержанова",
    age: 29,
    position: "Деректер талдаушысы",
    is_prepared_well: true,
    super_power: "Деректерді дәл талдау",
    company: "Астана Аналитика",
    topic: "Үлкен деректерді басқару"
  },
  %{
    name: "Бекзат Оспанов",
    age: 40,
    position: "Жетекші әзірлеуші",
    is_prepared_well: false,
    super_power: "Жоба басқару шеберлігі",
    company: "Инновация Орталығы",
    topic: "IT жобаларындағы көшбасшылық"
  },
  %{
    name: "Мадина Абдрахманова",
    age: 25,
    position: "UI/UX дизайнер",
    is_prepared_well: true,
    super_power: "Пайдаланушы тәжірибесін жақсарту",
    company: "Дизайн Студиясы",
    topic: "Қолданушы интерфейстерін жобалау"
  },
  %{
    name: "Әлихан Жұман",
    age: 32,
    position: "Мобильді қосымша әзірлеуші",
    is_prepared_well: false,
    super_power: "Мобильді даму",
    company: "МобТех",
    topic: "Flutter-дағы мобильді қосымшаларды жасау"
  },
  %{
    name: "Гүлжан Қасымбекова",
    age: 37,
    position: "Бұлттық инженер",
    is_prepared_well: true,
    super_power: "Бұлттық жүйелерді басқару",
    company: "Күнбайнет",
    topic: "Кәсіпорындар үшін бұлттық шешімдер"
  },
  %{
    name: "Асылжан Омаров",
    age: 45,
    position: "Машиналық оқыту маманы",
    is_prepared_well: true,
    super_power: "Нейрондық желілерді дамыту",
    company: "КазАИ",
    topic: "Машиналық оқыту негіздері"
  },
  %{
    name: "Қайрат Әлім",
    age: 28,
    position: "Программалық жасақтама әзірлеуші",
    is_prepared_well: false,
    super_power: "Код оңтайландыру",
    company: "SoftHouse",
    topic: "Сапалы код жазу әдістемесі"
  },
  %{
    name: "Жансая Төлеу",
    age: 31,
    position: "QA инженер",
    is_prepared_well: true,
    super_power: "Тестілеу үрдісін оңтайландыру",
    company: "ТестМастерс",
    topic: "Программалық жасақтаманы автоматтандырылған тестілеу"
  },
  %{
    name: "Ерболат Сыдықов",
    age: 38,
    position: "Сүлбелер инженер",
    is_prepared_well: true,
    super_power: "Үлкен жүйелерді жоспарлау",
    company: "KazArch",
    topic: "Сүлбелердегі тиімділікті арттыру"
  },
  %{
    name: "Мұрат Құрманов",
    age: 50,
    position: "Жүйелік администратор",
    is_prepared_well: false,
    super_power: "Желі ақауларын жою",
    company: "TechSupport.kz",
    topic: "Желі қауіпсіздігі және басқару"
  },
  %{
    name: "Динара Әділбекова",
    age: 30,
    position: "Жасанды интеллект зерттеуші",
    is_prepared_well: true,
    super_power: "Деректерді болжау",
    company: "SmartAI",
    topic: "Жасанды интеллекттің болашағы"
  },
  %{
    name: "Алима Шамшиденова",
    age: 26,
    position: "Продукт менеджері",
    is_prepared_well: false,
    super_power: "Өнімділікті арттыру",
    company: "ProdX",
    topic: "Продукт менеджменттегі инновациялар"
  },
  %{
    name: "Серік Молдағалиев",
    age: 43,
    position: "Киберқауіпсіздік сарапшысы",
    is_prepared_well: true,
    super_power: "Қауіпсіздік қатерлерін болжау",
    company: "CyberSafe",
    topic: "Кибершабуылдардан қорғану стратегиялары"
  },
  %{
    name: "Жанарбек Төлепбергенов",
    age: 35,
    position: "Веб әзірлеуші",
    is_prepared_well: true,
    super_power: "Web технологиялары",
    company: "WebDev.kz",
    topic: "Модерн веб-қосымшаларды әзірлеу"
  }
]

Enum.each(speakers, fn speaker ->
  Conf.create_speaker(speaker)
end)
