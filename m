From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 10:32:34 +0200
Message-ID: <CAOLwVUkxo5pzvHmmr1PBW98wBWuVJW==Tk34wUMNedKxNQf+4Q@mail.gmail.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
 <503C2A86.8080503@inktank.com> <503C48A6.5060205@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60304 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2H1Ic6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 04:32:58 -0400
Received: by lbbgj3 with SMTP id gj3so3079090lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 01:32:55 -0700 (PDT)
In-Reply-To: <503C48A6.5060205@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

@Alexandre: I don't have all the machines anymore, I'll see what I can
do :). Only the commodity cluster remains

@Mark Nelson: 2) Which bench? The RADOS one?
3) Sorry the RAID controller doesn't support JBOD...
5) I still have the commodity cluster, I'll perform some little rados benchmarks

Cheers!

On Tue, Aug 28, 2012 at 6:27 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> +1 to that. I've been seeing 4-6 MB/s for 4K writes for 1 OSD with 1 SSD for
> journal and another for data [1]. Interestingly I did see some nice scaling
> with 4K random reads: 2-4 MB/s per thread for up to 8 threads (looked like
> it plateaued thereafter).
>
> Cheers
>
> Mark
>
> [1] FYI not on the box I posted about before - on a more modern pc with
> 6Bbit/s SATA.
>
>
> On 28/08/12 14:18, Mark Nelson wrote:
>>
>> 5) rados bench tests with smaller requests could be interesting on 15k
>> drives.  I typically see about 1-2MB/s per OSD for 4k requests with 7200rpm
>> SATA disks.
>
>
