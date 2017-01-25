From: Sage Weil <sweil@redhat.com>
Subject: Re: crush_reweight_uniform_bucket documentation
Date: Wed, 25 Jan 2017 12:47:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701251245590.3654@piezo.novalocal>
References: <7b20a259-5918-9180-a544-be43ec937609@dachary.org> <alpine.DEB.2.11.1701242341410.3654@piezo.novalocal> <974963180.8100.1485330317966@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1768660616-1485348459=:3654"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdAYMrk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Jan 2017 07:47:40 -0500
In-Reply-To: <974963180.8100.1485330317966@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1768660616-1485348459=:3654
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 25 Jan 2017, Wido den Hollander wrote:
> > Op 25 januari 2017 om 0:43 schreef Sage Weil <sweil@redhat.com>:
> > 
> > 
> > On Wed, 25 Jan 2017, Loic Dachary wrote:
> > > Hi Sage,
> > > 
> > > While documenting crush_reweight_bucket[1] I came accross something that 
> > > I don't understand when reweighting uniform buckets[2]. The associated 
> > > commit[3] is six years old but maybe your remember why the item_weight 
> > > had to be adjusted with the average of the weight of the buckets... but 
> > > only if there are more buckets than leaves ?
> > 
> > I think it's just a half-hearted attempt to Do The Right Thing when the 
> > situation is nonsensical.  Uniform buckets are meant to be used with leave 
> > (device) items of fixed weight (item_weight).  If you (ab)use them with 
> > bucket children, the algorithm can't really do the right thing because it 
> > doesn't understand the child bucket weights.  If there are a lot of bucket 
> > children it resets item_weight to their average.
> > 
> > This is probably pointless... we could just remove it, and perhaps warn 
> > (or error out?) in CrushCompiler if a uniform bucket child is a 
> > non-device.
> > 
> 
> So I know of a setup which uses something like this:
> 
> datacenter dc1 {
>     alg straw2
>     hash 0
>     item rack1
>     item rack2
> }
> 
> root ams {
>     alg uniform
>     hash 0
>     item dc1
>     item dc2
>     item dc3
>     item dc4
> }
> 
> They want all 3 replicas over 3 different DCs and be able to handle a 
> complete DC failure and recover from it. To prevent data shuffling when 
> a weight is changed in a rack, but data may move inside the DC.
> 
> From your comment I understand that was never the intention of uniform 
> buckets?

It was certainly not the intention.  I think it ought to work, 
though, provided the code that tries to keep the weights summing 
up the tree "behave" (are effectively a no-op) on the uniform buckets.

sage


> 
> Wido
> 
> > s
> > 
> > 
> > > 
> > > Cheers
> > > 
> > > [1] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.h#L111
> > > [2] http://libcrush.org/main/libcrush/blob/wip-2-doxygen/crush/builder.c#L1282
> > > [3] http://libcrush.org/main/libcrush/commit/60f627f88c6314c5a89bb7119ead907ca8b8ef37
> > > 
> > > -- 
> > > Loïc Dachary, Artisan Logiciel Libre
> > > 
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1768660616-1485348459=:3654--
