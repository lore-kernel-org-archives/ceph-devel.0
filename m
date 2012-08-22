From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Wed, 22 Aug 2012 07:29:31 +0200
Message-ID: <50346E3B.60602@itxperts.de>
References: <502D1B07.3030101@itxperts.de>	<alpine.DEB.2.00.1208160951190.26904@cobra.newdream.net>	<50323001.5050300@itxperts.de>	<alpine.DEB.2.00.1208201320160.26904@cobra.newdream.net>	<5033599C.70504@itxperts.de>	<alpine.DEB.2.00.1208211105170.32470@cobra.newdream.net>	<alpine.DEB.2.00.1208211217560.29978@cobra.newdream.net> <CA+4uBUan6jUon6SbVTxZTcTcAa4GYOWeXLgLW7upW41LLO=Vog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:37739 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab2HVF3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 01:29:36 -0400
In-Reply-To: <CA+4uBUan6jUon6SbVTxZTcTcAa4GYOWeXLgLW7upW41LLO=Vog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Hi,

Samuel Just wrote:
> Was the cluster complete healthy at the time that those traces were taken?
> If there were osds going in/out/up/down, it would trigger osdmap updates which
> would tend to hold the osd_lock for an extended period of time.
>
>   
The cluster was completely healthy.
> v0.50 included some changes that drastically reduce the purview of osd_lock.
> In particular, pg op handling no longer grabs the osd_lock and handle_osd_map
> can proceed independently of the pg worker threads.  Trying that might be
> interesting.
>
>   
I'll grab v0.50 and take a look.

