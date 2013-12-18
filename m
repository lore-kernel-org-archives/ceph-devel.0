From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Wed, 18 Dec 2013 09:09:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
References: <oriounafd8.fsf@livre.home> <CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com> <or38lq86ig.fsf@livre.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58724 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3LRRJj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 12:09:39 -0500
In-Reply-To: <or38lq86ig.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zheng.z.yan@intel.com>

On Wed, 18 Dec 2013, Alexandre Oliva wrote:
> On Dec 18, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:
> 
> > On Tue, Dec 17, 2013 at 7:25 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> >> # setfattr -n ceph.parent /cephfs/mount/path/name

Can we add an additional prefix indicating that this is a debug/developer 
kludge that is not intended to be supported in the long-term? 
ceph.dev.force_rewrite_backtrace or something?

sage

> 
> > This seems like a good solution for fixing cephfs that was created
> > before dumpling.
> 
> There's more to it than just that, actually.  Renaming an entire subtree
> won't update the parent attribute of files in there, so they will appear
> to be incorrect (*).  This patch introduces a mechanism that could be
> used to force them to be updated.
> 
> (*) I'm well aware that they contain enough information to find the
> updated information, so the redundant info in this attribute can be
> harmlessly out-of-date, but if someone plans to use the data for other
> purposes (like I sometimes do), it's useful to have them fully up to
> date.  I also move large trees around, which makes this issue visible.
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
