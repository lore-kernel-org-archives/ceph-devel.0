From: Mike <mike.almateia@gmail.com>
Subject: Re: Cyclic performance drop
Date: Sat, 15 Oct 2016 16:22:10 +0300
Message-ID: <1476537730.1723.8.camel@gmail.com>
References: <716f53fa-0fce-a7b2-1d2a-f4bd10ea9133@gmail.com>
         <alpine.DEB.2.11.1610141848010.23131@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35892 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753578AbcJONWb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Oct 2016 09:22:31 -0400
Received: by mail-lf0-f44.google.com with SMTP id b75so216368079lfg.3
        for <ceph-devel@vger.kernel.org>; Sat, 15 Oct 2016 06:22:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610141848010.23131@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Пт, 2016-10-14 at 18:53 +0000, Sage Weil wrote:
> On Fri, 14 Oct 2016, Mike wrote:
> > Hello.
> > On the latest Jewel release I see a cyclic performance drop on read operations.
> > Performance significantly drops every 4-5 seconds from ~70k IOPS to ~20k IOPS.
> > 
> > It looks like this (some fields were truncated to fit in line length):
> > <CUT>
> > ...
> > 19:46:10.432125 4096 pgs: 4096 active+clean; 67378 MB data, 82433 kB/s rd, 20608
> op/s
> > 19:46:11.453338 4096 pgs: 4096 active+clean; 67378 MB data, 104 MB/s rd, 26857 op/s
> > 19:46:12.486138 4096 pgs: 4096 active+clean; 67378 MB data, 276 MB/s rd, 70879 op/s
> > 19:46:13.517175 4096 pgs: 4096 active+clean; 67378 MB data, 235 MB/s rd, 60375 op/s
> > 19:46:15.530826 4096 pgs: 4096 active+clean; 67378 MB data, 81768 kB/s rd, 20442
> op/s
> > 19:46:16.561929 4096 pgs: 4096 active+clean; 67378 MB data, 132 MB/s rd, 33811 op/s
> > 19:46:17.582495 4096 pgs: 4096 active+clean; 67378 MB data, 277 MB/s rd, 71027 op/s
> > 19:46:18.614087 4096 pgs: 4096 active+clean; 67378 MB data, 200 MB/s rd, 51365 op/s
> > 19:46:20.643567 4096 pgs: 4096 active+clean; 67378 MB data, 97849 kB/s rd, 24462
> op/s
> > 19:46:21.664988 4096 pgs: 4096 active+clean; 67378 MB data, 129 MB/s rd, 33108 op/s
> > 19:46:22.693243 4096 pgs: 4096 active+clean; 67378 MB data, 270 MB/s rd, 69269 op/s
> > 19:46:23.692111 4096 pgs: 4096 active+clean; 67378 MB data, 199 MB/s rd, 51186 op/s
> > 19:46:25.725054 4096 pgs: 4096 active+clean; 67378 MB data, 84951 kB/s rd, 21238
> op/s
> > 19:46:26.746227 4096 pgs: 4096 active+clean; 67378 MB data, 132 MB/s rd, 33833 op/s
> > 19:46:27.779780 4096 pgs: 4096 active+clean; 67378 MB data, 293 MB/s rd, 75189 op/s
> > 19:46:28.775288 4096 pgs: 4096 active+clean; 67378 MB data, 204 MB/s rd, 52249 op/s
> > 19:46:30.795561 4096 pgs: 4096 active+clean; 67378 MB data, 75260 kB/s rd, 18815
> op/s
> > 19:46:31.818544 4096 pgs: 4096 active+clean; 67378 MB data, 133 MB/s rd, 34243 op/s
> > 19:46:32.851392 4096 pgs: 4096 active+clean; 67378 MB data, 295 MB/s rd, 75755 op/s
> > 19:46:33.843960 4096 pgs: 4096 active+clean; 67378 MB data, 205 MB/s rd, 52649 op/s
> > 19:46:34.861416 4096 pgs: 4096 active+clean; 67378 MB data, 69177 kB/s rd, 17294
> op/s
> > 19:46:35.872386 4096 pgs: 4096 active+clean; 67378 MB data, 85299 kB/s rd, 21324
> op/s
> > 19:46:36.898020 4096 pgs: 4096 active+clean; 67378 MB data, 155 MB/s rd, 39896 op/s
> > 19:46:37.934147 4096 pgs: 4096 active+clean; 67378 MB data, 321 MB/s rd, 82209 op/s
> > 19:46:39.966386 4096 pgs: 4096 active+clean; 67378 MB data, 163 MB/s rd, 41735 op/s
> > 19:46:40.973110 4096 pgs: 4096 active+clean; 67378 MB data, 55481 kB/s rd, 13870
> op/s
> > ...
> > <CUT>
> 
> You should probably confirm this result by looking at the raw perfcounter 
> stats coming out of the OSD admin socket interface.  (Operators usually 
> wire this up to graphite or similar monitoring tools.)
> 
> If this is a smallish cluster, a simpler check would be
> 
>  ceph daemonperf osd.0
> 
> and see if the stats reported by a single OSD show the same behavior.
> 
> The numbers reported by the monitor are not very accurate.  They average 
> over a short period of time and can be sensitive to the timing of stat 
> reports from OSDs (we're effectively taking the differential of a very 
> choppy stair-step function and hoping for the best).
> 
> sage
> 
> 

Thanks Sage! You are right when use "ceph daemon perf ..." I didn't see the issue
described above.


-- 
Mike, run.
