From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd recovery extremely slow with current master
Date: Tue, 4 Dec 2012 14:27:30 -0800
Message-ID: <CAPYLRzj3SQJx-0sMbaVKGCxK_dYb8eu-exZdFGuq=-QXd0xM5A@mail.gmail.com>
References: <50A2AE92.1010205@profihost.ag>
	<CAPYLRzgqPZWZAMjJD_WrCx8m+HB6i1LKeLLNRZHmbgLnTJ6W+Q@mail.gmail.com>
	<50AF3F09.8020902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:47934 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2LDW1a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 17:27:30 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so8936250ieb.39
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 14:27:30 -0800 (PST)
In-Reply-To: <50AF3F09.8020902@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, I checked with Sam and you probably want to increase the "osd
max backfill" option to make it go faster in the future =97 this option
limits the number of PGs an OSD will be sending or receiving a
backfill for. The default is currently set to 5, and should probably
be much higher.
-Greg

On Fri, Nov 23, 2012 at 1:16 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> It is with current next from today right now.
>
> It just prints this line:
> 2012-11-23 10:15:29.927754 mon.0 [INF] pgmap v89614: 7632 pgs: 5956
> active+clean, 446 active+remapped+wait_backfill, 540
> active+degraded+wait_backfill, 690 active+degraded+remapped+wait_back=
fill; 0
> bytes data, 2827 MB used, 4461 GB / 4464 GB avail; 1/3 degraded (33.3=
33%)
>
> And there is no I/O or CPU load on any machine. And it tooks hours to
> recover with 0 bytes data (deleted all images before trying this agai=
n).
>
> Greets,
> Stefan
>
> Am 20.11.2012 00:21, schrieb Gregory Farnum:
>
>> Which version was this on? There was some fairly significant work to
>> recovery done to introduce a reservation scheme and some other stuff
>> that might need some different defaults.
>> -Greg
>>
>> On Tue, Nov 13, 2012 at 12:33 PM, Stefan Priebe <s.priebe@profihost.=
ag>
>> wrote:
>>>
>>> Hi list,
>>>
>>> osd recovery seems to be really slow with current master.
>>>
>>> I see only 1-8 active+recovering out of 1200. Even there's no load =
on
>>> ceph
>>> cluster.
>>>
>>> Greets,
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
