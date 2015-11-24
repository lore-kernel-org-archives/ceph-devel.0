From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/2] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Tue, 24 Nov 2015 21:21:06 +0100
Message-ID: <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
References: <5307CAA2.8060406@users.sourceforge.net>
	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	<530A086E.8010901@users.sourceforge.net>
	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	<530A72AA.3000601@users.sourceforge.net>
	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	<530B5FB6.6010207@users.sourceforge.net>
	<alpine.DEB.2.10.1402241710370.2074@hadrien>
	<530C5E18.1020800@users.sourceforge.net>
	<alpine.DEB.2.10.1402251014170.2080@hadrien>
	<530CD2C4.4050903@users.sourceforge.net>
	<alpine.DEB.2.10.1402251840450.7035@hadrien>
	<530CF8FF.8080600@users.sourceforge.net>
	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	<530DD06F.4090703@users.sourceforge.net>
	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	<5317A59D.4@users.sourceforge.net>
	<56536BAD.4000309@users.sourceforge.net>
	<56536D12.4000308@users.sourceforge.net>
	<CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
	<5654B91D.4040808@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5654B91D.4040808@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 24, 2015 at 8:23 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> @@ -5157,14 +5157,14 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
>>>         if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
>>>                 pr_info("parent chain is too long (%d)\n", depth);
>>>                 ret = -EINVAL;
>>> -               goto out_err;
>>> +               goto unparent_device;
>>>         }
>>>
>>>         parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
>>>                                 NULL);
>>>         if (!parent) {
>>>                 ret = -ENOMEM;
>>> -               goto out_err;
>>> +               goto unparent_device;
>>>         }
>>>
>>>         /*
>>> @@ -5176,15 +5176,15 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
>>>
>>>         ret = rbd_dev_image_probe(parent, depth);
>>>         if (ret < 0)
>>> -               goto out_err;
>>> +               goto destroy_device;
>>>
>>>         rbd_dev->parent = parent;
>>>         atomic_set(&rbd_dev->parent_ref, 1);
>>>         return 0;
>>> -
>>> -out_err:
>>> -       rbd_dev_unparent(rbd_dev);
>>> +destroy_device:
>>>         rbd_dev_destroy(parent);
>>> +unparent_device:
>>> +       rbd_dev_unparent(rbd_dev);
>>>         return ret;
>>>  }
>>
>> Cleanup here is (and should be) done in reverse order.
>
> I have got an other impression about the appropriate order for the corresponding
> clean-up function calls.
>
>
>> We allocate parent rbd_device and then link it with what we already have,
>
> I guess that we have got a different understanding about the relevant "linking".

Well, there isn't any _literal_ linking (e.g. adding to a link list,
etc) in this case.  We just bump some refs and do probe to fill in the
newly allocated parent.  If probe fails, we put refs and free parent,
reversing the "alloc parent, bump refs" order.

The actual linking (rbd_dev->parent = parent) is done right before
returning so we never have to undo it in rbd_dev_probe_parent() and
that's the only reason your patch probably doesn't break anything.
Think about what happens if, after your patch is applied, someone moves
that assignment up or adds an extra step that can fail after it...

>
>
>> so the order in which we cleanup is unlink ("unparent"), destroy.
>
> I interpreted the eventual passing of a null pointer to the rbd_dev_destroy()
> function as an indication for further source code adjustments.

If all error paths could be adjusted so that NULL pointers are never
passed in, destroy functions wouldn't need to have a NULL check, would
they?

Thanks,

                Ilya
