From: Sage Weil <sage@newdream.net>
Subject: RE: libcrush.so
Date: Mon, 11 May 2015 10:01:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505110958460.28239@cobra.newdream.net>
References: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B313F2B@SSIEXCH-MB3.ssi.samsung.com> <06681238D8946F44A60AA400760A1CBF01F632C2@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1505101932560.28239@cobra.newdream.net>
 <4C76A0D9F9998D47879EE649C8F7D7FFE1ACA9@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55912 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbEKRBP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:01:15 -0400
In-Reply-To: <4C76A0D9F9998D47879EE649C8F7D7FFE1ACA9@FMSMSX108.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Cohen, David E" <david.e.cohen@intel.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Yu, Zhidong" <zhidong.yu@intel.com>, "Zhou, Yuan" <yuan.zhou@intel.com>

On Mon, 11 May 2015, Cohen, David E wrote:
> The "ceph_get_osd_crush_location" method is made available via 
> libcephfs. In deployment scenarios that don't include CephFS it will be 
> ideal if this method is also available.  However, there is no equivalent 
> method available via librados. Instead, it looks like you have to use 
> the "rados_mon_command_target" to mimic the functionality of the command 
> line tools.

Yeah, okay.  Would adding those calls to librados address your use-case?

As Greg mentioned, putting together a separate libcrush.so is a bit of 
work because the useful bits that encode/decode maps and so forth pull in 
a bunch of generic Ceph code and there will be some annoying linking 
issues to sort out if running alongside other Ceph code (like librados).  
And even if we did all of that work, it'll push responsibility to the user 
to make sure they have the latest osdmap.  If the goal is to calculate 
mappings for a running cluster, adding to librados seems like the 
easiest path forward...

sage

> 
> /dave.
> 
> https://github.com/ceph/ceph/blob/master/debian/libcephfs-java.jlibs
> https://github.com/ceph/ceph/blob/master/src/include/cephfs/libcephfs.h
> https://github.com/ceph/ceph/blob/master/src/libcephfs.cc
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net] 
> Sent: Sunday, May 10, 2015 10:34 PM
> To: Zhou, Yuan
> Cc: James (Fei) Liu-SSI; Ceph Development; Cohen, David E; Yu, Zhidong
> Subject: RE: libcrush.so
> 
> On Sat, 9 May 2015, Zhou, Yuan wrote:
> > Hi James,
> > 
> > This happens usually when the storage platform and applications are in segmented networks. For example, in a cluster with multiple RGW instances, if we could know the which RGW instance is the closest to primary copy, then we can do more efficient local read/write through some particular deployment. 
> > There's one feature in Openstack Swift [1] which is able to provide the location of objects inside a cluster.
> 
> I think the place for this is librados--and I believe there is already a method to do this (I think... I know there is in libcephfs as the hadoop bindings use it).  That way you don't have to deal with the annoying details of getting an up to date map and so on.
> 
> sage
> 
> 
> > 
> > Thanks, -yuan
> > 
> > [1] 
> > https://github.com/openstack/swift/blob/master/swift/common/middleware
> > /list_endpoints.py
> > 
> > -----Original Message-----
> > From: James (Fei) Liu-SSI [mailto:james.liu@ssi.samsung.com]
> > Sent: Saturday, May 9, 2015 1:40 AM
> > To: Zhou, Yuan; Ceph Development
> > Cc: Cohen, David E; Yu, Zhidong
> > Subject: RE: libcrush.so
> > 
> > Hi Yuan,
> >    Very interesting. Would be possible to know why application needs to access the cursh map directly instead of accessing through ceph tool?
> > 
> >   Regards,
> >   James
> > 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org 
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Zhou, Yuan
> > Sent: Thursday, May 07, 2015 6:29 PM
> > To: Ceph Development
> > Cc: Cohen, David E; Yu, Zhidong
> > Subject: libcrush.so
> > 
> > Ceph use crush algorithm to provide the mapping of objects to OSD servers. This is great for clients so they could talk to with these OSDs directly. However there are some scenarios where the application needs to access the crush map, for load-balancing as an example. 
> > 
> > Currently Ceph doesn't provides any API to render the layout. If your application needs to access the crush map you'll going to rely on the command 'ceph osd map pool_name obj_name'. With this libcrush.so we could let the application to choose which nodes to access. The other advantage is we could provide some other bindings(python, go) based on this also.
> > 
> > >From the git log we find libcrush was there before but removed out since Argonaut. Can anyone kindly share us the background of this change?
> > 
> > 
> > Thanks, -yuan
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
