From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH RESEND] ceph:Remove unneeded locking/unlocking of session mutex in the function drop_leases
Date: Wed, 13 Jan 2016 16:25:32 +0800
Message-ID: <F3B5F5DD-8EF4-4BB0-9B20-3ACBBD14016B@redhat.com>
References: <1452605785-32579-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40135 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755456AbcAMIZn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 03:25:43 -0500
In-Reply-To: <1452605785-32579-1-git-send-email-xerofoify@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org


> On Jan 12, 2016, at 21:36, Nicholas Krause <xerofoify@gmail.com> wrote:
> 
> This removes the unneeded lock/unlocking of the session mutex as
> part of the structure pointer s of type ceph_mds_session as this
> locking/unlocking of the session mutex does not protect any
> critical region and thus only wastes time in acquiring and unlocking
> this mutex in the function drop_leases.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
> fs/ceph/mds_client.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 51cb02d..f987054 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3322,8 +3322,6 @@ static void drop_leases(struct ceph_mds_client *mdsc)
> 		if (!s)
> 			continue;
> 		mutex_unlock(&mdsc->mutex);
> -		mutex_lock(&s->s_mutex);
> -		mutex_unlock(&s->s_mutex);
> 		ceph_put_mds_session(s);
> 		mutex_lock(&mdsc->mutex);
> 	}

the lock/unlock waits any code in critical region to exit


> -- 
> 2.1.4
> 

