From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/3] ceph: remove special ack vs commit behavior
Date: Thu, 23 Feb 2017 18:00:29 -0500
Message-ID: <1487890829.10904.5.camel@redhat.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
         <1487883561-32001-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34072 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdBWXUM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 18:20:12 -0500
Received: by mail-qk0-f180.google.com with SMTP id s186so5934801qkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 15:20:12 -0800 (PST)
In-Reply-To: <1487883561-32001-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

On Thu, 2017-02-23 at 21:59 +0100, Ilya Dryomov wrote:
> - ask for a commit reply instead of an ack reply in
>   __ceph_pool_perm_get()
> - don't ask for both ack and commit replies in ceph_sync_write()
> - since just only one reply is requested now, i_unsafe_writes list
>   will always be empty -- kill ceph_sync_write_wait() and go back to
>   a standard ->evict_inode()
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  fs/ceph/addr.c  |  2 +-
>  fs/ceph/caps.c  |  2 --
>  fs/ceph/file.c  | 88 +--------------------------------------------------------
>  fs/ceph/inode.c |  9 ------
>  fs/ceph/super.c |  1 -
>  fs/ceph/super.h |  4 +--
>  6 files changed, 3 insertions(+), 103 deletions(-)
> 

Love that diffstat!

Reviewed-by: Jeff Layton <jlayton@redhat.com>
