From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/5] libceph: support for replica reads
Date: Mon, 01 Jun 2020 06:57:03 -0400
Message-ID: <7f4f76112da312feec94f03e024ce96f8ad37e8f.camel@kernel.org>
References: <20200530153439.31312-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAK5F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:57:05 -0400
In-Reply-To: <20200530153439.31312-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Sat, 2020-05-30 at 17:34 +0200, Ilya Dryomov wrote:
> Hello,
> 
> This adds support for replica reads (balanced and localized reads)
> to rbd and ceph.  crush_location syntax is slightly different, see
> patch 3 for details.
> 
> v1 -> v2:
> - change crush_location syntax
> - rename read_policy to read_from_replica, add read_from_replica=no
> - crush_location and read_from_replica are now overridable
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (5):
>   libceph: add non-asserting rbtree insertion helper
>   libceph: decode CRUSH device/bucket types and names
>   libceph: crush_location infrastructure
>   libceph: support for balanced and localized reads
>   libceph: read_from_replica option
> 
>  include/linux/ceph/libceph.h    |  13 +-
>  include/linux/ceph/osd_client.h |   1 +
>  include/linux/ceph/osdmap.h     |  19 +-
>  include/linux/crush/crush.h     |   6 +
>  net/ceph/ceph_common.c          |  75 +++++++
>  net/ceph/crush/crush.c          |   3 +
>  net/ceph/debugfs.c              |   6 +-
>  net/ceph/osd_client.c           |  92 +++++++-
>  net/ceph/osdmap.c               | 363 +++++++++++++++++++++++++++-----
>  9 files changed, 517 insertions(+), 61 deletions(-)
> 

Nice work, Ilya. This all looks good to me now. The new mount option
syntax is much more readable.

It might be nice to sprinkle in some comments about the locking around
the new rbtrees (and maybe the existing DEFINE_RB_FUNCS trees), but
that's minor stuff.

You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
