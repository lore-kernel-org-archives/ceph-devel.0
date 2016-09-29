From: Sage Weil <sweil@redhat.com>
Subject: Re: create rbd image failed
Date: Thu, 29 Sep 2016 13:56:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609291354140.19850@piezo.us.to>
References: <CAGRcXKZVyFj0YSSR-kwxhKB=pkKXZYraOwqY_2j56AoZOjGRUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755085AbcI2N4t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 09:56:49 -0400
In-Reply-To: <CAGRcXKZVyFj0YSSR-kwxhKB=pkKXZYraOwqY_2j56AoZOjGRUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jin Cai <caijin.laurence@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 29 Sep 2016, Jin Cai wrote:
> Hi,
> To use erasure coding in rbd, I created a cache pool with the read-only
> mode.
> But when I created a rbd image for the cache pool, there was an unexpected
> error:
> 
> 
> rbd create -p cache-pool --image cache-image --image-format 2 --object-size
> 16K --image-feature layering --size 5G
> 2016-09-29 21:20:03.437598 7f5b9d150d80 -1 librbd: error writing header:
> (95) Operation not supported
> rbd: create error: (95) Operation not supported
> 
> 
> I think it is due to the reason that setting cache pool in read-only mode,
> but I do not know why it is. Did someone face the same situation before?

The read-only cache mode is only usable for librados users who are deeply 
familiar with the code and know what they are doing.  It is not usably by 
rgw or rbd or probably anything else.  In fact, the mon should prevent you 
from setting the readonly mode in the first place on jewel...

sage
