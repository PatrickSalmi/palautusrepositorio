import requests
from player import Player

class PlayerReader:
    def __init__(self, url):
        self.url = url

    def get_player(self):
        response = requests.get(self.url).json()
        players = []

        for player_dict in response:
            player = Player(player_dict)
            players.append(player)
        return players

class PlayerStats:
    def __init__(self, reader):
        self.reader = reader

    def top_scorers_by_nationality(self, nationality):
        players = self.reader.get_player()
        players = list(filter(lambda player: player.nationality == nationality, players))

        return sorted(players, key=lambda player: player.goals + player.assists, reverse=True)


def main():
    url = "https://studies.cs.helsinki.fi/nhlstats/2022-23/players"
    reader = PlayerReader(url)
    stats = PlayerStats(reader)
    players = stats.top_scorers_by_nationality("FIN")

    for player in players:
        print(player)



if __name__ == "__main__":
    main()
