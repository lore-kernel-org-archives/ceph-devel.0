From: Sage Weil <sage@newdream.net>
Subject: RE: building boost statically
Date: Sun, 1 May 2016 11:14:56 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com> <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com> <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com> <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53897 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcEAPOt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 May 2016 11:14:49 -0400
In-Reply-To: <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 1 May 2016, Jesse Williamson wrote:
> On Sat, 30 Apr 2016, Allen Samuels wrote:
> 
> > Let's not wait.
> > 
> > As another option. If all we're looking for is "small_vector", then I looked
> > at taking the equivalent out of the Folly library a while ago. It looked
> > like it would be relatively easy to hack up the one header file to make it
> > standalone.
> 
> There's a utility in boost, "bcp", that might be useful:
> 
> http://www.boost.org/doc/libs/1_60_0/tools/bcp/doc/html/index.html

Given that this is the only piece we want immediately (that i know of), 
that there would be significant work to either pull boost inline as a 
submodule *or* to build and ship a proper package, let's go the bcp route 
for now.

Jesse, is this something you can tackle?

Thanks!
sage
