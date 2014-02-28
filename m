From: Gregory Farnum <greg@inktank.com>
Subject: Re: cache pool user interfaces
Date: Fri, 28 Feb 2014 13:39:14 -0800
Message-ID: <CAPYLRzjkghBaEXzFbiqUqZt4_ABeM3Yt_gnZOgpcoCedeRjgBg@mail.gmail.com>
References: <CAPYLRziGSJAjf3CvvOAy8euAr-0vCzM3GX8K6D_z214w-Nu4aw@mail.gmail.com>
	<alpine.DEB.2.00.1402280711240.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:36595 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaB1Vqj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 16:46:39 -0500
Received: by mail-qa0-f47.google.com with SMTP id w5so1274374qac.34
        for <ceph-devel@vger.kernel.org>; Fri, 28 Feb 2014 13:46:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402280711240.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 28, 2014 at 7:21 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 26 Feb 2014, Gregory Farnum wrote:
>> We/you/somebody need(s) to sit down and decide on what kind of
>> interface we want to actually expose to users for working with caching
>> pools. What we have right now is very flexible, but it's hard to test
>> all the combinations and it's easy for users to get themselves into
>> trouble.
>> I know we've in the past discussed making all the configuration
>> options into a single "create cache pool" command that accepts
>> whatever we're interested in, and I think that's the model we want to
>> go towards right now. But we're running out of time to make that
>> change given the release deadline and the documentation that needs to
>> be generated (eg http://tracker.ceph.com/issues/7547).
>
> Right now the sequence is:
>
>        ceph osd pool create cache $num_pgs
>        ceph osd tier add base cache
>        ceph osd tier cache-mode cache writeback
>        ceph osd tier set-overlay base cache
>        ceph osd pool set cache hit_set_type bloom
>        ceph osd pool set cache hit_set_count 8
>        ceph osd pool set cache hit_set_period 60
>        ceph osd pool set cache target_max_objects 5000

So we set our size limits based on object counts rather than data
size? I didn't think that was how we discussed eviction working.

> I mostly like the flexibility this presents and don't forsee any major
> problems, but nevertheless I agree that a friendly interface is safer to
> advertise and, well, friendlier.  How about:
>
>        ceph osd pool create cache $num_pgs
>
> (I think think this should be a separate step since users will want/need
> to adjust the crush rule and so forth to put this on the right devices
> *before* it gets set as an overlay and gets hammered by the existing
> pool's workload.)  Then
>
>        ceph osd tier add-cache base cache
>
> which would do the other 3 tier steps and set some sane hit_set defaults.
> What do you think?

I'd really like to be able to get it down to one step so we don't need
to worry about users putting used pools in as a cache pool. Perhaps a
create-cache step and an enable-cache step?

>
> Separately:
>
> 1- I'm not sure what the default target size should be set to; maybe a
> default of 10000 objects or something?  I think it should be *something*.

Just require users to specify it to do the initial creation. Without
our having something like the real df you discuss below we can't do
anything sensible here.
Unfortunately, here in particular users are going to want to talk in
terms of data size rather than object count (and the same for us if
we're deriving it from a df like below).

> 2- I think we need to bite the bullet and make a 'ceph df' function that
> figures out how much space is available on a per-pool basis.  It would:
>  - figure out which osds are toched by the rules for each pool, and
>  - sum up only those osds' usages
>  - divide by the replication factor or EC storage overhead
> If there target_max_* values aren't set for the pool, this could be used
> instead, by periodically filling in a pg_pool_t approximate_capacity type
> field.  Of course, for multiple pools this is double counting free space,
> but for the purposes of the cache agent it is still perfectly usable as a
> target for controlling when the agent kicks into gear.  It would also be
> very nice for users.  (Hmm, perhaps I should write this up in a
> blueprint!)

Yeah, it's a little late for this, which means we can't rely on it for
our initial users. :( I'm also not certain how we can message this --
if we tell users of a default deployment that they have 300 TB in each
of 3 pools and then they do writes to one pool and see it go down in
all three, I think they'll like that less than if we have 1 total
storage value -- at least that prevents them from trying to map a
per-pool value out of it because there aren't enough data points!
-Greg
