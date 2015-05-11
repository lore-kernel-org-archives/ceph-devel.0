From: Sage Weil <sage@newdream.net>
Subject: RE: libcrush.so
Date: Sun, 10 May 2015 19:34:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505101932560.28239@cobra.newdream.net>
References: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B313F2B@SSIEXCH-MB3.ssi.samsung.com> <06681238D8946F44A60AA400760A1CBF01F632C2@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51780 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbEKCeF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 22:34:05 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01F632C2@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Cohen, David E" <david.e.cohen@intel.com>, "Yu, Zhidong" <zhidong.yu@intel.com>

On Sat, 9 May 2015, Zhou, Yuan wrote:
> Hi James,
> 
> This happens usually when the storage platform and applications are in segmented networks. For example, in a cluster with multiple RGW instances, if we could know the which RGW instance is the closest to primary copy, then we can do more efficient local read/write through some particular deployment. 
> There's one feature in Openstack Swift [1] which is able to provide the location of objects inside a cluster.

I think the place for this is librados--and I believe there is already a 
method to do this (I think... I know there is in libcephfs as the hadoop 
bindings use it).  That way you don't have to deal with the annoying 
details of getting an up to date map and so on.

sage


> 
> Thanks, -yuan
> 
> [1] https://github.com/openstack/swift/blob/master/swift/common/middleware/list_endpoints.py
> 
> -----Original Message-----
> From: James (Fei) Liu-SSI [mailto:james.liu@ssi.samsung.com] 
> Sent: Saturday, May 9, 2015 1:40 AM
> To: Zhou, Yuan; Ceph Development
> Cc: Cohen, David E; Yu, Zhidong
> Subject: RE: libcrush.so
> 
> Hi Yuan,
>    Very interesting. Would be possible to know why application needs to access the cursh map directly instead of accessing through ceph tool?
> 
>   Regards,
>   James
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Zhou, Yuan
> Sent: Thursday, May 07, 2015 6:29 PM
> To: Ceph Development
> Cc: Cohen, David E; Yu, Zhidong
> Subject: libcrush.so
> 
> Ceph use crush algorithm to provide the mapping of objects to OSD servers. This is great for clients so they could talk to with these OSDs directly. However there are some scenarios where the application needs to access the crush map, for load-balancing as an example. 
> 
> Currently Ceph doesn't provides any API to render the layout. If your application needs to access the crush map you'll going to rely on the command 'ceph osd map pool_name obj_name'. With this libcrush.so we could let the application to choose which nodes to access. The other advantage is we could provide some other bindings(python, go) based on this also.
> 
> >From the git log we find libcrush was there before but removed out since Argonaut. Can anyone kindly share us the background of this change?
> 
> 
> Thanks, -yuan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
