From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 0/8] ceph: cap handling code fixes, cleanups and comments
Date: Tue, 24 Mar 2020 23:05:44 +0800
Message-ID: <CAAM7YAmJ6cCyPj6spnUjrGkE=9w4p2gwbyVb-VhFhj2OBRZH7A@mail.gmail.com>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCXPF4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2020 11:05:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so15184883qtb.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2020 08:05:56 -0700 (PDT)
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>

On Tue, Mar 24, 2020 at 12:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> I've been going over the cap handling code with an aim toward
> simplifying the locking. There's one fix for a potential use-after-free
> race in here. This also eliminates a number of __acquires and __releases
> annotations by reorganizing the code, and adds some (hopefully helpful)
> comments.
>
> There should be no behavioral changes with this set.
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

Other than minor comment for the first commit, this series look good

> --
> 2.25.1
>
