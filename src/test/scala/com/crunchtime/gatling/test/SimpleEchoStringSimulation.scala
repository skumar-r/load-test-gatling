package com.crunchtime.gatling.test

import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder
import io.gatling.http.Predef._
import io.gatling.http.protocol.HttpProtocolBuilder

import scala.concurrent.duration.DurationInt


class SimpleEchoStringSimulation extends Simulation {
	val protocol: HttpProtocolBuilder = http.baseUrl("http://host.docker.internal:9095/")
	val scn: ScenarioBuilder = scenario("Load testing of Echo String API")
		.exec(
			http("Echo the input back")
				.get("api/echo/Hello")
				.check(status.is(200))
		)

	//5,10,15,20
	setUp(scn.inject(
		incrementConcurrentUsers(5)
			.times(4)
			.eachLevelLasting(2.seconds)
			.separatedByRampsLasting(2.seconds)
			.startingFrom(5)
	)
		.protocols(protocol))
		.maxDuration(1800)
		.assertions(global.responseTime.max.lt(20000), global.successfulRequests.percent.gt(95))
}