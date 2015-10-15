From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: don't leak parent_spec in rbd_dev_probe_parent()
Date: Thu, 15 Oct 2015 16:10:23 -0500
Message-ID: <5620163F.3060406@ieee.org>
References: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36528 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbJOVKb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 17:10:31 -0400
Received: by ioii196 with SMTP id i196so103627281ioi.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 14:10:31 -0700 (PDT)
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

OK, now that I understand the context...

You now get extra references for the spec and client
for the parent only after creating the parent device.
I think the reason they logically belonged before
the call to rbd_device_create() for the parent is
because the client and spec pointers passed to that
function carry with them references that are passed
to the resulting rbd_device if successful.

If creating the parent device fails, you unparent the
original device, which will still have a null parent
pointer.  The effect of unparenting in this case is
dropping a reference to the parent's spec, and clearing
the device's pointer to it.  This is confusing, but
let's run with it.

If creating the parent device succeeds, references to
the client and parent spec are taken (basically, these
belong to the just-created parent device).  The parent
image is now probed.  If this fails, you again
unparent the device.  We still have not set the
device's parent pointer, so the effect is as before,
dropping the parent spec reference and clearing
the device's reference to it.  The error handling
now destroys the parent, which drops references to
its client and the spec.  Again, this seems
confusing, as if we've dropped one more reference
to the parent spec than desired.

This logic now seems to work.  But it's working
around a flaw in the caller I think.  Upon entry
to rbd_dev_probe_parent(), a layered device will
have have a non-null parent_spec pointer (and a
reference to it), which will have been filled in
by rbd_dev_v2_parent_info().

Really, it should not be rbd_dev_probe_parent()
that drops that parent spec reference on error.
Instead, rbd_dev_image_probe() (which got the
reference to the parent spec) should handle
cleaning up the device's parent spec if an
error occurs after it has been assigned.

I'll wait for your response, I'd like to know
if what I'm saying makes sense.

					-Alex

> Redo rbd_dev_probe_parent() to fix this.
> 
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

