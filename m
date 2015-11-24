From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 2/2] block-rbd: One function call less in
 rbd_dev_probe_parent() after error detection
Date: Tue, 24 Nov 2015 20:23:09 +0100
Message-ID: <5654B91D.4040808@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net> <56536BAD.4000309@users.sourceforge.net>
 <56536D12.4000308@users.sourceforge.net>
 <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:53058 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbbKXTXY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Nov 2015 14:23:24 -0500
In-Reply-To: <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> @@ -5157,14 +5157,14 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
>>         if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
>>                 pr_info("parent chain is too long (%d)\n", depth);
>>                 ret = -EINVAL;
>> -               goto out_err;
>> +               goto unparent_device;
>>         }
>>
>>         parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
>>                                 NULL);
>>         if (!parent) {
>>                 ret = -ENOMEM;
>> -               goto out_err;
>> +               goto unparent_device;
>>         }
>>
>>         /*
>> @@ -5176,15 +5176,15 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
>>
>>         ret = rbd_dev_image_probe(parent, depth);
>>         if (ret < 0)
>> -               goto out_err;
>> +               goto destroy_device;
>>
>>         rbd_dev->parent = parent;
>>         atomic_set(&rbd_dev->parent_ref, 1);
>>         return 0;
>> -
>> -out_err:
>> -       rbd_dev_unparent(rbd_dev);
>> +destroy_device:
>>         rbd_dev_destroy(parent);
>> +unparent_device:
>> +       rbd_dev_unparent(rbd_dev);
>>         return ret;
>>  }
> 
> Cleanup here is (and should be) done in reverse order.

I have got an other impression about the appropriate order for the corresponding
clean-up function calls.


> We allocate parent rbd_device and then link it with what we already have,

I guess that we have got a different understanding about the relevant "linking".


> so the order in which we cleanup is unlink ("unparent"), destroy.

I interpreted the eventual passing of a null pointer to the rbd_dev_destroy()
function as an indication for further source code adjustments.


> Changing it is just asking for use-after-free bugs.

Do the affected implementation details need a bit more clarification?

Regards,
Markus
