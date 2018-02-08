From: Sage Weil <sage@newdream.net>
Subject: Re: Translating raw capacity to real data capacity in statfs
Date: Thu, 8 Feb 2018 13:11:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802081309540.15996@piezo.novalocal>
References: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com> <CAAM7YA=41Zx2PT=_Rc2UY61NSUZUEp_cgP3abLuHFBioPMu-fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:37882 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHNL1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 08:11:27 -0500
In-Reply-To: <CAAM7YA=41Zx2PT=_Rc2UY61NSUZUEp_cgP3abLuHFBioPMu-fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Chengguang Xu <cgxu519@icloud.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

On Thu, 8 Feb 2018, Yan, Zheng wrote:
> On Thu, Feb 8, 2018 at 10:47 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> > Hi Cepher,
> >
> > Current statfs(2) in ceph kernel client provides raw capacity information of total/used/avail,
> > but in the point of view of filesystem I think we actually more willing to see real data capacity instead of raw.
> >
> > So I have a suggestion to translate raw capacity to real data capacity, it can be simply implemented by
> > taking advantage of num.object_copies, the result may be not very accurate but still having reference significance.
> >
> 
> It's not that simple when there are multiple data pools.

I seem to remember someone (Doug or Jeff?) working on a patch that would 
adjust the statfs result for a given directory based on the data pool and 
the usual "max avail" style calculation that 'ceph df' uses per pool 
(which is based on replication/ec multiplier and most-full osd)...?

sage