> -Sam
>
> On Tue, Aug 21, 2012 at 12:20 PM, Sage Weil <sage@inktank.com> wrote:
>   
>> On Tue, 21 Aug 2012, Sage Weil wrote:
>>     
>>> On Tue, 21 Aug 2012, Andreas Bluemle wrote:
>>>       
>>>> Hi Sage,
>>>>
>>>> as mentioned, the workload is a single sequential write on
>>>> the client. The write is not O_DIRECT; and consequently
>>>> the messages arrive at the OSD with 124 KByte per write request.
>>>>
>>>> The attached pdf shows a timing diagram of two concurrent
>>>> write operations (one primary and one replication / secondary).
>>>>
>>>> The time spent on the primary write to get the OSD.:osd_lock
>>>> releates nicely with the time when this lock is released by the
>>>> secondary write.
>>>>         
>> Looking again at this diagram, I'm a bit confused.  Is the Y access the
>> thread id or something?  And the X axis is time in seconds?
>>
>>     
X-Axis is time, Y Axis is absolute offset of the write request on the 
rados block device.
>> The big question for me is what on earth the secondary write (or primary,
>> for that matter) is doing with osd_lock for a full 3 ms...  If my reading
>> of the units is correct, *that* is the real problem.  It shouldn't be
>> doing anything that takes that long.  The exception is osdmap handling,
>> which can do more work, but request processing should be very fast.
>>
>> Thanks-
>> sage
>>
>>
>>     
>>> Ah, I see.
>>>
>>> There isn't a trivial way to pull osd_lock out of the picture; there are
>>> several data structures it's protecting (pg_map, osdmaps, peer epoch map,
>>> etc.).  Before we try going down that road, I suspect it might be more
>>> fruitful to see where cpu time is being spent while osd_lock is held.
>>>
>>> How much of an issue does it look like this specific contention is for
>>> you?  Does it go away with larger writes?
>>>
>>> sage
>>>
>>>
>>>       
>>>> Hope this helps
>>>>
>>>> Andreas
>>>>
>>>>
>>>>
>>>> Sage Weil wrote:
>>>>         
>>>>> On Mon, 20 Aug 2012, Andreas Bluemle wrote:
>>>>>
>>>>>           
>>>>>> Hi Sage,
>>>>>>
>>>>>> Sage Weil wrote:
>>>>>>
>>>>>>             
>>>>>>> Hi Andreas,
>>>>>>>
>>>>>>> On Thu, 16 Aug 2012, Andreas Bluemle wrote:
>>>>>>>
>>>>>>>               
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
>>>>>>>> to a high speed cluster network and encounter scalability problems:
>>>>>>>> the overall performance of the ceph cluster does not scale well
>>>>>>>> with an increase in the underlying networking speed.
>>>>>>>>
>>>>>>>> In short:
>>>>>>>>
>>>>>>>> I believe that the dispatching from SimpleMessenger to
>>>>>>>> OSD worker queues causes that scalability issue.
>>>>>>>>
>>>>>>>> Question: is it possible that this dispatching is causing performance
>>>>>>>> problems?
>>>>>>>>
>>>>>>>>                 
>>>>>>> There is a single 'dispatch' thread that's processing this queue, and
>>>>>>> conveniently perf lets you break down its profiling data on a per-thread
>>>>>>> basis.  Once you've ruled out the throttler as the culprit, you might
>>>>>>> try
>>>>>>> running the daemon with 'perf record -g -- ceph-osd ...' and then look
>>>>>>> specifically at where that thread is spending its time.  We shouldn't be
>>>>>>> burning that much CPU just doing the sanity checks and then handing
>>>>>>> requests
>>>>>>> off to PGs...
>>>>>>>
>>>>>>> sage
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>   The effect, which I am seeing, may be related to some locking issue.
>>>>>> As I read the code, there are multiple dispatchers running: one per
>>>>>> SimpleMessenger.
>>>>>>
>>>>>> On a typical OSD node, there is
>>>>>>
>>>>>> - the instance of the SimpleMessenger processing input from the client
>>>>>> (primary writes)
>>>>>> - other instances of SimpleMessenger, which process input from neighbor
>>>>>> OSD
>>>>>> nodes
>>>>>>
>>>>>> the latter generate replication writes to the OSD I am looking at.
>>>>>>
>>>>>> On the other hand, there is a single instance of the OSD object within the
>>>>>> ceph-osd daemon.
>>>>>> When dispatching messages to the OSD, then the OSD::osd_lock is held for
>>>>>> the
>>>>>> complete
>>>>>> process of dispatching; see code below.
>>>>>>
>>>>>> When the write load increases, then multiple SimpleMessenger instances
>>>>>> start
>>>>>> to
>>>>>> congest on the OSD::osd_lock.
>>>>>> And this may cause delays in the individual dispatch process.
>>>>>>
>>>>>>             
>>>>> This is definitely possible, yes, although it would surprise me if it's
>>>>> happening here (unless your workload is all small writes).  Just to confirm,
>>>>> are you actually observing osd_lock contention, or speculating about what is
>>>>> causing the delays you're seeing?
>>>>>
>>>>> I'm not sure what the best tool is to measure lock contention.  Mark was
>>>>> playing with a 'poor man's wall clock profiler' using stack trace sampling
>>>>> from gdb.  That would tell us whether threads were really blocking while
>>>>> obtaining the osd_lock...
>>>>>
>>>>> Can you tell us a bit more about what your workload is?
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>
>>>>>           
>>>>>> bool OSD::ms_dispatch(Message *m)
>>>>>> {
>>>>>> // lock!
>>>>>> osd_lock.Lock();
>>>>>>
>>>>>> while (dispatch_running) {
>>>>>> dout(10) << "ms_dispatch waiting for other dispatch thread to complete" <<
>>>>>> dendl;
>>>>>> dispatch_cond.Wait(osd_lock);
>>>>>> }
>>>>>> dispatch_running = true;
>>>>>>
>>>>>> do_waiters();
>>>>>> _dispatch(m);
>>>>>> do_waiters();
>>>>>>
>>>>>> dispatch_running = false;
>>>>>> dispatch_cond.Signal();
>>>>>>
>>>>>> osd_lock.Unlock();
>>>>>> return true;
>>>>>> }
>>>>>>
>>>>>>
>>>>>>
>>>>>>             
>>>>>>>> In detail:
>>>>>>>>
>>>>>>>> In order to find out more about this problem, I have added profiling
>>>>>>>> to
>>>>>>>> the ceph code in various place; for write operations to the primary or
>>>>>>>> the
>>>>>>>> secondary, timestamps are recorded for OSD object, offset and length
>>>>>>>> of
>>>>>>>> the such a write request.
>>>>>>>>
>>>>>>>> Timestamps record:
>>>>>>>>  - receipt time at SimpleMessenger
>>>>>>>>  - processing time at osd
>>>>>>>>  - for primary write operations: wait time until replication operation
>>>>>>>>    is acknowledged.
>>>>>>>>
>>>>>>>> What I believe is happening: dispatching requests from SimpleMessenger
>>>>>>>> to
>>>>>>>> OSD worker threads seems to consume a fair amount of time. This ends
>>>>>>>> up in a widening gap between subsequent receipts of requests and the
>>>>>>>> start
>>>>>>>> of OSD processing them.
>>>>>>>>
>>>>>>>> A primary write suffers twice from this problem: first because
>>>>>>>> the delay happens on the primary OSD and second because the
>>>>>>>> replicating
>>>>>>>> OSD also suffers from the same problem - and hence causes additional
>>>>>>>> delays
>>>>>>>> at the primary OSD when it waits for the commit from the replicating
>>>>>>>> OSD.
>>>>>>>>
>>>>>>>> In the attached graphics, the x-axis shows the time (in seconds)
>>>>>>>> The y-axis shows the offset where a request to write happened.
>>>>>>>>
>>>>>>>> The red bar represents the SimpleMessenger receive, i.e. from reading
>>>>>>>> the message header until enqueuing the completely decoded message into
>>>>>>>> the SImpleMessenger dispatch queue.
>>>>>>>>
>>>>>>>> The green bar represents the time required for local processing, i.e.
>>>>>>>> dispatching the the OSD worker, writing to filesystem and journal,
>>>>>>>> send
>>>>>>>> out the replication operation to the replicating OSD. It right
>>>>>>>> end of the green bar is the time when locally everything has finished
>>>>>>>> and a commit could happen.
>>>>>>>>
>>>>>>>> The blue bar represents the time until the replicating OSD has sent a
>>>>>>>> commit
>>>>>>>> back to the primary OSD and the original write request can be
>>>>>>>> committed to
>>>>>>>> the client.
>>>>>>>>
>>>>>>>> The green bar is interrupted by a black bar: the left end represents
>>>>>>>> the time when the request has been enqueued on the OSD worker queue.
>>>>>>>> The
>>>>>>>> right end gives the time when the request is taken off the OSD worker
>>>>>>>> queue and actual OSD processing starts.
>>>>>>>>
>>>>>>>> The test was a simple sequential write to a rados block device.
>>>>>>>>
>>>>>>>> Receiption of the write requests at the OSD is also sequential in the
>>>>>>>> graphics: the bar to the bottom of the graphics shows an earlier write
>>>>>>>> request.
>>>>>>>>
>>>>>>>> Note that the dispatching of a later request in all cases relates to
>>>>>>>> the
>>>>>>>> enqueue time at the OSD worker queue of the previous write request:
>>>>>>>> the
>>>>>>>> left
>>>>>>>> end of a black bar relates nicely to the beginning of a green bar
>>>>>>>> above
>>>>>>>> it.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>>>>>>>> ITXperts GmbH                       http://www.itxperts.de
>>>>>>>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>>>>>>>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>>>>>>>
>>>>>>>> Company details: http://www.itxperts.de/imprint.htm
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>                 
>>>>>> --
>>>>>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>>>>>> ITXperts GmbH                       http://www.itxperts.de
>>>>>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>>>>>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>>>>>
>>>>>> Company details: http://www.itxperts.de/imprint.htm
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>>>
>>>>>>             
>>>>>
>>>>>
>>>>>           
>>>> --
>>>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>>>> ITXperts GmbH                       http://www.itxperts.de
>>>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>>>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>>>
>>>> Company details: http://www.itxperts.de/imprint.htm
>>>>
>>>>
>>>>         
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>
>
>   


-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm

