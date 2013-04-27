From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: massive 4k random read drop with next branch
Date: Sat, 27 Apr 2013 15:45:13 -0500
Message-ID: <517C38D9.6060808@inktank.com>
References: <517C316D.6030205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62460 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab3D0UpS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 16:45:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so6130113iej.16
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 13:45:16 -0700 (PDT)
In-Reply-To: <517C316D.6030205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/27/2013 03:13 PM, Stefan Priebe wrote:
> Hello list,
>
> today i was testing next branch against bobtail using a testcluster. I
> upgraded this bobtail one to next branch.
>
> I used QEMU 1.4.1 with librdb (for next branch i applied josh writeback
> patch). My Testsystem had 5 Hosts with one OSD each and set replication
> to 2.
>
> All values where done with 8 jobs in parallel using fio in Qemu Guest.
>
> bobtail:
> rand 4k:  write: io=164316KB, bw=1783KB/s, iops=445, runt= 92136msec
> rand 4k:  read : io=1117MB, bw=12710KB/s, iops=3177, runt= 90028msec
> seq 4m:  write: io=8588MB, bw=97233KB/s, iops=23, runt= 90444msec
> seq 4m:  read : io=83616MB, bw=951227KB/s, iops=232, runt= 90013msec
>
> next branch:
>    write: io=177236KB, bw=1963KB/s, iops=490, runt= 90284msec
>    read : io=223628KB, bw=2408KB/s, iops=601, runt= 92875msec
>    write: io=25936MB, bw=294443KB/s, iops=71, runt= 90199msec
>    read : io=69856MB, bw=794585KB/s, iops=193, runt= 90025msec

Was everything else the same between the tests?  That does seem unusual. 
  If it's easy for you to switch between bobtail and next, could you try 
some 4k rados bench read tests to see if it's also happening there?

>
> Greets,
> Stefan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

