From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 0/9] ceph: add support for asynchronous directory operations
Date: Thu, 13 Feb 2020 21:05:25 +0800
Message-ID: <CAAM7YAmz9U4TmBMNhFV+4xiDRNM5GVwhe94wZmedwp7g4RgFoQ@mail.gmail.com>
References: <20200212172729.260752-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33202 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMNFi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 08:05:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so5586359qkm.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 05:05:37 -0800 (PST)
In-Reply-To: <20200212172729.260752-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idridryomov@gmail.com, Sage Weil <sage@redhat.com>, Zheng Yan <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Feb 13, 2020 at 1:29 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> I've dropped the async unlink patch from testing branch and am
> resubmitting it here along with the rest of the create patches.
>
> Zheng had pointed out that DIR_* caps should be cleared when the session
> is reconnected. The underlying submission code needed changes to
> handle that so it needed a bit of rework (along with the create code).
>
> Since v3:
> - rework async request submission to never queue the request when the
>   session isn't open
> - clean out DIR_* caps, layouts and delegated inodes when session goes down
> - better ordering for dependent requests
> - new mount options (wsync/nowsync) instead of module option
> - more comprehensive error handling
>
> Jeff Layton (9):
>   ceph: add flag to designate that a request is asynchronous
>   ceph: perform asynchronous unlink if we have sufficient caps
>   ceph: make ceph_fill_inode non-static
>   ceph: make __take_cap_refs non-static
>   ceph: decode interval_sets for delegated inos
>   ceph: add infrastructure for waiting for async create to complete
>   ceph: add new MDS req field to hold delegated inode number
>   ceph: cache layout in parent dir on first sync create
>   ceph: attempt to do async create when possible
>
>  fs/ceph/caps.c               |  73 +++++++---
>  fs/ceph/dir.c                | 101 +++++++++++++-
>  fs/ceph/file.c               | 253 +++++++++++++++++++++++++++++++++--
>  fs/ceph/inode.c              |  58 ++++----
>  fs/ceph/mds_client.c         | 156 +++++++++++++++++++--
>  fs/ceph/mds_client.h         |  17 ++-
>  fs/ceph/super.c              |  20 +++
>  fs/ceph/super.h              |  21 ++-
>  include/linux/ceph/ceph_fs.h |  17 ++-
>  9 files changed, 637 insertions(+), 79 deletions(-)
>

Please implement something like
https://github.com/ceph/ceph/pull/32576/commits/e9aa5ec062fab8324e13020ff2f583537e326a0b.
MDS may revoke Fx when replaying unsafe/async requests. Make mds not
do this is quite complex.

> --
> 2.24.1
>
