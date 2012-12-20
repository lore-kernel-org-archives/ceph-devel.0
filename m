From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Thu, 20 Dec 2012 15:59:39 -0600
Message-ID: <50D38A4B.9070307@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <50B7C788.6040404@inktank.com> <50B93FCA.2060801@inktank.com> <CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com> <50BC2DE6.6050307@inktank.com> <50C65AE5.2050704@inktank.com> <CAPud5_7OPrpg1Q_UTw2PskG+o=+H82xgJHacmGT+bVOZkf466A@mail.gmail.com> <50C774FD.9030107@inktank.com> <50C78D09.5050403@inktank.com> <CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail.com> <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com> <50CB57E2.10703@inktank.com> <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csid7_LV3RKYbiTdB+09g@mail.gmail.com> <50CB69E5.7080001@inktank.com> <CAPud5_5PuF0kMzaWVb84_zB6XyZ4QexUsmqoCTdp8vsFNDE=LA@mail.gmail.com> <50D0951F.6050106@inktank.com> <CAPud5_5DnafqOZ1y3NHXY9Ryj_
 wSeKz+mvWbXqWFD1yjgbNgtw@mail.gmail.com> <50D230E4.6060805@inktank.com> <50D242C3.3070409@inktank.com> <CAPud5_6b=8m7jrrG-6TAyXjGj8dL1yrsNaeUTTp8NC7HpNMeeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39525 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2LTV7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 16:59:43 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so5328554iea.2
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 13:59:42 -0800 (PST)
In-Reply-To: <CAPud5_6b=8m7jrrG-6TAyXjGj8dL1yrsNaeUTTp8NC7HpNMeeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/20/2012 11:48 AM, Nick Bartos wrote:
> Unfortunately, we still have a hang:
> 
> https://gist.github.com/4347052/download

The saga continues, and each time we get a little more
information.  Please try branch: "wip-nick-newerest"

Thank you.

					-Alex


> On Wed, Dec 19, 2012 at 2:42 PM, Alex Elder <elder@inktank.com> wrote:
>> On 12/19/2012 03:25 PM, Alex Elder wrote:
>>> On 12/18/2012 12:05 PM, Nick Bartos wrote:
>>>> I've added the output of "ps -ef" in addition to triggering a trace
>>>> when a hang is detected.  Not much is generally running at that point,
>>>> but you can have a look:
>>>>
>>>> https://gist.github.com/raw/4330223/2f131ee312ee43cb3d8c307a9bf2f454a7edfe57/rbd-hang-1355851498.txt
>>>
>>> This helped a lot.  I updated the bug with a little more info.
>>>
>>>     http://tracker.newdream.net/issues/3519
>>>
>>> I also think I have now found something that could explain what you
>>> are seeing, and am developing a fix.  I'll provide you an update
>>> as soon as I have tested what I come up with, almost certainly
>>> this afternoon.
>>
>> Nick, I have a new branch for you to try with a new fix in place.
>> As you might have predicted, it's named "wip-nick-newest".
>>
>> Please give it a try to see if it resolved the hang you've
>> been seeing and let me know how it goes.  If it continues
>> to hang, please provide the logs as you have before, it's
>> been very helpful.
>>
>> Thanks a lot.
>>
>>                                         -Alex
>>>
>>>                                       -Alex
>>>
>>>> Is it possible that there is some sort of deadlock going on?  We are
>>>> doing the rbd maps (and subsequent filesystem mounts) on the same
>>>> systems which are running the ceph-osd and ceph-mon processes.  To get
>>>> around the 'sync' deadlock problem, we are using a patch from Sage
>>>> which ignores system wide sync's on filesystems mounted with the
>>>> 'mand' option (and we mount the underlying osd filesystems with
>>>> 'mand').  However I am wondering if there is potential for other types
>>>> of deadlocks in this environment.
>>>>
>>>> Also, we recently saw an rbd hang in a much older version, running
>>>> kernel 3.5.3 with only the sync hack patch, along side ceph 0.48.1.
>>>> It's possible that this issue was around for some time, just the
>>>> recent patches made it happen more often (and thus more reproducible)
>>>> for us.
>>>>
>>>>
>>>> On Tue, Dec 18, 2012 at 8:09 AM, Alex Elder <elder@inktank.com> wrote:
>>>>> On 12/17/2012 11:12 AM, Nick Bartos wrote:
>>>>>> Here's a log with the rbd debugging enabled:
>>>>>>
>>>>>> https://gist.github.com/raw/4319962/d9690fd92c169198efc5eecabf275ef1808929d2/rbd-hang-test-1355763470.log
>>>>>>
>>>>>> On Fri, Dec 14, 2012 at 10:03 AM, Alex Elder <elder@inktank.com> wrote:
>>>>>>> On 12/14/2012 10:53 AM, Nick Bartos wrote:
>>>>>>>> Yes I was only enabling debugging for libceph.  I'm adding debugging
>>>>>>>> for rbd as well.  I'll do a repro later today when a test cluster
>>>>>>>> opens up.
>>>>>>>
>>>>>>> Excellent, thank you.   -Alex
>>>>>
>>>>> I looked through these debugging messages.  Looking only at the
>>>>> rbd debugging, what I see seems to indicate that rbd is idle at
>>>>> the point the "hang" seems to start.  This suggests that the hang
>>>>> is not due to rbd itself, but rather whatever it is that might
>>>>> be responsible for using the rbd image once it has been mapped.
>>>>>
>>>>> Is that possible?  I don't know what process you have that is
>>>>> mapping the rbd image, and what is supposed to be the next thing
>>>>> it does.  (I realize this may not make a lot of sense, given
>>>>> a patch in rdb seems to have caused the hang to begin occurring.)
>>>>>
>>>>> Also note that the debugging information available (i.e., the
>>>>> lines in the code that can output debugging information) may
>>>>> well be incomplete.  So if you don't find anything it may be
>>>>> necessary to provide you with another update which might include
>>>>> more debugging.
>>>>>
>>>>> Anyway, could you provide a little more context about what
>>>>> is going on sort of *around* rbd when activity seems to stop?
>>>>>
>>>>> Thanks a lot.
>>>>>
>>>>>                                         -Alex
>>>
>>

