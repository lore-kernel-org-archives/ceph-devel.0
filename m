From: Sage Weil <sage@newdream.net>
Subject: RE: chooseleaf may cause some unnecessary pg migrations
Date: Sun, 18 Oct 2015 19:17:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510181912160.16833@cobra.newdream.net>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.00.1510130940400.6589@cobra.newdream.net> <FF8D83DAE5DF57468726B79904321E06047273@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.00.1510140714580.6589@cobra.newdream.net>
 <FF8D83DAE5DF57468726B79904321E06047677@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.00.1510150715020.16833@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC03632F6C@shsmsx102.ccr.corp.intel.com> <FF8D83DAE5DF57468726B79904321E06047977@H3CMLB12-EX.srv.huawei-3com.com>
 <6F3FA899187F0043BA1827A69DA2F7CC0363300C@shsmsx102.ccr.corp.intel.com> <FF8D83DAE5DF57468726B79904321E060479C3@H3CMLB12-EX.srv.huawei-3com.com> <6F3FA899187F0043BA1827A69DA2F7CC03633AAB@shsmsx102.ccr.corp.intel.com>
 <FF8D83DAE5DF57468726B79904321E06047D8A@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45803 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbJSCRo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 22:17:44 -0400
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06047D8A@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 19 Oct 2015, Xusangdi wrote:
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
> > Chen, Xiaoxi
> > Sent: Monday, October 19, 2015 9:11 AM
> > To: xusangdi 11976 (RD)
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: chooseleaf may cause some unnecessary pg migrations
> >
> > Sorry but not following...
> >
> > > then shut down one or more osds (please don't touch the crushmap, just stop the osd service or kill
> > its process).
> >
> > In this case, OSD is only down but not out, but will be marked out after 300s.
> >
> > So in what case your patch is helping?
> >
> >       If you said your patch helps on "down and out" , then my experiment is exactly the case,
> >
> 
> I am afraid it is probably not. Could you tell me how did you simulate 
> the osd "down and out" situation using crushtool? If it was done by 
> arguments such as '--remove-item' or 'reweight-item', it modified the 
> crushmap and is not what I'm aiming for. 

There is a --weight argument (noted in usage near --test, which is the 
only piece that uses it).  The crush map is not modified--only the weight 
vector that is passed in when a mapping is calculated (which is the 
equivalent of the in/out state in Ceph's OSDMap).  This should let you 
simulate this case.

When I'm debugging/understanding these issues I usually change the dprintk 
#define at the top of crush/mapper.c and use crushtool or osdmaptool to 
calculate a single mapping, comparing the log before and after a 
particular change.

sage
