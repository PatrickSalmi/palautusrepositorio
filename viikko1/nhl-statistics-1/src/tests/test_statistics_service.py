import unittest
from statistics_service import StatisticsService
from player import Player

class PlayerReaderStub:
    def get_players(self):
        return [
            Player("Semenko", "EDM", 4, 12),
            Player("Lemieux", "PIT", 45, 54),
            Player("Kurri",   "EDM", 37, 53),
            Player("Yzerman", "DET", 42, 56),
            Player("Gretzky", "EDM", 35, 89)
        ]

class TestStatisticsService(unittest.TestCase):
    def setUp(self):
        # annetaan StatisticsService-luokan oliolle "stub"-luokan olio
        self.stats = StatisticsService(
            PlayerReaderStub()
        )
    
    def test_search_with_valid_player(self):
        self.assertEqual(self.stats.search("Semenko").name, "Semenko")
      
    def test_serch_with_non_valid_player(self):
        self.assertEqual(self.stats.search("asd"), None)
        
    def test_team_returns_players(self):
        team = self.stats.team("DET")
        
        self.assertEqual(len(team), 1)
        self.assertEqual(team[0].name, "Yzerman")
        
    def test_top_sorting_works(self):
        sorted_players = self.stats.top(3)
        
        self.assertEqual(len(sorted_players), 3)
        self.assertEqual(sorted_players[0].name, "Gretzky")
        
    
        