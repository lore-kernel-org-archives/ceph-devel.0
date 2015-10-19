From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: chooseleaf may cause some unnecessary pg migrations
Date: Mon, 19 Oct 2015 07:33:32 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC03633C1B@shsmsx102.ccr.corp.intel.com>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com>
 <alpine.DEB.2.00.1510130940400.6589@cobra.newdream.net>
 <FF8D83DAE5DF57468726B79904321E06047273@H3CMLB12-EX.srv.huawei-3com.com>
 <alpine.DEB.2.00.1510140714580.6589@cobra.newdream.net>
 <FF8D83DAE5DF57468726B79904321E06047677@H3CMLB12-EX.srv.huawei-3com.com>
 <alpine.DEB.2.00.1510150715020.16833@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC03632F6C@shsmsx102.ccr.corp.intel.com>
 <FF8D83DAE5DF57468726B79904321E06047977@H3CMLB12-EX.srv.huawei-3com.com>
 <6F3FA899187F0043BA1827A69DA2F7CC0363300C@shsmsx102.ccr.corp.intel.com>
 <FF8D83DAE5DF57468726B79904321E060479C3@H3CMLB12-EX.srv.huawei-3com.com>
 <6F3FA899187F0043BA1827A69DA2F7CC03633AAB@shsmsx102.ccr.corp.intel.com>
 <FF8D83DAE5DF57468726B79904321E06047D8A@H3CMLB12-EX.srv.huawei-3com.com>
 <alpine.DEB.2.00.1510181912160.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41135 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbJSHdy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 03:33:54 -0400
In-Reply-To: <alpine.DEB.2.00.1510181912160.16833@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Xusangdi <xu.sangdi@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks sage.

Retesting by using --test --weight ${rand} 0 , still in 40 OSDs, 10 per host case:

New code average on 204.31 while old code average on 202.31


> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Monday, October 19, 2015 10:18 AM
> To: Xusangdi
> Cc: Chen, Xiaoxi; ceph-devel@vger.kernel.org
> Subject: RE: chooseleaf may cause some unnecessary pg migrations
> 
> On Mon, 19 Oct 2015, Xusangdi wrote:
> >
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org
> > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Chen, Xiaoxi
> > > Sent: Monday, October 19, 2015 9:11 AM
> > > To: xusangdi 11976 (RD)
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: RE: chooseleaf may cause some unnecessary pg migrations
> > >
> > > Sorry but not following...
> > >
> > > > then shut down one or more osds (please don't touch the crushmap,
> > > > just stop the osd service or kill
> > > its process).
> > >
> > > In this case, OSD is only down but not out, but will be marked out after
> 300s.
> > >
> > > So in what case your patch is helping?
> > >
> > >       If you said your patch helps on "down and out" , then my
> > > experiment is exactly the case,
> > >
> >
> > I am afraid it is probably not. Could you tell me how did you simulate
> > the osd "down and out" situation using crushtool? If it was done by
> > arguments such as '--remove-item' or 'reweight-item', it modified the
> > crushmap and is not what I'm aiming for.
> 
> There is a --weight argument (noted in usage near --test, which is the only
> piece that uses it).  The crush map is not modified--only the weight vector
> that is passed in when a mapping is calculated (which is the equivalent of the
> in/out state in Ceph's OSDMap).  This should let you simulate this case.
> 
> When I'm debugging/understanding these issues I usually change the dprintk
> #define at the top of crush/mapper.c and use crushtool or osdmaptool to
> calculate a single mapping, comparing the log before and after a particular
> change.
> 
> sage
