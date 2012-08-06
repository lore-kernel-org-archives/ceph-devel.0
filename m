From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash of almost full ceph
Date: Mon, 6 Aug 2012 09:25:14 -0700
Message-ID: <CAPYLRzgTCu-_mvKBQNaHrmXqmBVib0cvcGKPmaL-yWGZ=uioww@mail.gmail.com>
References: <501CFB7C.1040601@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34366 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756546Ab2HFQZP convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Aug 2012 12:25:15 -0400
Received: by lagy9 with SMTP id y9so841812lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 09:25:14 -0700 (PDT)
In-Reply-To: <501CFB7C.1040601@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Aug 4, 2012 at 3:37 AM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> Hello,
>
> Yesterday finally I have managed to screw up my installation of ceph!=
 :)
>
> My ceph was at 80% capacity. I have rebooted one of OSDs remotely and
> managed to screw up with fstab. Host failed to come up and while I wa=
s
> driving from home to my office ceph took recovery action. But it mean=
t that
> it has filled up another OSDs completely and it has failed. Ceph cont=
inued
> to recover and killed other OSDs in the same fashion. Not quite good.
> Attempt to restart OSDs was in vain: they were unable to test for xat=
trs
> because file system was full and only growing file system allowed the=
m to
> restart.
>
> Now this leads me to a question/proposal: is there a feature which al=
lows
> ceph to halt recovery process if any of live OSDs exceeding say 95% p=
ercent
> capacity? It is quite distinct from what is considered full or near f=
ull OSD
> as any writes when OSD is near full or full coming from clients and
> inability to write leads to client lock up. But halting recovery shou=
ld
> allow clients to continue even so ceph is in degraded state. It does =
not
> make sense to me to allow ceph go from degraded state to crashed stat=
e when
> no client needs it.

There is not yet any such feature, no =97=A0dealing with full systems i=
s
notoriously hard and we haven't come up with a great solution yet. One
thing you can do is experiment with the "mon_osd_min_in_ratio"
parameter, which prevents the monitors from marking out more than a
certain percentage of the OSD cluster (and without something being
marked out, no data will be moved around). If you don't want the
cluster to automatically mark any OSDs out, you can also set the
"mon_osd_down_out_interval" to zero.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
