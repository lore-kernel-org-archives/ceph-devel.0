From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH 0/8] ceph: cap handling code fixes, cleanups and comments
Date: Tue, 31 Mar 2020 13:24:50 +0100
Message-ID: <20200331122450.GA2364@suse.com>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgCaMYw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:24:52 -0400
Content-Disposition: inline
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

On Mon, Mar 23, 2020 at 12:07:00PM -0400, Jeff Layton wrote:
> I've been going over the cap handling code with an aim toward
> simplifying the locking. There's one fix for a potential use-after-free
> race in here. This also eliminates a number of __acquires and __releases
> annotations by reorganizing the code, and adds some (hopefully helpful)
> comments.
> 
> There should be no behavioral changes with this set.

But a lot of clarifications!  Thanks a lot for this patchset, Jeff ;-)

Cheers,
--
Luis

> 
> Jeff Layton (8):
>   ceph: reorganize __send_cap for less spinlock abuse
>   ceph: split up __finish_cap_flush
>   ceph: add comments for handle_cap_flush_ack logic
>   ceph: don't release i_ceph_lock in handle_cap_trunc
>   ceph: don't take i_ceph_lock in handle_cap_import
>   ceph: document what protects i_dirty_item and i_flushing_item
>   ceph: fix potential race in ceph_check_caps
>   ceph: throw a warning if we destroy session with mutex still locked
> 
>  fs/ceph/caps.c       | 292 ++++++++++++++++++++++++-------------------
>  fs/ceph/mds_client.c |   1 +
>  fs/ceph/super.h      |   4 +-
>  3 files changed, 170 insertions(+), 127 deletions(-)
> 
> -- 
> 2.25.1
> 
