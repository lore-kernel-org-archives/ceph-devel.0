From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Could be due to a race condition... Re: Help with understanding
 throttle.finish()
Date: Mon, 9 May 2016 10:44:19 +0200
Message-ID: <b34f7765-7db5-713d-5ed2-3374b0ec9872@digiware.nl>
References: <57225355.3040401@digiware.nl>
 <8402c73a-d6c4-6ad7-453e-c100e7376e72@digiware.nl>
 <CAJ4mKGZDvFPAZmhF1c=b07=myW7-y+SgEONL1zyB+piV-r50Hg@mail.gmail.com>
 <828fd24d-f73d-42e6-69e0-d9f6c5811edd@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:26856 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbcEIIoc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2016 04:44:32 -0400
In-Reply-To: <828fd24d-f73d-42e6-69e0-d9f6c5811edd@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 6-5-2016 23:04, Willem Jan Withagen wrote:
> On 6-5-2016 20:41, Gregory Farnum wrote:

Oke,

I'm going to need some help understanding some things...

I've taken the oversaturated test_backoff from test/common/Throttle.cc,
since that one wasn't working as well. And I suspect that it might be
for about the same/similar reason.

I start 1 putter and one getter, and with certain parameters the test
does not complete. When
    expected_throughput * put_delay_per_count ~> 10 (max_multiple??)
then the process get into a loop, I'm printing over and over:
_get_delay return r > high_threshhold (queue is full): time = 0.0172

Note that the parameters to test_backoff are:
====
//  double expected_throughput,
    500,
//  double max_multiple,
    10,
//  double put_delay_per_count,
    0.025,
====

And that loop is in BackoffThrottle::get, around line 390 (I have a lot
of extra lines for annotation and tracing.)
====
  while (((start + delay) > std::chrono::system_clock::now()) ||
         !((max == 0) || (current == 0) || ((current + c) <= max))) {
    assert(ticket == waiters.begin());
    (*ticket)->wait_until(l, start + delay);
    delay = _get_delay(c);
  }
====

The reason that this loop never completes is that it executed under the
lock in the getter thread in test/common/Throttle.cc:test_backoff where
it is executed under g.lock(). And the putter is held on the same lock,
so nothing gets in or out.... Not a deadlock, but a live-lock.

Thusfar the analysis.

Now the question(s)....
1) How do I break this livelock.
1a) Should the extra while() { wait } loop actually be in
BackoffThrottle:get without releasing the lock?

2) The thread are called getter and putter.
So I'd expect the getter to get messages from the list and the putter so
write things to the list.

Why does the getter:
	while(!stop) {
	    throttle.get(to_get);
	    in_queue.push_back(to_get)
	    assert(total <= max);
	}
And the putter:
	while(!stop) {
	    while(empty)
		wait;
	    c = in_queue.front();
	    in_queue.pop();
	    "wait time to queue some more"
	    throttle.put(c)
	}

Am I getting it wrong around, and would I not expect the
throttle.{get,put} to match the similar operations on the in_queue?

And what is this c value that we retrieve from the in_queue that is then
used to be put in the throttle???

--WjW
