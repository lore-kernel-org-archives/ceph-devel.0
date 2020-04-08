From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/2] ceph: support cross-quota-tree renames
Date: Wed, 08 Apr 2020 10:31:10 -0400
Message-ID: <c0942c61c37e3f79dcc88ddba94d65aca2ca9a2c.camel@kernel.org>
References: <20200407103020.22588-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbgDHObM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:31:12 -0400
In-Reply-To: <20200407103020.22588-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, Zheng Yan <zyan@redhat.com>
Cc: Frank Schilder <frans@dtu.dk>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 11:30 +0100, Luis Henriques wrote:
> Hi!
> 
> The following patches will make the cephfs kernel client behave the same
> way as the fuse client when doing renames across different quota realms.
> 
> Changes since v1:
> 
> - Dropped 'old == new' check in ceph_quota_check_rename() and added back
>   optimization in ceph_rename(), to only check realms if old_dir and
>   new_dir are different.
> 
> Luis Henriques (2):
>   ceph: normalize 'delta' parameter usage in check_quota_exceeded
>   ceph: allow rename operation under different quota realms
> 
>  fs/ceph/dir.c   |  9 +++----
>  fs/ceph/quota.c | 62 +++++++++++++++++++++++++++++++++++++++++++++----
>  fs/ceph/super.h |  3 ++-
>  3 files changed, 65 insertions(+), 9 deletions(-)
> 

Looks good. Merged into ceph-client/testing.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
