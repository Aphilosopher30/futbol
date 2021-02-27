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

    #CSV.stubs(:foreach).returns([])

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

  # def test_best_season
  #   path = "./fixture/games_dummy15.csv"
  #   game_team_manager = GameTeamsManager.new(path)
  #
  #   assert_equal Hash, game_team_manager.best_season("6").class
  # end
end
