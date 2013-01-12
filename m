From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Striped images and cluster misbehavior
Date: Sat, 12 Jan 2013 14:02:39 +0300
Message-ID: <CABYiri_bbKx8g6sRpF-stG+SoT+S7u4xLiik+mPCU_c-x+r=Tw@mail.gmail.com>
References: <CABYiri-uqJ3sJt-pnV24EG60T6PGL7K+QvhSwE-=OnEG1R6W_A@mail.gmail.com>
 <CABYiri_5ww+RBdXM0CVEU9+WcHveXdQEJ6ymcp_-K9hgO_o=QQ@mail.gmail.com>
 <CABYiri96WTFLy9usyy_3LNzUxSWC7pBrhUgit2gp5bCziw7pkQ@mail.gmail.com>
 <CA+4uBUYfvhZcApiOOebQ360q-JWsAdfWshOFLQXKu7aqFe+0-g@mail.gmail.com> <CABYiri8_B=YbcoYBo+R5J8b6r5-go1_QTzAMd7bqO8CW-fDU3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:53505 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab3ALLDB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jan 2013 06:03:01 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so2645732oag.3
        for <ceph-devel@vger.kernel.org>; Sat, 12 Jan 2013 03:03:00 -0800 (PST)
In-Reply-To: <CABYiri8_B=YbcoYBo+R5J8b6r5-go1_QTzAMd7bqO8CW-fDU3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

After digging a lot, I have found that IB cards and switch may went to
``bad'' state after host` load spike, so I have limited all
potentially cpu-hungry processes via cg. That`s has no effect at all,
spikes happens almost at same time when osds on the corresponding host
went down as ``wrongly marked'' for a couple of seconds. By doing
manual observations, I have ensured that osds went crazy first, eating
all cores with 100% SY(mean. scheduler or fs issues), then card
lacking time for its interrupts start dropping the packets and so on.

This can be reproduced only on heavy workload on the fast cluster,
slow one with simular software versions will crawl but do not produce
such locks. Those locks may went away and may hang for a while, tens
of minutes, I do not sure of what it depends. Both nodes with logs
pointed above contains one monitor and one osd, but locks do happen on
two-osd nodes as well. Ceph instances does not share block devices in
my setup(except two-osd nodes using same SSD for a journal, but since
it is reproducible on mon-osd pair with completely separated storage
that`s seems not to be an exact cause). For meantime, I may suggest
for myself to move out from XFS and see if locks remain. The issue
started in the latest 3.6 series and 0.55+ and remains in the 3.7.1
and 0.56.1. Should I move to ext4 immediately or try 3.8-rc with
couple of XFS fixes first?

http://xdel.ru/downloads/ceph-log/osd-lockup-1-14-25-12.875107.log.gz
http://xdel.ru/downloads/ceph-log/osd-lockup-2-14-33-16.741603.log.gz

Timestamps in filenames added for easier lookup, osdmap have marked
osds as down after couple of beats after those marks.


On Mon, Dec 31, 2012 at 1:16 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Sun, Dec 30, 2012 at 10:56 PM, Samuel Just <sam.just@inktank.com> wrote:
>> Sorry for the delay.  A quick look at the log doesn't show anything
>> obvious... Can you elaborate on how you caused the hang?
>> -Sam
>>
>
> I am sorry for all this noise, the issue almost for sure has been
> triggered by some bug in the Infiniband switch firmware because
> per-port reset was able to solve ``wrong mark'' problem - at least, it
> haven`t showed up yet for a week. The problem took almost two days
> until resolution - all possible connectivity tests displayed no
> overtimes or drops which can cause wrong marks. Finally, I have
> started playing with TCP settings and found that ipv4.tcp_low_latency
> raising possibility of ``wrong mark'' event several times when enabled
> - so area of all possible causes quickly collapsed to the media-only
> problem and I fixed problem soon.
>
>> On Wed, Dec 19, 2012 at 3:53 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>> Please take a look at the log below, this is slightly different bug -
>>> both osd processes on the node was stuck eating all available cpu
>>> until I killed them. This can be reproduced by doing parallel export
>>> of different from same client IP using both ``rbd export'' or API
>>> calls - after a couple of wrong ``downs'' osd.19 and osd.27 finally
>>> stuck. What is more interesting, 10.5.0.33 holds most hungry set of
>>> virtual machines, eating constantly four of twenty-four HT cores, and
>>> this node fails almost always, Underlying fs is an XFS, ceph version
>>> gf9d090e. With high possibility my previous reports are about side
>>> effects of this problem.
>>>
>>> http://xdel.ru/downloads/ceph-log/osd-19_and_27_stuck.log.gz
>>>
>>> and timings for the monmap, logs are from different hosts, so they may
>>> have a time shift of tens of milliseconds:
>>>
>>> http://xdel.ru/downloads/ceph-log/timings-crash-osd_19_and_27.txt
>>>
>>> Thanks!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
