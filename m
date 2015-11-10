From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: why ShardedWQ in osd using smart pointer for PG?
Date: Tue, 10 Nov 2015 10:28:15 -0800
Message-ID: <CAJ4mKGYH+v7HO8EK9xrCyEr+LtnMQQr4a22eHK7zKkW+78iBQw@mail.gmail.com>
References: <CANE=7sUynZ+uvM6sR_WjvUnbLxfwj6LQDMWwonCmi2nM21ZEuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33093 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbKJS2Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 13:28:16 -0500
Received: by wmec201 with SMTP id c201so147591722wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 10:28:15 -0800 (PST)
In-Reply-To: <CANE=7sUynZ+uvM6sR_WjvUnbLxfwj6LQDMWwonCmi2nM21ZEuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 10, 2015 at 7:19 AM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@g=
mail.com> wrote:
> hi, all:
>
>      op_wq is declared as ShardedThreadPool::ShardedWQ < pair <PGRef,
> OpRequestRef> > &op_wq. I do not know why we should use PGRef in this=
?
>
>      Because the overhead of the smart pointer is not small. Maybe th=
e
> raw point PG* is also OK?
>
>      If op_wq is changed to ShardedThreadPool::ShardedWQ < pair <PG*,
> OpRequestRef> > &op_wq (using raw point)
>
>      the latency for PrioritizedQueue:;enqueue decrease from 3.38us -=
> 1.89us
>
>      the latency for PrioritizedQueue:;dequeue decrease from 3.44us -=
> 1.65us
>
>      Is this make sense to you?

In general we use PGRefs rather than PG pointers. I think we actually
rely on the references here to keep the PG from going out of scope at
an inopportune time, but if it halves the cost of queuing actions it
might be worth the effort of avoiding that.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
