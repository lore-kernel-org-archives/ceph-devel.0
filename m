From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Fri, 03 Apr 2015 15:03:53 -0500
Message-ID: <551EF229.5000509@redhat.com>
References: <1427908760-7083-1-git-send-email-idryomov@gmail.com> <20150401230323.GD20397@suse.de> <CAOi1vP-u_sWF0uZpbYCN9qUp80tXQvmnJdOjWM3kpSR1JqSDMg@mail.gmail.com> <20150402054124.GE20397@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbDCUDz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Apr 2015 16:03:55 -0400
In-Reply-To: <20150402054124.GE20397@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>, Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <michaelc@cs.wisc.edu>, Sage Weil <sage@redhat.com>

On 04/02/2015 12:41 AM, Mel Gorman wrote:
> On Thu, Apr 02, 2015 at 02:40:19AM +0300, Ilya Dryomov wrote:
>> > On Thu, Apr 2, 2015 at 2:03 AM, Mel Gorman <mgorman@suse.de> wrote:
>>> > > On Wed, Apr 01, 2015 at 08:19:20PM +0300, Ilya Dryomov wrote:
>>>> > >> Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
>>>> > >> flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
>>>> > >> cephfs.  However it turned out to not play nice with loopback scenario,
>>>> > >> leading to lockups with a full socket send-q and empty recv-q.
>>>> > >>
>>>> > >> While we always advised against colocating kernel client and ceph
>>>> > >> servers on the same box, a few people are doing it and it's also useful
>>>> > >> for light development testing, so rather than reverting make sure to
>>>> > >> not set those flags in the loopback case.
>>>> > >>
>>> > >
>>> > > This does not clarify why the non-loopback case needs access to pfmemalloc
>>> > > reserves. Granted, I've spent zero time on this but it's really unclear
>>> > > what problem was originally tried to be solved and why dirty page limiting
>>> > > was insufficient. Swap over NFS was always a very special case minimally
>>> > > because it's immune to dirty page throttling.
>> > 
>> > I don't think there was any particular problem tried to be solved,
> Then please go back and look at why dirty page limiting is insufficient
> for ceph.
> 

The problem I was trying to solve is just the basic one where block
drivers have in the past been required to be able to make forward
progress on a write. With iscsi under heavy IO and memory use loads, we
will see memory allocation failures from the network layer followed by
hard system lock ups. The block layer and its drivers like scsi does not
make any distinction between swap and non swap disks to handle this
problem. It will always just work when the network is not involved. I
thought we did not special case swap, because there were cases where
there may not be swappable pages, and the mm layer then needs to write
out pages to other non-swap disks to be able to free up memory.

In the block layer and scsi drivers like qla2xxx forward progress is
easier to handle. They just use bio, request, scsi_cmnd, scatterlist,
etc mempools and internally preallocate some resources they need. For
iscsi and other block drivers that use the network, it is more difficult
as you of course know, and when I did the iscsi and rbd/ceph patches I
had thought we were supposed to be using the memalloc related flags to
handle this problem for both swap and non swap cases. I might have
misunderstood you way back when I did those patches originally.

For dirty page limiting, I thought the problem is that it is difficult
to get right and at the same time not affect performance for some
workloads. For non-net block drivers, we do not have to configure it
just to handle this problem. It just works, and so I thought we have
been trying to solve this problem in a similar way as the rest of the
block layer by having some memory reserves.

Also on a related note, I thought I heard at LSF that that forward
progress requirement for non swap writes was going away. Is that true
and is it something that is going to happen in the near future or was it
more of a wish list item.
