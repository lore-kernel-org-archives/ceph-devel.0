From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: osd recovery extremely slow with current master
Date: Fri, 23 Nov 2012 10:16:57 +0100
Message-ID: <50AF3F09.8020902@profihost.ag>
References: <50A2AE92.1010205@profihost.ag> <CAPYLRzgqPZWZAMjJD_WrCx8m+HB6i1LKeLLNRZHmbgLnTJ6W+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39994 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2KWJRI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 04:17:08 -0500
In-Reply-To: <CAPYLRzgqPZWZAMjJD_WrCx8m+HB6i1LKeLLNRZHmbgLnTJ6W+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It is with current next from today right now.

It just prints this line:
2012-11-23 10:15:29.927754 mon.0 [INF] pgmap v89614: 7632 pgs: 5956 
active+clean, 446 active+remapped+wait_backfill, 540 
active+degraded+wait_backfill, 690 
active+degraded+remapped+wait_backfill; 0 bytes data, 2827 MB used, 4461 
GB / 4464 GB avail; 1/3 degraded (33.333%)

And there is no I/O or CPU load on any machine. And it tooks hours to 
recover with 0 bytes data (deleted all images before trying this again).

Greets,
Stefan

Am 20.11.2012 00:21, schrieb Gregory Farnum:
> Which version was this on? There was some fairly significant work to
> recovery done to introduce a reservation scheme and some other stuff
> that might need some different defaults.
> -Greg
>
> On Tue, Nov 13, 2012 at 12:33 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Hi list,
>>
>> osd recovery seems to be really slow with current master.
>>
>> I see only 1-8 active+recovering out of 1200. Even there's no load on ceph
>> cluster.
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
