From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: why ShardedWQ in osd using smart pointer for PG?
Date: Wed, 11 Nov 2015 08:20:09 +0800
Message-ID: <CANE=7sUWjvs4P4FjeFtqDJis8p4GX8D9GpzT5OdjAovy94nwBw@mail.gmail.com>
References: <CANE=7sUynZ+uvM6sR_WjvUnbLxfwj6LQDMWwonCmi2nM21ZEuQ@mail.gmail.com>
	<CAJ4mKGYH+v7HO8EK9xrCyEr+LtnMQQr4a22eHK7zKkW+78iBQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35800 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbKKAUJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 19:20:09 -0500
Received: by obbnk6 with SMTP id nk6so10877947obb.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 16:20:09 -0800 (PST)
In-Reply-To: <CAJ4mKGYH+v7HO8EK9xrCyEr+LtnMQQr4a22eHK7zKkW+78iBQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I wonder if we want to keep the PG from going out of scope at an
inopportune time, why snap_trim_queue and scrub_queue declared as
xlist<PG*> instead of xlist<PGRef>?

2015-11-11 2:28 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Tue, Nov 10, 2015 at 7:19 AM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz=
@gmail.com> wrote:
>> hi, all:
>>
>>      op_wq is declared as ShardedThreadPool::ShardedWQ < pair <PGRef=
,
>> OpRequestRef> > &op_wq. I do not know why we should use PGRef in thi=
s?
>>
>>      Because the overhead of the smart pointer is not small. Maybe t=
he
>> raw point PG* is also OK?
>>
>>      If op_wq is changed to ShardedThreadPool::ShardedWQ < pair <PG*=
,
>> OpRequestRef> > &op_wq (using raw point)
>>
>>      the latency for PrioritizedQueue:;enqueue decrease from 3.38us =
-> 1.89us
>>
>>      the latency for PrioritizedQueue:;dequeue decrease from 3.44us =
-> 1.65us
>>
>>      Is this make sense to you?
>
> In general we use PGRefs rather than PG pointers. I think we actually
> rely on the references here to keep the PG from going out of scope at
> an inopportune time, but if it halves the cost of queuing actions it
> might be worth the effort of avoiding that.
> -Greg



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
