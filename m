From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH] rbd: lock_on_read map option
Date: Sat, 24 Sep 2016 04:47:41 -0500
Message-ID: <57E64BBD.4040407@redhat.com>
References: <1474554177-4029-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbcIXJrn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 24 Sep 2016 05:47:43 -0400
In-Reply-To: <1474554177-4029-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/22/2016 09:22 AM, Ilya Dryomov wrote:
> Add a per-device option to acquire exclusive lock on reads (in addition
> to writes and discards).  The use case is iSCSI, where it will be used
> to prevent execution of stale writes after the implicit failover.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Tested-by: Mike Christie <mchristi@redhat.com>

