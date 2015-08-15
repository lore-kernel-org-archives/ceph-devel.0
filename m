From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: async execution framework for rgw
Date: Fri, 14 Aug 2015 19:25:19 -0700
Message-ID: <CADRKj5SLO+xXv=wVqa-CNQdjDuearbFESPV3fdmTGeYZr-0GYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34041 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHOCZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Aug 2015 22:25:20 -0400
Received: by obbfr1 with SMTP id fr1so74961007obb.1
        for <ceph-devel@vger.kernel.org>; Fri, 14 Aug 2015 19:25:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I mentioned it briefly in another email, but here's a more detailed
overview. As part of my current work on the new rgw multi site
synchronization I needed to create new asynchronous execution
infrastructure. The whole work started originally as I was tackling
async connection handling with curl (that is used for cross rgw
communications). It evolved into what I eventually identified last
week as a coroutines framework, which was pretty much accidental.

This is mainly a description of how the api is used, and is by no way
a solicitation for using it. Use what works and makes sense for you.

Note that the class names could change later.

RGWCoroutine: abstract class that is used to define the execution
flow. It comprises of an implicit state machine that needs to be
implemented. It can call another RGWCoroutine, or can spawn a
concurrent (not parallel!) coroutine. There is a stack of execution
that is always defined, so control will return to the caller only
after the called coroutine finishes execution. However, spawning a
concurrent routine will generate a separate execution stack and will
not block our execution (unless specifically specified).

Here's an example of a trivial coroutine:

int RGWSimpleCoroutine::operate()
{
  int ret = 0;
  reenter(this) {
    yield return state_init();
    yield return state_send_request();
    yield return state_request_complete();
    yield return state_all_complete();
    while (stack->collect(&ret)) {
      yield;
    }
    return set_state(RGWCoroutine_Done, ret);
  }
  return 0;
}

It implements an abstract request processor with a defined lifecycle.

When a coroutine is about to generate an asynchronous IO that will
block, it will mark itself as blocking and yield control. The IO
itself will be registered on an event IO manager that the execution
manager will poll (or wait on if needed). Once the IO finishes, the
execution manager will unblock the appropriate execution stack and
execution can resume.
It is possible for a coroutine to put itself in a sleep state that
will require another coroutine to wake it up. This is useful e.g.,
when implementing producer / consumer. The consumer will sleep until
more data is available from the producer. I created a simple wrap
around it (RGWConsumerCR<>), here's how the consumer code can look
like:


/* consumer */
  int operate() {
    reenter(this) {
      for (;;) {
        if (!has_product() && going_down) {
          break;
        }
        yield wait_for_product();
        yield {
          string entry;
          while (consume(&entry)) {
... // do something with the new entry
          }
        }
        if (get_ret_status() < 0) {
          return set_state(RGWCoroutine_Error);
        }
      }
      /* done with coroutine */
      return set_state(RGWCoroutine_Done);
    }
    return 0;
  }

The reenter and yield macros here we get from the boost async aio
library, and they make it possible for us to define everything in a
single method.

Keep in mind that the code is not really going to block when calling
wait_for_product(), it will just yield execution and we'll return
after the producer called our receive() method with more data. I'll
probably create a higher level abstractions of this functionality, and
there will be a more trivial way to create these kind of constructs.

I implemented a few coroutines that provide raw rados functionality
(e.g., set omap keys), and also some that call to specific RGWRados
methods (e.g., create / read metadata objects). Calling such a
coroutine goes like this:

            call(new RGWRadosSetOmapKeysCR(async_rados, store, pool,
oid, entries));

As mentioned before, this will yield execution, will push the called
coroutine into the stack. The routine itself will set the stack as
'blocked' after doing the async IO, and registers itself on the event
manager. Once the IO completes, it will be called again, fold back,
and the original callers will continue execution. We can get the exit
status code of this coroutine.

Another example, spawning a concurrent coroutine:

          spawn(new
RGWSimpleRadosWriteCR<rgw_meta_sync_marker>(async_rados, store,
store->get_zone_params().log_pool,
                         RGWMetaSyncStatusManager::shard_obj_name(i), marker));

This will create a new stack for the new coroutine, and it will
execute concurrently (that is, when its turn comes). Eventually we
will need to collect() it.

Note that since some of the RGWRados calls are completely synchronous,
and it's a bit challenging turning it into actual async calls, I
cheated a bit and created async versions of these methods using a
workqueue that runs on a separate thread. This can eventually be
replaced by actual async implementation, but considering where this is
going to be used, it's a good enough solution for now.

And here's how things tie together:

      /* lock */
      yield call(new RGWSimpleRadosLockCR(...));
      yield {
        for (int i = 0; i < (int)status.num_shards; i++) {
          rgw_meta_sync_marker marker;
          spawn(new RGWSimpleRadosWriteCR<rgw_meta_sync_marker>(..., true);
        }
      }
      /* unlock */
      yield call(new RGWSimpleRadosUnlockCR(...));

In this example we locked the control object, wrote all the shards,
waited for them to complete (note the 'true' in spawn), and unlocked
the control object. Currently if the lease expires before we finish
we're in trouble, but it should be relatively easy to add an option to
be able to renew the lease, e.g., have a special kind of spawn that
will execute after a specified amount of seconds.

That's about it. I didn't really cover how the execution management
works, and skipped some other details, but this is the general idea.

Any comments are appreciated as always.

Yehuda
