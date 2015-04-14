From: Sage Weil <sweil@redhat.com>
Subject: Re: [Issue]Ceph cluster hang due to network partition
Date: Tue, 14 Apr 2015 08:18:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504140816011.4469@cobra.newdream.net>
References: <CAM9_UU9SwjQ1FxYHcT2wrXwi1oCH5xuwRJQ9D-rwHwATTusTZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618AbbDNPS6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Apr 2015 11:18:58 -0400
In-Reply-To: <CAM9_UU9SwjQ1FxYHcT2wrXwi1oCH5xuwRJQ9D-rwHwATTusTZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 14 Apr 2015, Ketor D wrote:
> Hi Sage,
>       We recently meet a network partition problem, cause our ceph
> cluster can not service rbd service.
>        We are running 0.67.5 on our customer cluster. And the network
> partition is 3 osd can connect mon, but can not connect with all other
> osds.
>        Then many PGs fall in peering status, and rbd I/O is hang.
> 
>         Before we operate the cluster , I set nout flag and stop the 3
> OSDs. After operating the 3 OSDs memory and OS bootup, the network is
> partition. The 3 OSDs start, then many PGs went to peering.
> I stoped the 3 OSDs process, but the PGs fall in peering.

One possibility is that those PGs were all on the partitioned side; in 
that case you would have seen stale+peering+... states.  
Another possibility is that there was not sufficient PG [meta]data on 
the other side of the partition and the PGs got stuck in down+... or 
incomplete+... states.

Or, there was another partition somewhere or cofusion such that there were 
OSDs that were unreachable but still in the 'up' state.

sage


>         After network partition is fixed, all PG get active+clean, all is OK.
> 
>         I can't explain this, because I think the OSD can judge if the
> other OSD is alive, and I can see 3OSD is marked down in 'ceph osd
> tree'.
>         Why did these PGs fall in peering?
> 
> Thanks!
> Ketor
> 
> 
