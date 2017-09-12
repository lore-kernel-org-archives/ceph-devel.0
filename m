From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 5/5] ceph: avoid null pointer derefernece in case of
 utsname() return NULL
Date: Tue, 12 Sep 2017 09:15:20 -0400
Message-ID: <1505222120.28831.10.camel@redhat.com>
References: <20170912025351.42147-1-zyan@redhat.com>
         <20170912025351.42147-6-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34638 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdILNPX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 09:15:23 -0400
Received: by mail-yw0-f178.google.com with SMTP id r85so28103514ywg.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 06:15:23 -0700 (PDT)
In-Reply-To: <20170912025351.42147-6-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com

On Tue, 2017-09-12 at 10:53 +0800, Yan, Zheng wrote:
> utsname() can return NULL while process is exiting. kernel releases
> file locks during process exits. We send request to mds when releasing
> file lock. So it's possible that we open mds session while process is
> exiting. utsname() is called in create_session_open_msg()
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/mds_client.c | 6 ++++--
>  fs/ceph/mds_client.h | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 26893cc1fbee..ab6b998d3f44 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -884,8 +884,8 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>  	void *p;
>  
>  	const char* metadata[][2] = {
> -		{"hostname", utsname()->nodename},
> -		{"kernel_version", utsname()->release},
> +		{"hostname", mdsc->nodename},
> +		{"kernel_version", init_utsname()->release},
>  		{"entity_id", opt->name ? : ""},
>  		{"root", fsopt->server_path ? : "/"},
>  		{NULL, NULL}
> @@ -3558,6 +3558,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	init_rwsem(&mdsc->pool_perm_rwsem);
>  	mdsc->pool_perm_tree = RB_ROOT;
>  
> +	strncpy(mdsc->nodename, utsname()->nodename,
> +		sizeof(mdsc->nodename) - 1);
>  	return 0;
>  }
>  
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index db57ae98ed34..636d6b2ec49c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -8,6 +8,7 @@
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
>  #include <linux/refcount.h>
> +#include <linux/utsname.h>
>  
>  #include <linux/ceph/types.h>
>  #include <linux/ceph/messenger.h>
> @@ -368,6 +369,8 @@ struct ceph_mds_client {
>  
>  	struct rw_semaphore     pool_perm_rwsem;
>  	struct rb_root		pool_perm_tree;
> +
> +	char nodename[__NEW_UTS_LEN + 1];
>  };
>  
>  extern const char *ceph_mds_op_name(int op);

(nit: might want to add a link to the tracker bug in the description)

Reviewed-by: Jeff Layton <jlayton@redhat.com>
