From: Loic Dachary <loic@dachary.org>
Subject: Re: storing multiple weights in crush
Date: Thu, 6 Apr 2017 09:10:06 +0200
Message-ID: <1a8f25a4-e700-ac6c-92ba-d963b92e0d67@dachary.org>
References: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42400 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdDFHKL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 03:10:11 -0400
In-Reply-To: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

To summarize the next action item, the current draft 

http://libcrush.org/main/libcrush/merge_requests/30/diffs

should be updated with:

struct crush_bucket_weight_set {
  __u32 bucket_id;  /* used as input to hash in place of bucket id */
  __u32 num_positions, num_items;
  __u32 *data; // index like [item*num_items+pos]
};

struct crush_weight_set {
  struct crush_bucket_weights *bucket_weights;
  __u32 size;
};

and the logic updated so that bucket_id is used if it is != 0. If it is == 0 then the bucket id from the crushmap is used.

An effort should also be made to move to move the "if (weight_set == NULL) then use the original weights else use the weight set" logic in crush_do_rule instead of the choose function. The list,uniform and straw2 function all have different ways of use the weights (and therefore the weight set) and it is unclear if this would be beneficial.

Did I forget something ?

Cheers

On 03/27/2017 06:45 PM, Loic Dachary wrote:
> Hi Sage,
> 
> I added a proposal[1] to the next CDM[2] to be able to store and use multiple weights for each item in the crushmap. 
> 
> I'm not sure about the naming (probabilities is a long word...) but it would be good to not have a third variable named weight with yet another meaning. Although we could modify the builder functions, I'm not sure this is a good idea. They are not complete enough to hide the crush data structures and it is probably enough to document the new data members. And the caller can allocate it and fill it after creating a bucket. In practice that is going to be used by CrushWrapper or python-crush which will define an API.
> 
> It is probably best if the crush modification is the bare minimum:
> 
> - allowing the choose function to pick a probability from a table indexed by the round instead of relying on a single weight
> - storing the probability table in each item
> 
> Feel free to modify the pad if you have other ideas, this is a first draft done today and I won't be offended if it is discarded ;-)
> 
> Cheers
> 
> [1] http://pad.ceph.com/p/crush-multiweight
> [2] http://tracker.ceph.com/projects/ceph/wiki/CDM_05-APR-2017
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
