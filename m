From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 0/3] libceph: target_copy() fixups
Date: Tue, 16 Jun 2020 07:33:24 -0400
Message-ID: <e2ff602f1b643092eae1682ba770cadd31faefe3.camel@kernel.org>
References: <20200616074415.9989-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgFPLd0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:33:26 -0400
In-Reply-To: <20200616074415.9989-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 2020-06-16 at 09:44 +0200, Ilya Dryomov wrote:
> Hello,
> 
> Split into three commits for backporting reasons: the first two can be
> picked up by stable, the third should get some soak time in testing.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (3):
>   libceph: don't omit recovery_deletes in target_copy()
>   libceph: don't omit used_replica in target_copy()
>   libceph: use target_copy() in send_linger()
> 
>  net/ceph/osd_client.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

These all look sane to me:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
