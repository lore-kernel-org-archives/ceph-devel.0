From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: can't read/write after inserting new crushmap
Date: Thu, 09 Feb 2012 11:29:50 -0800
Message-ID: <4F341EAE.1000905@dreamhost.com>
References: <CABAwU-ZZ2Nz20i0SjWT2_1USJRToTELqSU++5pz4MOcH1g7EGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42279 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab2BIT3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2012 14:29:50 -0500
In-Reply-To: <CABAwU-ZZ2Nz20i0SjWT2_1USJRToTELqSU++5pz4MOcH1g7EGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 02/08/2012 01:58 AM, huang jun wrote:
> hi,all
>      we test with 8 OSDs and group into 2 racks, each has 4 OSDs.
>      write the crushmap file and export it into ceph cluster.(crushmap
> file attached)
>      all PGs distribute allow the crush rule.
>
>     then one group(4OSDs) powered off  and "ceph -w "shows:
>           2012-02-08 17:03:57.518285    pg v633: 1584 pgs: 1092 active,
> 490 active+clean+degraded, 2 degraded+peering; 3992 MB data, 6665 MB
> used, 4642 GB / 4657 GB      avail; 349/2040 degraded (17.108%)
>           2012-02-08 17:03:57.520698   mds e4: 1/1/1 up {0=0=up:active}
>           2012-02-08 17:03:57.520729   osd e86: 8 osds: 4 up, 4 in
>           2012-02-08 17:03:57.521199   log 2012-02-08 15:26:21.761073
> mon0 192.168.0.116:6789/0 27 : [INF] osd7 out (down for 304.299392)
>           2012-02-08 17:03:57.521249   mon e1: 1 mons at {0=192.168.0.116:6789/0}
>     2 PGs' state is "degraded+peering", and it seems never goto normal
> "active+clean " state.(we use ceph v0.35,maybe it matters)
>
>   check the pg dump output:
>          2.1p3   0       0       0       0       0       0       0
>   0       active  0'0     4'120   [3]     [3,0]   0'0
>          2.0p2   0       0       0       0       0       0       0
>   0       active  0'0     3'119   [2]     [2,0]   0'0
>          0.1p1   0       0       0       0       0       0       0
>   0       active  0'0     3'103   [1]     [1,0]   0'0
>          0.0p0   0       0       0       0       0       0       0
>   0       active  0'0     2'126   [0]     [0,1]   0'0
>          1.1p0   0       0       0       0       0       0       0
>   0       active  0'0     2'123   [0]     [0,2]   0'0
>          1.0p1   0       0       0       0       0       0       0
>   0       active  0'0     3'102   [1]     [1,0]   0'0
>          2.0p3   0       0       0       0       0       0       0
>   0       active  0'0     4'122   [3]     [3,0]   0'0
>          2.1p2   0       0       0       0       0       0       0
>   0       active  0'0     3'122   [2]     [2,0]   0'0
>          0.0p1   0       0       0       0       0       0       0
>   0       active  0'0     3'116   [1]     [1,0]   0'0
>          0.1p0   0       0       0       0       0       0       0
>   0       active  0'0     2'115   [0]     [0,2]   0'0
>          1.0p0   0       0       0       0       0       0       0
>   0       active  0'0     2'115   [0]     [0,2]   0'0
>          1.1p1   0       0       0       0       0       0       0
>   0       active  0'0     3'116   [1]     [1,0]   0'0
>          2.1p1   0       0       0       0       0       0       0
>   0       active  0'0     3'121   [1]     [1,0]   0'0
>          2.0p0   0       0       0       0       0       0       0
>   0       active  0'0     2'121   [0]     [0,2]   0'0
>          0.1p3   0       0       0       0       0       0       0
>   0       active  0'0     4'115   [3]     [3,0]   0'0
>          0.0p2   0       0       0       0       0       0       0
>   0       active  0'0     3'117   [2]     [2,0]   0'0
>          1.1p2   0       0       0       0       0       0       0
>   0       active  0'0     3'119   [2]     [2,0]   0'0
>          1.0p3   0       0       0       0       0       0       0
>   0       active  0'0     4'115   [3]     [3,0]   0'0
>           2.0p1   0       0       0       0       0       0       0
>    0       active  0'0     3'116   [1]     [1,0]   0'0
>           2.1p0   0       0       0       0       0       0       0
>    0       active  0'0     2'124   [0]     [0,1]   0'0
>      let's take pg 2.1p3 for example,
>      why  the up and acting set are not equals?
>      Does  data migration  occurs in OSD cluster on this condition?
> that is what we are most concerned about.
>      if so, the data distribution didn't follow the rules setted by crushmap.

With many down nodes, the distribution can become bad due to the way the 
current crush implementation works (bug #2047). It will only retry 
within the local subtree when it encounters a down device, so it can end 
up getting more down nodes and giving up. A workaround for this is to 
remove the host level from your hierarchy and put the devices directly 
in the racks.

You can test the distrubtion with crushtool to see what happens with 
different osds down. For example, to test with osds 0 and 1 down:

ceph getcrushmap -o /tmp/crushmap
crushtool -i /tmp/crushmap --test --weight 0 0 --weight 1 0
