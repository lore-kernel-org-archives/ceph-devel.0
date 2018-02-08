From: Sage Weil <sage@newdream.net>
Subject: Re: Translating raw capacity to real data capacity in statfs
Date: Thu, 8 Feb 2018 19:06:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802081903170.15996@piezo.novalocal>
References: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com> <CAAM7YA=41Zx2PT=_Rc2UY61NSUZUEp_cgP3abLuHFBioPMu-fg@mail.gmail.com> <alpine.DEB.2.11.1802081309540.15996@piezo.novalocal> <CE91B764-C317-4585-AFB3-F10EF7979FF1@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-261011653-1518116775=:15996"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:55104 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBHTGQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 14:06:16 -0500
In-Reply-To: <CE91B764-C317-4585-AFB3-F10EF7979FF1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Chengguang Xu <cgxu519@icloud.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-261011653-1518116775=:15996
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 8 Feb 2018, Douglas Fuller wrote:
> > On Feb 8, 2018, at 8:11 AM, Sage Weil <sage@newdream.net> wrote:
> > 
> > On Thu, 8 Feb 2018, Yan, Zheng wrote:
> >> On Thu, Feb 8, 2018 at 10:47 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> >>> Hi Cepher,
> >>> 
> >>> Current statfs(2) in ceph kernel client provides raw capacity information of total/used/avail,
> >>> but in the point of view of filesystem I think we actually more willing to see real data capacity instead of raw.
> >>> 
> >>> So I have a suggestion to translate raw capacity to real data capacity, it can be simply implemented by
> >>> taking advantage of num.object_copies, the result may be not very accurate but still having reference significance.
> >>> 
> >> 
> >> It's not that simple when there are multiple data pools.
> > 
> > I seem to remember someone (Doug or Jeff?) working on a patch that would 
> > adjust the statfs result for a given directory based on the data pool and 
> > the usual "max avail" style calculation that 'ceph df' uses per pool 
> > (which is based on replication/ec multiplier and most-full osd)…?
> 
> I did that in: https://github.com/ceph/ceph/pull/16378 
> <https://github.com/ceph/ceph/pull/16378> . This only works for the case 
> where the filesystem uses a single data pool. In other cases, it falls 
> back to the old behavior.

FWIW, statfs(2) takes a path and fstatfs(2) takes an fd, so at least the 
user-facing API should be able to handle it.  And in the kernel the statfs 
call super_operations takes a dentry.  So it should be possible to do 
this?

sage

--8323329-261011653-1518116775=:15996--
