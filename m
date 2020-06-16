From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] libceph: move away from global osd_req_flags
Date: Tue, 16 Jun 2020 10:00:36 -0400
Message-ID: <8d7ea3bf8b7d26dea1aae30054676d1309838784.camel@kernel.org>
References: <20200608075603.29053-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFPOAh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:00:37 -0400
In-Reply-To: <20200608075603.29053-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Mon, 2020-06-08 at 09:56 +0200, Ilya Dryomov wrote:
> osd_req_flags is overly general and doesn't suit its only user
> (read_from_replica option) well:
> 
> - applying osd_req_flags in account_request() affects all OSD
>   requests, including linger (i.e. watch and notify).  However,
>   linger requests should always go to the primary even though
>   some of them are reads (e.g. notify has side effects but it
>   is a read because it doesn't result in mutation on the OSDs).
> 
> - calls to class methods that are reads are allowed to go to
>   the replica, but most such calls issued for "rbd map" and/or
>   exclusive lock transitions are requested to be resent to the
>   primary via EAGAIN, doubling the latency.
> 
> Get rid of global osd_req_flags and set read_from_replica flag
> only on specific OSD requests instead.
> 
> Fixes: 8ad44d5e0d1e ("libceph: read_from_replica option")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c          |  4 +++-
>  include/linux/ceph/libceph.h |  4 ++--
>  net/ceph/ceph_common.c       | 14 ++++++--------
>  net/ceph/osd_client.c        |  3 +--
>  4 files changed, 12 insertions(+), 13 deletions(-)

Looks reasonable:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
