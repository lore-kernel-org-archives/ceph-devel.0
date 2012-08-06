From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash of almost full ceph
Date: Mon, 6 Aug 2012 09:53:59 -0700
Message-ID: <CAPYLRzgzZHuZQbCe6TY+hFJYn5MiC32QTdWSnxSNB=bR5r3CBA@mail.gmail.com>
References: <501CFB7C.1040601@bashkirtsev.com>
	<CAPYLRzgTCu-_mvKBQNaHrmXqmBVib0cvcGKPmaL-yWGZ=uioww@mail.gmail.com>
	<501FF332.3060005@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56261 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756495Ab2HFQyA convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Aug 2012 12:54:00 -0400
Received: by lagy9 with SMTP id y9so859080lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 09:53:59 -0700 (PDT)
In-Reply-To: <501FF332.3060005@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 6, 2012 at 9:39 AM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> On 07/08/12 01:55, Gregory Farnum wrote:
>>
>> There is not yet any such feature, no =97 dealing with full systems =
is
>> notoriously hard and we haven't come up with a great solution yet. O=
ne thing
>> you can do is experiment with the "mon_osd_min_in_ratio" parameter, =
which
>> prevents the monitors from marking out more than a certain percentag=
e of the
>> OSD cluster (and without something being marked out, no data will be=
 moved
>> around). If you don't want the cluster to automatically mark any OSD=
s out,
>> you can also set the "mon_osd_down_out_interval" to zero. -Greg
>
> But it is good idea to have such feature as fail safe device. Setting=
s you
> speak about may help a bit when cluster is almost full and there good=
 number
> of OSDs but hard refusal of ceph to run recovery if ANY live OSD is o=
ver
> certain limit is quite unambiguous. If recovery fails due to one OSD =
is at
> capacity then it should be handed over to admin to decide what to do:
> rebalance CRUSH, add new OSD, remove some objects. Certainly ceph sho=
uld not
> be able to fill up OSD with activity which is not required (but desir=
ed) by
> end clients.

Oh, I see what you're saying. Given how distributed Ceph is this is
actually harder than it sounds =97 we could get closer by refusing to
mark OSDs out whenever the full list is non-empty, but we could not
for instance do partial recovery and then stop once an OSD gets full.
In any case, I've made a bug (http://tracker.newdream.net/issues/2911)
since this isn't something I can hack together right now. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
