From: Sage Weil <sage@newdream.net>
Subject: Re: PATCH: ceph.spec.in
Date: Fri, 2 Jul 2010 15:22:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007021522420.23331@cobra.newdream.net>
References: <i0k73i$g5f$2@dough.gmane.org> <Pine.LNX.4.64.1007020802470.17984@cobra.newdream.net>
 <4C2E412E.1010408@chaschperli.ch> <i0lfkk$uhq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44975 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab0GBWVZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jul 2010 18:21:25 -0400
In-Reply-To: <i0lfkk$uhq$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, 2 Jul 2010, Thomas Mueller wrote:
> Am Fri, 02 Jul 2010 21:42:38 +0200 schrieb Thomas Mueller:
> 
> > On 02.07.2010 17:04, Sage Weil wrote:
> >> Applied this, sans the unpackaged files part.. those are for debugging
> >> and testing, and don't need to be installed.  (That probably means
> >> 'make install' should ignore them...)
> > 
> > as long as they are installed with "make install" (at least with mock)
> > the build of the packages fail with the message that there are
> > unpackaged files and no rpm's are produced.
> > 
> > 
> > - Thomas
> 
> PS: maybe only build these binarys with debug enabled?

Done.  Let me know if I missed anything?
sage
