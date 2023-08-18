/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_GAME_DISPATCHER_H_
#define SRC_GAME_DISPATCHER_H_

#include "lib/thread/thread_pool.hpp"

const int DISPATCHER_TASK_EXPIRATION = 2000;

class Task;

/**
 * Dispatcher allow you to dispatch a task async to be executed
 * in the dispatching thread. You can dispatch with an expiration
 * time, after which the task will be ignored.
 */
class Dispatcher {
	public:
		explicit Dispatcher(ThreadPool &threadPool);

		// Ensures that we don't accidentally copy it
		Dispatcher(const Dispatcher &) = delete;
		Dispatcher operator=(const Dispatcher &) = delete;

		static Dispatcher &getInstance();

		void addTask(std::function<void(void)> f, uint32_t expiresAfterMs = 0);
		void addTask(const std::shared_ptr<Task> &task, uint32_t expiresAfterMs = 0);

		[[nodiscard]] uint64_t getDispatcherCycle() const {
			return dispatcherCycle;
		}

	private:
		ThreadPool &threadPool;
		uint64_t dispatcherCycle = 0;
		std::mutex threadSafetyMutex;
};

constexpr auto g_dispatcher = Dispatcher::getInstance;

#endif // SRC_GAME_DISPATCHER_H_