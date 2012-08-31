From: Sage Weil <sage@inktank.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 09:05:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net>
References: <50409BDC.5010006@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47193 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab2HaQFt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:05:49 -0400
In-Reply-To: <50409BDC.5010006@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 31 Aug 2012, Xiaopong Tran wrote:
> Hi,
> 
> Ceph storage on each disk in the cluster is very unbalanced. On each
> node, the data seems to go to one or two disks, while other disks
> are almost empty.
> 
> I can't find anything wrong from the crush map, it's just the
> default for now. Attached is the crush map.

This is usually a problem with the pg_num for the pool you are using.  Can 
you include the output from 'ceph osd dump | grep ^pool'?  By default, 
pools get 8 pgs, which will distribute poorly.

sage


> 
> Here is the current situation on node s100001:
> 
> Filesystem                                              Size  Used Avail Use%
> Mounted on
> /dev/sdb1                                               932G  4.3G  927G   1%
> /disk1
> /dev/sdc1                                               932G  4.3G  927G   1%
> /disk2
> /dev/sdd1                                               932G  4.3G  927G   1%
> /disk3
> /dev/sde1                                               932G  4.3G  927G   1%
> /disk4
> /dev/sdf1                                               932G  4.3G  927G   1%
> /disk5
> /dev/sdg1                                               932G  4.3G  927G   1%
> /disk6
> /dev/sdh1                                               932G  4.3G  927G   1%
> /disk7
> /dev/sdi1                                               932G  4.3G  927G   1%
> /disk8
> /dev/sdj1                                               932G  4.3G  927G   1%
> /disk9
> /dev/sdk1                                               932G  445G  487G  48%
> /disk10
> 
> Here, we can see that all data seem to go to one osd only, while others
> are almost empty.
> 
> And here's the situation on node s200001:
> 
> Filesystem                                              Size  Used Avail Use%
> Mounted on
> /dev/sdb1                                               932G  443G  489G  48%
> /disk1
> /dev/sdc1                                               932G  4.3G  927G   1%
> /disk2
> /dev/sdd1                                               932G  4.3G  927G   1%
> /disk3
> /dev/sde1                                               932G  4.3G  927G   1%
> /disk4
> /dev/sdf1                                               932G  4.3G  927G   1%
> /disk5
> /dev/sdg1                                               932G  4.3G  927G   1%
> /disk6
> /dev/sdh1                                               932G  4.3G  927G   1%
> /disk7
> /dev/sdi1                                               932G  4.3G  927G   1%
> /disk8
> /dev/sdj1                                               932G  449G  483G  49%
> /disk9
> /dev/sdk1                                               932G  4.3G  927G   1%
> /disk10
> 
> The situation is a bit better, but not much, the data are stored on two
> disks mainly.
> 
> Here is a better situation, on node s100002:
> 
> Filesystem                                              Size  Used Avail Use%
> Mounted on
> /dev/sdb1                                               1.9T  453G  1.4T  25%
> /disk1
> /dev/sdc1                                               1.9T  4.3G  1.9T   1%
> /disk2
> /dev/sdd1                                               1.9T  4.4G  1.9T   1%
> /disk3
> /dev/sde1                                               1.9T  4.3G  1.9T   1%
> /disk4
> /dev/sdf1                                               1.9T  457G  1.4T  25%
> /disk5
> /dev/sdg1                                               1.9T  443G  1.4T  24%
> /disk6
> /dev/sdh1                                               1.9T  4.4G  1.9T   1%
> /disk7
> /dev/sdi1                                               1.9T  4.4G  1.9T   1%
> /disk8
> /dev/sdj1                                               1.9T  427G  1.5T  23%
> /disk9
> /dev/sdk1                                               1.9T  4.4G  1.9T   1%
> /disk10
> 
> It's better than the other two, but still not what I expected. I
> expected the data to be spread out according to the weight of each
> osd, as defined in the crush map. Or at least, as close to that
> as possible. It might be just some obviously stupid config error,
> but I don't know. This can't be normal, can it?
> 
> Thanks for any hint.
> 
> Xiaopong
> 
