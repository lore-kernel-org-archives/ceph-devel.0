From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: automatic repair of inconsistent pg?
Date: Tue, 01 Jan 2013 21:12:37 +0100
Message-ID: <50E34335.3030902@profihost.ag>
References: <50D908FA.7010907@profihost.ag> <alpine.DEB.2.00.1212242252040.32156@cobra.newdream.net> <CA+4uBUbDVC0pKEfGfHmEuaVvZsoHWyZrxoE+vrFSddgWLGeELQ@mail.gmail.com> <50E095C4.4090502@profihost.ag> <CA+4uBUb81Gv-4vjKTd8UvV7V8Ep7PG3roug30+0e9hHksTc35g@mail.gmail.com> <50E17E0B.805@profihost.ag> <CA+4uBUbXoDrYg_JHGq1=ioO6KyrZ1RUaAUWUoSNNkJAAT6Ki6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49457 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3AAUMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jan 2013 15:12:36 -0500
In-Reply-To: <CA+4uBUbXoDrYg_JHGq1=ioO6KyrZ1RUaAUWUoSNNkJAAT6Ki6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

OK thanks! Will change that.
Am 31.12.2012 20:21, schrieb Samuel Just:
> The ceph-osd relies on fs barriers for correctness.  You will want to
> remove the nobarrier option to prevent future corruption.
> -Sam
>
> On Mon, Dec 31, 2012 at 3:59 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Am 31.12.2012 02:10, schrieb Samuel Just:
>>
>>> Are you using xfs?  If so, what mount options?
>>
>>
>> Yes,
>> noatime,nodiratime,nobarrier,logbufs=8,logbsize=256k
>>
>> Stefan
>>
>>>
>>> On Dec 30, 2012 1:28 PM, "Stefan Priebe" <s.priebe@profihost.ag
>>> <mailto:s.priebe@profihost.ag>> wrote:
>>>   >
>>>   > Am 30.12.2012 19:17, schrieb Samuel Just:
>>>   >>
>>>   >> This is somewhat more likely to have been a bug in the replication
>>> logic
>>>   >> (there were a few fixed between 0.53 and 0.55).  Had there been any
>>>   >> recent osd failures?
>>>   >
>>>   > Yes i was stressing CEPH with failures (power, link, disk, ...).
>>>   >
>>>   > Stefan
>>>   >
>>>   >> On Dec 24, 2012 10:55 PM, "Sage Weil" <sage@inktank.com
>>> <mailto:sage@inktank.com>
>>>   >> <mailto:sage@inktank.com <mailto:sage@inktank.com>>> wrote:
>>>   >>
>>>   >>     On Tue, 25 Dec 2012, Stefan Priebe wrote:
>>>   >>      > Hello list,
>>>   >>      >
>>>   >>      > today i got the following ceph status output:
>>>   >>      > 2012-12-25 02:57:00.632945 mon.0 [INF] pgmap v1394388: 7632
>>> pgs: 7631
>>>   >>      > active+clean, 1 active+clean+inconsistent; 151 GB data, 307 GB
>>>   >>     used, 5028 GB /
>>>   >>      > 5336 GB avail
>>>   >>      >
>>>   >>      >
>>>   >>      > i then grepped the inconsistent pg by:
>>>   >>      > # ceph pg dump - | grep inconsistent
>>>   >>      > 3.ccf   10      0       0       0       41037824        155930
>>>   >>       155930
>>>   >>      > active+clean+inconsistent       2012-12-25 01:51:35.318459
>>> 6243'2107
>>>   >>      > 6190'9847       [14,42] [14,42] 6243'2107       2012-12-25
>>>   >>     01:51:35.318436
>>>   >>      > 6007'2074       2012-12-23 01:51:24.386366
>>>   >>      >
>>>   >>      > and initiated a repair:
>>>   >>      > #  ceph pg repair 3.ccf
>>>   >>      > instructing pg 3.ccf on osd.14 to repair
>>>   >>      >
>>>   >>      > The log output then was:
>>>   >>      > 2012-12-25 02:56:59.056382 osd.14 [ERR] 3.ccf osd.42 missing
>>>   >>      > 1c602ccf/rbd_data.4904d6b8b4567.0000000000000b84/head//3
>>>   >>      > 2012-12-25 02:56:59.056385 osd.14 [ERR] 3.ccf osd.42 missing
>>>   >>      > ceb55ccf/rbd_data.48cc66b8b4567.0000000000001538/head//3
>>>   >>      > 2012-12-25 02:56:59.097989 osd.14 [ERR] 3.ccf osd.42 missing
>>>   >>      > dba6bccf/rbd_data.4797d6b8b4567.00000000000015ad/head//3
>>>   >>      > 2012-12-25 02:56:59.097991 osd.14 [ERR] 3.ccf osd.42 missing
>>>   >>      > a4deccf/rbd_data.45f956b8b4567.00000000000003d5/head//3
>>>   >>      > 2012-12-25 02:56:59.098022 osd.14 [ERR] 3.ccf repair 4 missing,
>>> 0
>>>   >>     inconsistent
>>>   >>      > objects
>>>   >>      > 2012-12-25 02:56:59.098046 osd.14 [ERR] 3.ccf repair 4 errors,
>>> 4
>>>   >>     fixed
>>>   >>      >
>>>   >>      > Why doesn't ceph repair this automatically? Ho could this
>>> happen
>>>   >>     at all?
>>>   >>
>>>   >>     We just made some fixes to repair in next (it was broken sometime
>>>   >>     between
>>>   >>     ~0.53 and 0.55).  The latest next should repair it.  In general
>>> we don't
>>>   >>     repair automatically lest we inadvertantly propagate bad data or
>>> paper
>>>   >>     over a bug.
>>>   >>
>>>   >>     As for the original source of the missing objects... I'm not sure.
>>>   >>       There
>>>   >>     were some fixed races related to backfill that could lead to an
>>> object
>>>   >>     being missed, but Sam would know more about how likely that
>>> actually is.
>>>   >>
>>>   >>     sage
>>>   >>     --
>>>   >>     To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel" in
>>>   >>     the body of a message to majordomo@vger.kernel.org
>>> <mailto:majordomo@vger.kernel.org>
>>>   >>     <mailto:majordomo@vger.kernel.org
>>>
>>> <mailto:majordomo@vger.kernel.org>>
>>>   >>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>   >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
