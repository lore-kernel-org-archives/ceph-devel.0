From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH v2 0/2] ceph: fix long stalls on sync/syncfs
Date: Thu, 2 Apr 2020 08:54:02 -0700
Message-ID: <CAJ4mKGY_1vtbaM-m+X7yKE-vFDorWi9E+RNbPi-z5bcXkdXQYw@mail.gmail.com>
References: <20200402112911.17023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388677AbgDBPyU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Apr 2020 11:54:20 -0400
Received: by mail-qk1-f199.google.com with SMTP id c1so3405641qkg.21
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2020 08:54:14 -0700 (PDT)
In-Reply-To: <20200402112911.17023-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <ukernel@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, "Weil, Sage" <sage@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

Didn't look at the code too hard, but this sounds good to me.

I also realized that the userspace client isn't quite complete because
it didn't send out FLAG_SYNC on a per-MDS-session basis, just for the
last cap in its global dirty list. So thanks for that. :)
https://tracker.ceph.com/issues/44916

On Thu, Apr 2, 2020 at 4:29 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> This is v2 of the patch I sent the other day to fix the problem of long
> stalls when calling sync or syncfs.
>
> This set converts the mdsc->cap_dirty list to a per-session list, and
> then has the only caller that looks at cap_dirty walk the list of
> sessions and issue flushes for each session in turn.
>
> With this, we can use an empty s_cap_dirty list as an indicator that the
> cap flush is the last one going to the session and can mark that one as
> one we're waiting on so the MDS can expedite it.
>
> This also attempts to clarify some of the locking around s_cap_dirty,
> and adds a FIXME comment to raise the question about locking around
> s_cap_flushing.
>
> Jeff Layton (2):
>   ceph: convert mdsc->cap_dirty to a per-session list
>   ceph: request expedited service on session's last cap flush
>
>  fs/ceph/caps.c       | 72 +++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/mds_client.c |  2 +-
>  fs/ceph/mds_client.h |  5 +--
>  fs/ceph/super.h      | 21 +++++++++++--
>  4 files changed, 87 insertions(+), 13 deletions(-)
>
> --
> 2.25.1
>
