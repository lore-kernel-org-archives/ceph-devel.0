From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply
 is received
Date: Wed, 3 Jul 2013 15:26:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307031526030.3375@cobra.newdream.net>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com> <51D12FA7.1090605@intel.com> <alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net> <alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
 <CAAM7YAkrSWGiGL8NAj81jsvQuMeUABSRMpScFXU6x3JEyjHSGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38854 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3GCW0J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 18:26:09 -0400
In-Reply-To: <CAAM7YAkrSWGiGL8NAj81jsvQuMeUABSRMpScFXU6x3JEyjHSGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Alex Elder <alex.elder@linaro.org>, "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 4 Jul 2013, Yan, Zheng wrote:
> On Thu, Jul 4, 2013 at 5:57 AM, Sage Weil <sage@inktank.com> wrote:
> > Hi Yan-
> >
> > On Mon, 1 Jul 2013, Sage Weil wrote:
> >> On Mon, 1 Jul 2013, Yan, Zheng wrote:
> >> > ping
> >> >
> >> > I think this patch should goes into 3.11 or fix the issue by other means
> >>
> >> Applied this to the testing branch, thanks.  Let me know if there are any
> >> others I missed!
> >
> > This broke rbd, which was using the unsafe callback. I pushed a patch to
> > simplify that (testing-next^); care to take a look?
> >
> 
> the patch looks good. looks like issue #5146 actually does not exist.
> Alex, could you take a look.

Yeah, i'll close.

sage
