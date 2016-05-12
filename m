From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Could be due to a race condition... Re: Help with understanding
 throttle.finish()
Date: Fri, 13 May 2016 00:51:05 +0200
Message-ID: <169e9370-3b9e-f9bc-13f8-bac404786ca2@digiware.nl>
References: <57225355.3040401@digiware.nl>
 <8402c73a-d6c4-6ad7-453e-c100e7376e72@digiware.nl>
 <CAJ4mKGZDvFPAZmhF1c=b07=myW7-y+SgEONL1zyB+piV-r50Hg@mail.gmail.com>
 <828fd24d-f73d-42e6-69e0-d9f6c5811edd@digiware.nl>
 <b34f7765-7db5-713d-5ed2-3374b0ec9872@digiware.nl>
 <e599f4b3-738c-6419-6397-317ad9178ac9@digiware.nl>
 <CAJ4mKGYCH0J6fQViAAMkRqDJU-+7+QCJJgZsBvOhjezqxhLJJw@mail.gmail.com>
 <11fc6ed5-06e0-26a5-ad5c-b79367e8ab53@digiware.nl>
 <CAN=+7FWBEMBGJ9Zuy=etbGSK8n-3onwrt3HugKAFVCBF8cSMHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:18214 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcELWvm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2016 18:51:42 -0400
In-Reply-To: <CAN=+7FWBEMBGJ9Zuy=etbGSK8n-3onwrt3HugKAFVCBF8cSMHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13-5-2016 00:22, Samuel Just wrote:
> That sounds reasonable.

Submitted in #9111

--WjW

> -Sam
> 
> On Thu, May 12, 2016 at 2:02 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 11-5-2016 15:43, Gregory Farnum wrote:
>>>
>>> I've been busy lately. Looks like Sam wrote the BackoffThrottle; not
>>> sure if he did the tests as well or not. Maybe check the git logs on
>>> them. :)
>>
>>
>> Well, the test is also written bij Sam.
>>
>> But everything gets stuck in the loop at BackoffThrottle::get(uint64_t
>> c):379 :
>> ====
>>   while (((start + delay) > std::chrono::system_clock::now()) ||
>>          !((max == 0) || (current == 0) || ((current + c) <= max))) {
>>     assert(ticket == waiters.begin());
>>     (*ticket)->wait_until(l, start + delay);
>>     delay = _get_delay(c);
>>   }
>> ====
>>
>> And I have the feeling that the lock is not released (long enough) when
>> start+delay is actually in the past.
>> It is of course also doubtfull what is actually expected from the
>> wait_until function in this case???
>>
>> Replacing it with
>>         (*ticket)->wait_for(l, delay);
>> Does get the BackoffThrottle.oversaturated test completed.
>>
>> So would this be a appropriate modification?
>>
>> --WjW
>>
>>
>>> -Greg
>>>
>>> On Wed, May 11, 2016 at 2:46 AM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> On 9-5-2016 10:44, Willem Jan Withagen wrote:
>>>>>
>>>>>
>>>>> On 6-5-2016 23:04, Willem Jan Withagen wrote:
>>>>>>
>>>>>>
>>>>>> On 6-5-2016 20:41, Gregory Farnum wrote:
>>>>
>>>>
>>>>
>>>> Hi Greg,
>>>>
>>>> If you are not the one to ask about the Throttle stuff, would you know
>>>> anybody else I could ask this question.
>>>> Because the more runs I make, the more it seems like it is a livelock.
>>>>
>>>> I'm now going to do the annotated runs on Linux as well, and try and
>>>> find out why it doesn't happen there.
>>>>
>>>> --WjW
>>>>
>>>>> Oke,
>>>>>
>>>>> I'm going to need some help understanding some things...
>>>>>
>>>>> I've taken the oversaturated test_backoff from test/common/Throttle.cc,
>>>>> since that one wasn't working as well. And I suspect that it might be
>>>>> for about the same/similar reason.
>>>>>
>>>>> I start 1 putter and one getter, and with certain parameters the test
>>>>> does not complete. When
>>>>>     expected_throughput * put_delay_per_count ~> 10 (max_multiple??)
>>>>> then the process get into a loop, I'm printing over and over:
>>>>> _get_delay return r > high_threshhold (queue is full): time = 0.0172
>>>>>
>>>>> Note that the parameters to test_backoff are:
>>>>> ====
>>>>> //  double expected_throughput,
>>>>>     500,
>>>>> //  double max_multiple,
>>>>>     10,
>>>>> //  double put_delay_per_count,
>>>>>     0.025,
>>>>> ====
>>>>>
>>>>> And that loop is in BackoffThrottle::get, around line 390 (I have a lot
>>>>> of extra lines for annotation and tracing.)
>>>>> ====
>>>>>   while (((start + delay) > std::chrono::system_clock::now()) ||
>>>>>          !((max == 0) || (current == 0) || ((current + c) <= max))) {
>>>>>     assert(ticket == waiters.begin());
>>>>>     (*ticket)->wait_until(l, start + delay);
>>>>>     delay = _get_delay(c);
>>>>>   }
>>>>> ====
>>>>>
>>>>> The reason that this loop never completes is that it executed under the
>>>>> lock in the getter thread in test/common/Throttle.cc:test_backoff where
>>>>> it is executed under g.lock(). And the putter is held on the same lock,
>>>>> so nothing gets in or out.... Not a deadlock, but a live-lock.
>>>>>
>>>>> Thusfar the analysis.
>>>>>
>>>>> Now the question(s)....
>>>>> 1) How do I break this livelock.
>>>>> 1a) Should the extra while() { wait } loop actually be in
>>>>> BackoffThrottle:get without releasing the lock?
>>>>>
>>>>> 2) The thread are called getter and putter.
>>>>> So I'd expect the getter to get messages from the list and the putter so
>>>>> write things to the list.
>>>>>
>>>>> Why does the getter:
>>>>>         while(!stop) {
>>>>>             throttle.get(to_get);
>>>>>             in_queue.push_back(to_get)
>>>>>             assert(total <= max);
>>>>>         }
>>>>> And the putter:
>>>>>         while(!stop) {
>>>>>             while(empty)
>>>>>                 wait;
>>>>>             c = in_queue.front();
>>>>>             in_queue.pop();
>>>>>             "wait time to queue some more"
>>>>>             throttle.put(c)
>>>>>         }
>>>>>
>>>>> Am I getting it wrong around, and would I not expect the
>>>>> throttle.{get,put} to match the similar operations on the in_queue?
>>>>>
>>>>> And what is this c value that we retrieve from the in_queue that is then
>>>>> used to be put in the throttle???
>>>>>
>>>>> --WjW
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>

