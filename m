From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: why ShardedWQ in osd using smart pointer for PG?
Date: Tue, 10 Nov 2015 16:22:26 -0800
Message-ID: <CAJ4mKGZzdDZ-x14ZP4Xb0eosTNY9CKCC4YgdPbnEr2hes084JQ@mail.gmail.com>
References: <CANE=7sUynZ+uvM6sR_WjvUnbLxfwj6LQDMWwonCmi2nM21ZEuQ@mail.gmail.com>
	<CAJ4mKGYH+v7HO8EK9xrCyEr+LtnMQQr4a22eHK7zKkW+78iBQw@mail.gmail.com>
	<CANE=7sUWjvs4P4FjeFtqDJis8p4GX8D9GpzT5OdjAovy94nwBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33781 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbbKKAW2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 19:22:28 -0500
Received: by wmec201 with SMTP id c201so159335126wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 16:22:26 -0800 (PST)
In-Reply-To: <CANE=7sUWjvs4P4FjeFtqDJis8p4GX8D9GpzT5OdjAovy94nwBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The xlist has means of efficiently removing entries from a list. I
think you'll find those in the path where we start tearing down a PG,
and membership on this list is a bit different from membership in the
ShardedThreadPool. It's all about the particulars of each design, and
I don't have that in my head =E2=80=94 you'd need to examine it.
-Greg

On Tue, Nov 10, 2015 at 4:20 PM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@g=
mail.com> wrote:
> I wonder if we want to keep the PG from going out of scope at an
> inopportune time, why snap_trim_queue and scrub_queue declared as
> xlist<PG*> instead of xlist<PGRef>?
>
> 2015-11-11 2:28 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> On Tue, Nov 10, 2015 at 7:19 AM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcx=
z@gmail.com> wrote:
>>> hi, all:
>>>
>>>      op_wq is declared as ShardedThreadPool::ShardedWQ < pair <PGRe=
f,
>>> OpRequestRef> > &op_wq. I do not know why we should use PGRef in th=
is?
>>>
>>>      Because the overhead of the smart pointer is not small. Maybe =
the
>>> raw point PG* is also OK?
>>>
>>>      If op_wq is changed to ShardedThreadPool::ShardedWQ < pair <PG=
*,
>>> OpRequestRef> > &op_wq (using raw point)
>>>
>>>      the latency for PrioritizedQueue:;enqueue decrease from 3.38us=
 -> 1.89us
>>>
>>>      the latency for PrioritizedQueue:;dequeue decrease from 3.44us=
 -> 1.65us
>>>
>>>      Is this make sense to you?
>>
>> In general we use PGRefs rather than PG pointers. I think we actuall=
y
>> rely on the references here to keep the PG from going out of scope a=
t
>> an inopportune time, but if it halves the cost of queuing actions it
>> might be worth the effort of avoiding that.
>> -Greg
>
>
>
> --
> Regards,
> xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
