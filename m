From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 15:43:30 -0700
Message-ID: <CAF3hT9CLd5W-sHk3os_CeoR_HDY2C0Vm5nZVsRHLLhCCSFh7Bw@mail.gmail.com>
References: <CAORUGqBe-xdQ1bwifcN3kQEZ=0a72tkHsFU9TqXHvvED7DpS=g@mail.gmail.com>
	<2039347197.5499.1319668862176.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61093 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1JZWna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 18:43:30 -0400
Received: by iaby12 with SMTP id y12so2210388iab.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 15:43:30 -0700 (PDT)
In-Reply-To: <2039347197.5499.1319668862176.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Oct 26, 2011 at 3:41 PM, Noah Watkins <jayhawk@soe.ucsc.edu> wrote:
> ----- Original Message -----
>> From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
>>
>> From my experience with Hadoop, the CLASSPATH approach seems
>> definitely good enough, and gives us more flexibility.
>
> I think that maybe the only thing that wouldn't work in this case
> is integration into the Hadoop test harness. Other than that it
> should work. Maybe there is a way to integrate?

My main concern with this approach as a long-term solution (after
we've solved our own teething issues) is the branching mess they have
going on right now, and the pain of maintaining multiple APIs. But if
everybody uses the Cloudera distro anyway, maybe this isn't actually a
big deal?
