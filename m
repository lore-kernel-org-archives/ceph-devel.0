From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Wed, 25 Nov 2015 14:55:12 +0300
Message-ID: <20151125115512.GA18797@mwanda>
References: <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <56536BAD.4000309@users.sourceforge.net>
 <56536D12.4000308@users.sourceforge.net>
 <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
 <5654B91D.4040808@users.sourceforge.net>
 <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 24, 2015 at 09:21:06PM +0100, Ilya Dryomov wrote:
> >> Cleanup here is (and should be) done in reverse order.
> >

Yes.  This is true.

> > I have got an other impression about the appropriate order for the corresponding
> > clean-up function calls.
> >
> >
> >> We allocate parent rbd_device and then link it with what we already have,
> >
> > I guess that we have got a different understanding about the relevant "linking".
> 
> Well, there isn't any _literal_ linking (e.g. adding to a link list,
> etc) in this case.  We just bump some refs and do probe to fill in the
> newly allocated parent.  If probe fails, we put refs and free parent,
> reversing the "alloc parent, bump refs" order.
> 
> The actual linking (rbd_dev->parent = parent) is done right before
> returning so we never have to undo it in rbd_dev_probe_parent() and
> that's the only reason your patch probably doesn't break anything.
> Think about what happens if, after your patch is applied, someone moves
> that assignment up or adds an extra step that can fail after it...
> 

The problem is that the unwind code should be a mirror of the allocate
code but rbd_dev_unparent() doesn't mirror anything.  Generally, writing
future proof stubs like this is a wrong thing because predicting the
future is hard and in the mean time we are left stubs which confuse
everyone.

> If all error paths could be adjusted so that NULL pointers are never
> passed in, destroy functions wouldn't need to have a NULL check, would
> they?

Yep.  We agree on the right way to do it.  I am probably the number one
kernel developer for removing the most sanity checks.  :P  (As opposed
to patch 1/1 where we now rely on the sanity check inside
rbd_dev_destroy().)

drivers/block/rbd.c
  5149  static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
  5150  {
  5151          struct rbd_device *parent = NULL;
  5152          int ret;
  5153  
  5154          if (!rbd_dev->parent_spec)
  5155                  return 0;
  5156  
  5157          if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
  5158                  pr_info("parent chain is too long (%d)\n", depth);
  5159                  ret = -EINVAL;
  5160                  goto out_err;

We haven't allocated anything so this should just be return -EINVAL;
In the original code, we decrement the kref count on ->parent_spec on
this error path so that is a classic One Err Bug.

  5161          }
  5162  
  5163          parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
  5164                                  NULL);
  5165          if (!parent) {
  5166                  ret = -ENOMEM;
  5167                  goto out_err;

Still haven't allocated anything so return -ENOMEM, but if we fail after
this point we will need to call rbd_dev_destroy().

  5168          }
  5169  
  5170          /*
  5171           * Images related by parent/child relationships always share
  5172           * rbd_client and spec/parent_spec, so bump their refcounts.
  5173           */
  5174          __rbd_get_client(rbd_dev->rbd_client);
  5175          rbd_spec_get(rbd_dev->parent_spec);

We will need to put these on any later error paths.

  5176  
  5177          ret = rbd_dev_image_probe(parent, depth);
  5178          if (ret < 0)
  5179                  goto out_err;

Ok.  We need to put the ->parent_spec, ->rbd_client and free the parent.

  5180  
  5181          rbd_dev->parent = parent;
  5182          atomic_set(&rbd_dev->parent_ref, 1);
  5183          return 0;
  5184  
  5185  out_err:
  5186          rbd_dev_unparent(rbd_dev);

This is a complicated way to say rbd_spec_put(rbd_dev->parent_spec);

Also, is it really necessary to set ->parent_spec to NULL?  If we didn't
put the last reference then doesn't setting it to NULL mean we are
leaking?  Setting it to NULL is confusing and feels like a layering
violation.

  5187          if (parent)
  5188                  rbd_dev_destroy(parent);
  5189          return ret;
  5190  }

I feel like we should be calling rbd_put_client() on this error path or
else the code is buggy or has layer violations.  So I *think* it should
look like this:

dec_ref_counts:
	rbd_spec_put(rbd_dev->parent_spec);
	rbd_put_client(rbd_dev->rbd_client);

	rbd_dev_destroy(parent);

	return ret;

regards,
dan carpenter
