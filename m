From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: low performance of ceph, why ?
Date: Thu, 26 Jul 2012 10:40:25 -0500
Message-ID: <501164E9.7050401@inktank.com>
References: <loom.20120726T151236-360@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62696 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab2GZPkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 11:40:31 -0400
Received: by ghrr11 with SMTP id r11so2109789ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 08:40:31 -0700 (PDT)
In-Reply-To: <loom.20120726T151236-360@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hosfore <computer_masi@126.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 09:53 AM, Hosfore wrote:
> Now I configure a small cluster of ceph, with mon and mds on the same machine,
> two osds on another two machine, and I have configure the data and journal dir
> on two disks separately. But the test result of mdtest is so poor as below:
> ------------------------------------------------------------------------------
> fs90:/mnt/ceph # mdtest -d /mnt/ceph/tt3 -n 200 -i 2 -w 0
> -- started at 07/26/2012 22:37:08 --
>
> mdtest-1.8.3 was launched with 1 total task(s) on 1 nodes
> Command line used: mdtest -d /mnt/ceph/tt3 -n 200 -i 2 -w 0
> Path: /mnt/ceph
> FS: 1.8 TiB   Used FS: 5.8%   Inodes: 0.0 Mi   Used Inodes: 100.0%
>
> 1 tasks, 200 files/directories
>
> SUMMARY: (of 2 iterations)
>     Operation                  Max        Min       Mean    Std Dev
>     ---------                  ---        ---       ----    -------
>     Directory creation:   2218.451   1138.848   1678.650    539.802
>     Directory stat    : 870187.552 840541.884 855364.718  14822.834
>     Directory removal :   2830.938   2828.647   2829.793      1.146
>     File creation     :   1987.224   1972.523   1979.873      7.350
>     File stat         : 854237.067 850771.602 852504.335   1732.732
>     File removal      :   2651.082   2164.132   2407.607    243.475
>     Tree creation     :   1680.410   1559.801   1620.105     60.305
>     Tree removal      :      1.011      0.578      0.794      0.216
>
> -- finished at 07/26/2012 22:37:11 --
> -----------------------------------------------------------------------------

Hi,

Thanks for taking the time to test this.  I haven't been able to really 
dig into metadata tests like mdtest yet, though it's on my list of 
things to do!  For now, my guess is that all of the overhead by having 
more layers of code, network, and general lack of optimizations with 
CephFS are probably holding things back.  This is something we will 
eventually be working on, but right now our focus is more on RadosGW and 
RBD.  You may want to look at:

http://ceph.newdream.net/papers/weil-ceph-osdi06.pdf

On page 10 there are some MDS performance numbers.  With a single MDS it 
looks like your numbers are roughly in-line with the makedirs and 
makefiles numbers Sage reported at the time.

Mark

-- 
Mark Nelson
Performance Engineer
Inktank
