From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Wed, 29 May 2013 17:10:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305291709590.16097@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net> <519F286B.2@intel.com> <alpine.DEB.2.00.1305271219350.1350@cobra.newdream.net> <51A41E75.8000801@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36127 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966530Ab3E3AKP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 20:10:15 -0400
In-Reply-To: <51A41E75.8000801@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

I merged in this whole branch this morning.  Yay!

Thanks, Yan!
sage


On Tue, 28 May 2013, Yan, Zheng wrote:

> On 05/28/2013 03:21 AM, Sage Weil wrote:
> > On Fri, 24 May 2013, Yan, Zheng wrote:
> >> On 05/24/2013 02:22 AM, Sage Weil wrote:
> >>> On Thu, 23 May 2013, Yan, Zheng wrote:
> >>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>>>
> >>>> Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
> >>>> the backtrace handling. Patch 29 introduces lookup-by-ino helper.
> >>>> Path 30 uses the lookup-by-ino helper to fix issue #4850.
> >>>>
> >>>> This patch series are also in:
> >>>>   git://github.com/ukernel/ceph.git wip-mds
> >>>
> >>> Awesome!  I pushed this to wip-mds in ceph.git for now.  Note that 
> >>> gitbuilders are picking up a failure due to the encoding changes.  For the 
> >>> types and messages that change, can you mark them in the 
> >>> ceph-object-corpus.git tree?  Look for the forward_incompat/ dirs and 
> >>> follow that example.
> >>>
> >> Could you be more specific. Change in patch 14 should only affect MExportDir
> >> and MExportCaps, object-corpus does not contain objects for these two messages.
> >> Patch 27 looks suspicious, does the incompatible change you mentioned cause the
> >> failure?
> > 
> > http://gitbuilder.sepia.ceph.com/gitbuilder-oneiric-amd64/log.cgi?log=f8499e07035fbff063b50b13ac295432884c7e27
> > 
> > is the one I saw, but there are likely others; run 'make check-local' to 
> > run the encoding checks.
> > 
> 
> It turned out to be a bug in path "mds: journal backtrace update in EMetaBlob::fullbit"
> I forgot to initialize 'state' when decoding old format.
> 
> Regards
> Yan, Zheng
> 
> 
