require './test/test_helper'
require './lib/game_teams_manager'
require 'CSV'

class GameTeamsManagerTest < Minitest::Test

  def test_it_exists

    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    assert_instance_of GameTeamsManager, game_team_manager
  end

  def test_it_has_attributes
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    assert_equal 15, game_team_manager.game_teams.length
    assert_instance_of GameTeam, game_team_manager.game_teams[0]
    assert_instance_of GameTeam, game_team_manager.game_teams[-1]
  end

  def test_get_team_tackle_hash
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]
    test = game_team_manager.get_team_tackle_hash(game_ids)

    assert_instance_of Hash, test
    assert_equal 77, test["3"]
    assert_equal 87, test["6"]
  end

  def test_score_ratios_hash
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal (4.0/17.0), game_team_manager.score_ratios_hash(game_ids)["3"]
    assert_equal (6.0/20.0), game_team_manager.score_ratios_hash(game_ids)["6"]
  end

  def test_score_shots_by_team
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal [4, 17], game_team_manager.score_and_shots_by_team(game_ids)["3"]
    assert_equal [6, 20], game_team_manager.score_and_shots_by_team(game_ids)["6"]
  end

  def test_calculate_ratios
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    pair = [3, 6]

    assert_equal 0.5, game_team_manager.calculate_ratios(pair)
  end

  def test_winningest_coach
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal "Claude Julien", game_team_manager.winningest_coach(game_ids)
  end

  def test_worst_coach
    path = "./fixture/game_teams_dummy15.csv"
    game_team_manager = GameTeamsManager.new(path)

    game_ids = ["2012030221", "2012030222"]

    assert_equal "John Tortorella", game_team_manager.worst_coach(game_ids)
  end

  def test_total_games_by_team_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    expected = {"3"=>5, "6"=>7, "5"=>3}

    assert_equal expected, game_teams_manager.total_games_by_team
  end

  def test_best_offense_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal "6", game_teams_manager.best_offense
  end

  def test_worst_offense_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_equal "5", game_teams_manager.worst_offense
  end

  def test_total_goals_by_team_dummy_file
    path = "./fixture/game_teams_dummy15.csv"
    game_teams_manager = GameTeamsManager.new(path)

    expected = {"3"=>8, "6"=>21, "5"=>2}

    assert_equal expected, game_teams_manager.total_goals_by_team
  end

  def test_favorite_opponent
    path = "./data/game_teams.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_instance_of String, game_teams_manager.favorite_opponent("6")
  end

  def test_rival
    path = "./data/game_teams.csv"
    game_teams_manager = GameTeamsManager.new(path)

    assert_instance_of String, game_teams_manager.rival("6")
  end

  def test_sum_values
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    key_value_arr = [[1, 1], [2, 2]]
    expected = {1 => 1, 2 => 2}

    assert_equal expected, game_manager.sum_values(key_value_arr)
  end

  def test_min_max_average_hash
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)


    hash_1 = {"22"=>479,
               "7"=>430,
               "27"=>120,
               "53"=>303}

    hash_2 = {"22"=>236,
               "7"=>229,
               "27"=>65,
               "53"=>164}

    assert_equal "27", game_manager.min_max_average_hash(hash_1, hash_2, min = 0)
    assert_equal "22", game_manager.min_max_average_hash(hash_1, hash_2, max = 1)
  end

  def test_get_percentage_rounded_hundreth
    path = "./data/games.csv"
    game_manager = GamesManager.new(path)

    assert_equal 0.31, game_manager.get_percentage(5, 16)
  end
end
