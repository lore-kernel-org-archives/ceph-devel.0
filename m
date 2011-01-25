From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: log messages about inconsistent data
Date: Tue, 25 Jan 2011 11:15:48 -0800
Message-ID: <4D3F2164.2020605@hq.newdream.net>
References: <AANLkTin=qOdFjTWz8sMQ3hmUvwyrnmEd3_zo6LPbaK3r@mail.gmail.com>	<4D3DC794.5090604@hq.newdream.net>	<AANLkTi=y0KcoerXLdfoeaHan8C5FVopuQYZp8hVg6o=Z@mail.gmail.com> <AANLkTi=ZCjMTU-2DnZJFsbfsH3JGJ5Z3LzUY9Ct_uEi2@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51268 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab1AYTRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 14:17:11 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7070BC063
	for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 11:17:11 -0800 (PST)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6DE05C062
	for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 11:17:11 -0800 (PST)
In-Reply-To: <AANLkTi=ZCjMTU-2DnZJFsbfsH3JGJ5Z3LzUY9Ct_uEi2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  Could you post the output of 'ceph pg dump -o -' ?
-Sam

On 01/25/2011 01:00 AM, Ravi Pinjala wrote:
> A follow-up question to this: After repairing those PGs, my cluster
> seems to have come to rest in this state.
>
> 2011-01-25 00:26:58.447007    pg v130979: 270 pgs: 8 active, 262
> active+clean; 822 GB data, 1762 GB used, 1265 GB / 3036 GB avail;
> 25/556114 degraded (0.004%)
>
> I don't know whether or not it's in a functional state, since I'm
> having MDS issues [1], so I can't actually mount it and poke around.
> Still, should I be worried that those 8 PGs aren't being marked
> 'clean'?
>
> [1] http://tracker.newdream.net/issues/733
>
> On Mon, Jan 24, 2011 at 7:45 PM, Ravi Pinjala<pstatic@gmail.com>  wrote:
>> That seems to be working. Thanks!
>>
>> --Ravi
>>
>> On Mon, Jan 24, 2011 at 10:40 AM, Samuel Just<samuelj@hq.newdream.net>  wrote:
>>>   ceph pg repair<pgid>  should cause the osd to repair the
>>> inconsistency in most cases.  You can get the pgid by grepping
>>> ceph pg dump for the inconsistent pg.
>>> -Sam
>>>
>>> On 01/23/2011 11:18 PM, Ravi Pinjala wrote:
>>>> Do I need to be worried about this?
>>>>
>>>> 2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.316993 osd1
>>>> 192.168.1.11:6801/9447 45 : [ERR] 1.1 scrub osd0 missing
>>>> 10000017737.00000000/head
>>>> 2011-01-23 23:12:06.328866   log 2011-01-23 23:12:05.317429 osd1
>>>> 192.168.1.11:6801/9447 46 : [ERR] 1.1 scrub stat mismatch, got 7/136
>>>> objects, 0/0 clones, 12356/8682277 bytes, 17/8550 kb.
>>>> 2011-01-23 23:12:08.230768    pg v129643: 270 pgs: 262 active+clean, 8
>>>> active+clean+inconsistent; 877 GB data, 1707 GB used, 1320 GB / 3036
>>>> GB avail
>>>>
>>>> I would expect ceph to fix the inconsistent PGs at this point, but it
>>>> just continues background scrubbing. Does inconsistent data get
>>>> cleaned up automatically from other replicas, or is there something
>>>> that I need to fix manually here?
>>>>
>>>> --Ravi
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

