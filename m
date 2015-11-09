From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Cannot start osd due to permission of journal raw device
Date: Mon, 9 Nov 2015 05:56:15 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC0364BCB6@shsmsx102.ccr.corp.intel.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC03641C3C@shsmsx102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1511060232160.5830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46178 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbbKIF4q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 00:56:46 -0500
In-Reply-To: <alpine.DEB.2.00.1511060232160.5830@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is no such rules (only 70-persistent-net.rules) in my /etc/udev/ruled.d/

Could you point me which part of the code create the rules file? Is that ceph-disk?

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Friday, November 6, 2015 6:33 PM
> To: Chen, Xiaoxi
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Cannot start osd due to permission of journal raw device
> 
> On Fri, 6 Nov 2015, Chen, Xiaoxi wrote:
> > Hi,
> >     I tried  infernalis (version 9.1.0
> (3be81ae6cf17fcf689cd6f187c4615249fea4f61)) but failed due to permission
> of journal ,  the OSD  was upgraded from hammer(also true for newly
> created OSD).
> >   I am using raw device as journal, this is because the default privilege of
> raw block is root:disk. Changing the journal owner to ceph:ceph solve the
> issue. Seems we can either:
> >   1. add ceph to "disk" group and run ceph-osd with --setuser ceph --
> setgroup disk?
> >   2. Require user to set the ownership of journal device to ceph:ceph is they
> want to use raw as journal?  Maybe we can done this in ceph-disk.
> >
> >    Personally I would prefer the second one , what do you think?
> 
> The udev rules should be setting the jouranl device ownership to ceph:ceph.
> IIRC there was a race in ceph-disk that could prevent this from happening in
> some cases but that is now fixed.  Can you try the infernalis branch?
> 
> sage
