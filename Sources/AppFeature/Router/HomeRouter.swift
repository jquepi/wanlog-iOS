import Core
import DogFeature
import HomeFeature
import ScheduleFeature
import SwiftUI

public class HomeRouter: Routing {
  public init() {}

  @ViewBuilder
  public func view(for route: HomeRoute) -> some View {
    switch route {
    case .schedule(let query):
      SchedulePage(
        query: query,
        router: ScheduleRouter()
      )
    case .dogList:
      DogsListPage(router: DogRouter())
    case .history:
      Text("history")
    }
  }

  public func route(from deeplink: URL) -> HomeRoute? {
    nil
  }
}

struct ScheduleRouter: Routing {
  @ViewBuilder
  func view(for route: ScheduleRoute) -> some View {
    switch route {
    case .create:
      CreateSchedulePage()
    case .detail(let schedule):
      UpdateSchedulePage(schedule: schedule)
    }
  }
}
