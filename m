From: Sage Weil <sage@newdream.net>
Subject: Re: bug report: potential null dereference
Date: Tue, 25 May 2010 09:28:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005250927510.8523@cobra.newdream.net>
References: <20100525094202.GE22515@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58228 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0EYQY2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 12:24:28 -0400
In-Reply-To: <20100525094202.GE22515@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 25 May 2010, Dan Carpenter wrote:
> Hello,
> 
> This is a Smatch thing.
> 
> fs/ceph/auth.c +220 ceph_handle_auth_reply(55) error: potential null derefence 'ac->ops'.
>    211                  /* set up (new) protocol handler? */
>    212                  if (ac->protocol && ac->protocol != protocol) {
>    213                          ac->ops->destroy(ac);
>    214                          ac->protocol = 0;
>    215                          ac->ops = NULL;
>                                 ^^^^^^^^^^^^^^^
> 	We set ac->ops to NULL here.
> 
>    216                  }
>    217                  if (ac->protocol != protocol) {
>    218                          ret = ceph_auth_init_protocol(ac, protocol);
>    219                          if (ret) {
>    220                                  pr_err("error %d on auth method %s init\n",
>    221                                         ret, ac->ops->name);
>                                                     ^^^^^^^^^^^^^^
> 	We dereference it here.  ceph_auth_init_protocol() can fail
> 	before re-assigning it.
> 
>    222                                  goto out;
>    223                          }
>    224                  }

Thanks, I've queued up a fix.

sage

