From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-devel] [patch] ceph: handle kmalloc() failure
Date: Sat, 20 Mar 2010 20:59:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003202059260.15445@cobra.newdream.net>
References: <20100320123015.GA29929@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100320123015.GA29929@bicker>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 20 Mar 2010, Dan Carpenter wrote:

> Return ERR_PTR(-ENOMEM) if kmalloc() fails.  We handle allocation 
> failures the same way later in the function.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a260010..655b005 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -328,6 +328,8 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>  	struct ceph_mds_session *s;
>  
>  	s = kzalloc(sizeof(*s), GFP_NOFS);
> +	if (!s)
> +		return ERR_PTR(-ENOMEM);
>  	s->s_mdsc = mdsc;
>  	s->s_mds = mds;
>  	s->s_state = CEPH_MDS_SESSION_NEW;

Applied, thanks!
sage
