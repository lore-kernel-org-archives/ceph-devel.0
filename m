From: Sage Weil <sweil@redhat.com>
Subject: Re: storing multiple weights in crush
Date: Mon, 27 Mar 2017 23:16:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703272305380.10776@piezo.novalocal>
References: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-232886874-1490656601=:10776"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbdC0XQn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Mar 2017 19:16:43 -0400
In-Reply-To: <e731d3ad-4cde-2f12-0871-962c46df698a@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-232886874-1490656601=:10776
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Mar 2017, Loic Dachary wrote:
> Hi Sage,
> 
> I added a proposal[1] to the next CDM[2] to be able to store and use 
> multiple weights for each item in the crushmap.
> 
> I'm not sure about the naming (probabilities is a long word...) but it 
> would be good to not have a third variable named weight with yet another 
> meaning. Although we could modify the builder functions, I'm not sure 
> this is a good idea. They are not complete enough to hide the crush data 
> structures and it is probably enough to document the new data members. 
> And the caller can allocate it and fill it after creating a bucket. In 
> practice that is going to be used by CrushWrapper or python-crush which 
> will define an API.
> 
> It is probably best if the crush modification is the bare minimum:
> 
> - allowing the choose function to pick a probability from a table 
> indexed by the round instead of relying on a single weight
> - storing the probability table in each item
> 
> Feel free to modify the pad if you have other ideas, this is a first 
> draft done today and I won't be offended if it is discarded ;-)

What about a new concept called a "weight set" that represents an 
alternative set of weights for the entire map (or perhaps a subset of it, 
like a particular hierarchy of interest).  We allow do_rule to be called 
with no weight_set specified, in which case it uses the 
legacy/default/canonical weights.  Or if an alternative weight set is 
specified, those weights are used instead.

I think we have a couple interesting options for the representation:

1) It could be as simple as

      vector<int> bucket_weights, item_weights;

which would lose the current (mis?)feature where the weigth for an item 
may be different in different buckets.  Or,

2) it could mirror the bucket item_weights (let's call it vector<int> 
item_weights even though it's really a C array).  Something like

      vector<int,vector<int>> bucket_item_weights;

where it's indexed first by bucket id, then the position in the bucket.

I guess #2 is most general and mirrors what we have.  That would give us 
something like

struct weight_set {
  vector<int,vector<int>> bucket_item_weights;
};

for a simple replacement weight. But we actually want 
per-position weights, so instead we can do

struct weight_set {
  vector<int,vector<vector<int>>> bucket_item_position_weights;
};

where it's bucket id, item position, current position.  In reality, 
for each bucket, we probably want a flat 2-d array, something like

struct weight_set {
  struct bucket_weights {
    unt32_t num_positions, num_items;
    uint32_t *data;
  };
  vector<int,bucket_weights> bucket_weights;
};

or whatever.

The last thing is that the number of per-position weights we need is 
a property of the crush rule we're using, not the bucket itself.  So we 
should probably calculate it out for however many we think we need, and if 
we are doing a placement past that point, keep using the last weight.  
That means the degenerate case of just 1 position means we'll use it for 
all positions, which is what we'd want in the simple case anyway.

The last thing I think we should do while we're making this change is 
also let you specify an alternative id for the bucket when doing the hash.  
This is currently an annoying property of crush where if the bucket id 
changes all data shuffles.  But we could add an int32_t id to the 
bucket_weights above so that you could have a new weight set using any id 
you want.. that'll be useful for lots of stuff I suspect.

sage




> 
> Cheers
> 
> [1] http://pad.ceph.com/p/crush-multiweight
> [2] http://tracker.ceph.com/projects/ceph/wiki/CDM_05-APR-2017
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-232886874-1490656601=:10776--
