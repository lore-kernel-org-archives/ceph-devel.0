From: Sage Weil <sweil@redhat.com>
Subject: Re: storing multiple weights in crush
Date: Thu, 6 Apr 2017 13:20:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704061319130.2999@piezo.novalocal>
References: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org> <1a8f25a4-e700-ac6c-92ba-d963b92e0d67@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-922827825-1491484834=:2999"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753213AbdDFNUf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Apr 2017 09:20:35 -0400
In-Reply-To: <1a8f25a4-e700-ac6c-92ba-d963b92e0d67@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-922827825-1491484834=:2999
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 6 Apr 2017, Loic Dachary wrote:
> Hi Sage,
> 
> To summarize the next action item, the current draft 
> 
> http://libcrush.org/main/libcrush/merge_requests/30/diffs
> 
> should be updated with:
> 
> struct crush_bucket_weight_set {
>   __u32 bucket_id;  /* used as input to hash in place of bucket id */
>   __u32 num_positions, num_items;
>   __u32 *data; // index like [item*num_items+pos]
> };
> 
> struct crush_weight_set {
>   struct crush_bucket_weights *bucket_weights;
>   __u32 size;
> };
> 
> and the logic updated so that bucket_id is used if it is != 0. If it is == 0 then the bucket id from the crushmap is used.

Sounds good!
 
> An effort should also be made to move to move the "if (weight_set == 
> NULL) then use the original weights else use the weight set" logic in 
> crush_do_rule instead of the choose function. The list,uniform and 
> straw2 function all have different ways of use the weights (and 
> therefore the weight set) and it is unclear if this would be beneficial.

Only if it makes sense; just an idea.  :)

> Did I forget something ?

Next steps after that will be handling the encoding and such.  Probably 
a CrushWrapper::WeightSet class with encode/decode or somethign?

sage

> 
> Cheers
> 
> On 03/27/2017 06:45 PM, Loic Dachary wrote:
> > Hi Sage,
> > 
> > I added a proposal[1] to the next CDM[2] to be able to store and use multiple weights for each item in the crushmap. 
> > 
> > I'm not sure about the naming (probabilities is a long word...) but it would be good to not have a third variable named weight with yet another meaning. Although we could modify the builder functions, I'm not sure this is a good idea. They are not complete enough to hide the crush data structures and it is probably enough to document the new data members. And the caller can allocate it and fill it after creating a bucket. In practice that is going to be used by CrushWrapper or python-crush which will define an API.
> > 
> > It is probably best if the crush modification is the bare minimum:
> > 
> > - allowing the choose function to pick a probability from a table indexed by the round instead of relying on a single weight
> > - storing the probability table in each item
> > 
> > Feel free to modify the pad if you have other ideas, this is a first draft done today and I won't be offended if it is discarded ;-)
> > 
> > Cheers
> > 
> > [1] http://pad.ceph.com/p/crush-multiweight
> > [2] http://tracker.ceph.com/projects/ceph/wiki/CDM_05-APR-2017
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-922827825-1491484834=:2999--
