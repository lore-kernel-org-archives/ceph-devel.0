From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Read from clones
Date: Tue, 15 Jul 2014 20:01:15 +0400
Message-ID: <CALFYKtC1CHjAnB-KY4ToXXGmS7kcMmWrc+v0o7zKUGW1spBAfA@mail.gmail.com>
References: <3ADFB25A75C80A4BA0183C65FE86C53404934AB4@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:63965 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaGOQBQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jul 2014 12:01:16 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so2616300qaj.7
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jul 2014 09:01:15 -0700 (PDT)
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

From a quick read, this looks like a bug in the kernel client.  I'll
investigate more when I get back next week.

Thanks,

                Ilya
