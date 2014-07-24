From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Read from clones
Date: Thu, 24 Jul 2014 12:56:51 +0400
Message-ID: <CALFYKtD4B4Kpi5nPoOZ2Jc1gOnfPSUrbixDhiOCuin_eePL=kA@mail.gmail.com>
References: <3ADFB25A75C80A4BA0183C65FE86C53404934AB4@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:60802 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaGXI4w convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:56:52 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so2871876qgf.6
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:56:51 -0700 (PDT)
In-Reply-To: <3ADFB25A75C80A4BA0183C65FE86C53404934AB4@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lakshminarayana Mavunduri <Lakshminarayana.Mavunduri@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>

On Tue, Jul 15, 2014 at 9:44 AM, Lakshminarayana Mavunduri
<Lakshminarayana.Mavunduri@sandisk.com> wrote:
> Hi,
>
> Following the below set of steps, we are seeing data loss while reading from clones.
>
> 1)Create an image with image format 2 (in this case we have made the size to be 1024MB).
>         rbd create image1 --size 1024 --image-format 2
> 2)Map the image and write 1024MB worth of data to it.
> 3)Create a snapshot for the image created in step 1)
>         rbd snap create image1@snap1
> 4)Create a clone for the snapshot created in step 3)
>         rbd clone image1@snap1 clone1
> 5)Create a snapshot for the clone created in step 4)
>         rbd snap create clone1@snap2
> 6)Create a clone for the snapshot created in step 5)
>         rbd clone clone1@snap2 clone2
> 7)Shrink the size of the clone created in step 4) (in this case we have made it to half of its size)
>         rbd resize -s 512 --allow-shrink clone1
> 8)Map the clone created in step 6) and try reading 1024MB worth of data.
> 9)Our observation is that, only the first 512MB worth data is intact, the rest is not copied over. (In fact, it's only the parent overlap worth data of clone1 that is always copied over!)
>
> After the above set of steps, the parent overlap for clone2 would be 1024MB, whereas the parent overlap for clone1 would be 512MB. Our understanding is, since clone2's parent snapshot is taken before a shrink is performed on clone1, any reads worth parent overlap data on clone2 should be serviced from it's parent (at least, as long as there are no overwrites done on clone2, which is the case here), and we are not finding that to be true in this case.
>
> To augment our theory, if the parent image (a base RBD image, which is not a clone) is shrinked, any reads on the clones that are created before the shrink, are as expected to our understanding.
>
> Wanted to check if this is indeed a bug or if we are missing anything here. The tests are run across ceph version 0.80.

FWIW, I just pushed a fix for this - wip-overlap in ceph-client.git.

Thanks,

                Ilya
