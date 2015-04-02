From: Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Thu, 2 Apr 2015 06:41:24 +0100
Message-ID: <20150402054124.GE20397@suse.de>
References: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
 <20150401230323.GD20397@suse.de>
 <CAOi1vP-u_sWF0uZpbYCN9qUp80tXQvmnJdOjWM3kpSR1JqSDMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39337 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbbDBFl3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Apr 2015 01:41:29 -0400
Content-Disposition: inline
In-Reply-To: <CAOi1vP-u_sWF0uZpbYCN9qUp80tXQvmnJdOjWM3kpSR1JqSDMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <michaelc@cs.wisc.edu>, Sage Weil <sage@redhat.com>

On Thu, Apr 02, 2015 at 02:40:19AM +0300, Ilya Dryomov wrote:
> On Thu, Apr 2, 2015 at 2:03 AM, Mel Gorman <mgorman@suse.de> wrote:
> > On Wed, Apr 01, 2015 at 08:19:20PM +0300, Ilya Dryomov wrote:
> >> Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
> >> flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
> >> cephfs.  However it turned out to not play nice with loopback scenario,
> >> leading to lockups with a full socket send-q and empty recv-q.
> >>
> >> While we always advised against colocating kernel client and ceph
> >> servers on the same box, a few people are doing it and it's also useful
> >> for light development testing, so rather than reverting make sure to
> >> not set those flags in the loopback case.
> >>
> >
> > This does not clarify why the non-loopback case needs access to pfmemalloc
> > reserves. Granted, I've spent zero time on this but it's really unclear
> > what problem was originally tried to be solved and why dirty page limiting
> > was insufficient. Swap over NFS was always a very special case minimally
> > because it's immune to dirty page throttling.
> 
> I don't think there was any particular problem tried to be solved,

Then please go back and look at why dirty page limiting is insufficient
for ceph.

> certainly not one we hit and fixed with 89baaa570ab0.  Mike is out this
> week, but I'm pretty sure he said he copied this for iscsi from nbd
> because you nudged him to (and you yourself did this for nbd as part of
> swap-over-NFS series).

In http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/23708 I
stated that if ceph insisted on using using nbd as justification for ceph
using __GFP_MEMALLOC that it was preferred that nbd be broken instead. In
commit 7f338fe4540b1d0600b02314c7d885fd358e9eca, the use case in mind was
the swap-over-nbd case and I regret I didn't have userspace explicitly
tell the kernel that NBD was being used as a swap device.
