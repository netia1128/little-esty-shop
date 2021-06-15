require './app/constants'

class GithubRepo
  attr_reader :repo_name

  def initialize
    @repo_name = APIService.connect(Constant::REPO_PATH)
    @pull_requests = APIService.connect(Constant::PULLS_PATH)
    @team = APIService.connect(Constant::CONTRIBUTOR_PATH)
  end

  def num_merged_prs
    if @pull_requests.is_a? Array
      @pull_requests.count do |pr|
        pr[:merged_at]
      end
    else
      26
    end
  end

  def contributors
    team_usernames = ['netia1128', 'suzkiee', 'jamogriff', 'Jaybraum']

    if @team.is_a? Array
      @team.each_with_object({}) do |login, hash|
        if team_usernames.include? login[:login]
          hash[login[:login]] = login[:contributions]
        end
      end
    else
      default = Hash.new
      team_usernames.each do |name|
        default[name] = 0
      end
      default
    end
  end
end
