From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: don't leak parent_spec in rbd_dev_probe_parent()
Date: Thu, 15 Oct 2015 12:10:42 -0500
Message-ID: <561FDE12.9070406@ieee.org>
References: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36319 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJORKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 13:10:44 -0400
Received: by ioii196 with SMTP id i196so96569437ioi.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 10:10:43 -0700 (PDT)
In-Reply-To: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 10/11/2015 01:03 PM, Ilya Dryomov wrote:
> Currently we leak parent_spec and trigger a "parent reference
> underflow" warning if rbd_dev_create() in rbd_dev_probe_parent() fails.
> The problem is we take the !parent out_err branch and that only drops
> refcounts; parent_spec that would've been freed had we called
> rbd_dev_unparent() remains and triggers rbd_warn() in
> rbd_dev_parent_put() - at that point we have parent_spec != NULL and
> parent_ref == 0, so counter ends up being -1 after the decrement.
> 
> Redo rbd_dev_probe_parent() to fix this.

I'm just starting to look at this.

My up-front problem is that I want to understand why
it's OK to no longer grab references to the parent spec
and the client before creating the new parent device.
Is it simply because the rbd_dev that's the subject
of this call is already holding a reference to both,
so no need to get another?  I think that's right, but
you should say that in the explanation.  It's a
change that's independent of the other change (which
you describe).

OK, onto the change you describe.

You say that we get the underflow if rbd_dev_create() fails.

At that point in the function, we have:
    parent == NULL
    rbd_dev->parent_spec != NULL
    parent_spec holds a new reference to that
    rbdc holds a new reference to the client

rbd_dev_create() only returns NULL if the kzalloc() fails.
And if so, we jump to out_err, take the !parent branch,
and we drop the references we took in rbdc and parent_spec
before returning.

Where is the leak?  (Actually, underflow means we're
dropping more references than we took.)

I'm not saying your patch is wrong, but I'm not
understanding the problem you describe.  I'm
probably just missing something; please educate me.

					-Alex

> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cd00e4653e49..ccbc3cbbf24e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5134,41 +5134,37 @@ out_err:
>  static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
>  {
>  	struct rbd_device *parent = NULL;
> -	struct rbd_spec *parent_spec;
> -	struct rbd_client *rbdc;
>  	int ret;
>  
>  	if (!rbd_dev->parent_spec)
>  		return 0;
> -	/*
> -	 * We need to pass a reference to the client and the parent
> -	 * spec when creating the parent rbd_dev.  Images related by
> -	 * parent/child relationships always share both.
> -	 */
> -	parent_spec = rbd_spec_get(rbd_dev->parent_spec);
> -	rbdc = __rbd_get_client(rbd_dev->rbd_client);
>  
> -	ret = -ENOMEM;
> -	parent = rbd_dev_create(rbdc, parent_spec, NULL);
> -	if (!parent)
> +	parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
> +				NULL);
> +	if (!parent) {
> +		ret = -ENOMEM;
>  		goto out_err;
> +	}
> +
> +	/*
> +	 * Images related by parent/child relationships always share
> +	 * rbd_client and spec/parent_spec, so bump their refcounts.
> +	 */
> +	__rbd_get_client(rbd_dev->rbd_client);
> +	rbd_spec_get(rbd_dev->parent_spec);
>  
>  	ret = rbd_dev_image_probe(parent, false);
>  	if (ret < 0)
>  		goto out_err;
> +
>  	rbd_dev->parent = parent;
>  	atomic_set(&rbd_dev->parent_ref, 1);
> -
>  	return 0;
> +
>  out_err:
> -	if (parent) {
> -		rbd_dev_unparent(rbd_dev);
> +	rbd_dev_unparent(rbd_dev);
> +	if (parent)
>  		rbd_dev_destroy(parent);
> -	} else {
> -		rbd_put_client(rbdc);
> -		rbd_spec_put(parent_spec);
> -	}
> -
>  	return ret;
>  }
>  
> 

