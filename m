From: Sage Weil <sage@newdream.net>
Subject: RE: Cannot start osd due to permission of journal raw device
Date: Mon, 9 Nov 2015 07:50:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511090749360.27153@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC03641C3C@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1511060232160.5830@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC0364BCB6@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1511090517490.27153@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC0364BEDF@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48438 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbKIPum (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 10:50:42 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0364BEDF@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 9 Nov 2015, Chen, Xiaoxi wrote:
> Hmm.... I didn't use ceph-disk but partitioned & format by myself and 
> call ceph-osd --mkfs directly, that should be the reason why udev rules 
> doesn't make effect?

Yeah... the udev rule is based on the GPT partition label.  For example,

https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules#L4-L5

sage



> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Monday, November 9, 2015 9:18 PM
> > To: Chen, Xiaoxi
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: Cannot start osd due to permission of journal raw device
> > 
> > On Mon, 9 Nov 2015, Chen, Xiaoxi wrote:
> > > There is no such rules (only 70-persistent-net.rules) in my
> > > /etc/udev/ruled.d/
> > >
> > > Could you point me which part of the code create the rules file? Is
> > > that ceph-disk?
> > 
> > https://github.com/ceph/ceph/blob/master/udev/95-ceph-osd.rules
> > 
> > The package should install it in /lib/udev/rules.d or similar...
> > 
> > sage
> > 
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > Sent: Friday, November 6, 2015 6:33 PM
> > > > To: Chen, Xiaoxi
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: Cannot start osd due to permission of journal raw
> > > > device
> > > >
> > > > On Fri, 6 Nov 2015, Chen, Xiaoxi wrote:
> > > > > Hi,
> > > > >     I tried  infernalis (version 9.1.0
> > > > (3be81ae6cf17fcf689cd6f187c4615249fea4f61)) but failed due to
> > > > permission of journal ,  the OSD  was upgraded from hammer(also true
> > > > for newly created OSD).
> > > > >   I am using raw device as journal, this is because the default
> > > > > privilege of
> > > > raw block is root:disk. Changing the journal owner to ceph:ceph
> > > > solve the issue. Seems we can either:
> > > > >   1. add ceph to "disk" group and run ceph-osd with --setuser ceph
> > > > > --
> > > > setgroup disk?
> > > > >   2. Require user to set the ownership of journal device to
> > > > > ceph:ceph is they
> > > > want to use raw as journal?  Maybe we can done this in ceph-disk.
> > > > >
> > > > >    Personally I would prefer the second one , what do you think?
> > > >
> > > > The udev rules should be setting the jouranl device ownership to
> > ceph:ceph.
> > > > IIRC there was a race in ceph-disk that could prevent this from
> > > > happening in some cases but that is now fixed.  Can you try the infernalis
> > branch?
> > > >
> > > > sage
> > >
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
