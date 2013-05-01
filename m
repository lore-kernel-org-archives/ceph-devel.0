From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/4] rbd: get rid of the snapshot list
Date: Tue, 30 Apr 2013 20:12:39 -0500
Message-ID: <51806C07.60007@inktank.com>
References: <517FBBF0.9020904@inktank.com> <5180688F.1020703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:64311 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934111Ab3EABMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 21:12:43 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so920444veb.16
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 18:12:41 -0700 (PDT)
In-Reply-To: <5180688F.1020703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 07:57 PM, Josh Durgin wrote:
> On 04/30/2013 05:41 AM, Alex Elder wrote:
>> An rbd device structure maintains a list of snapshot
>> structures whose purpose is to cache the name, size,
>> and features associated with a snapshot id.  The main
>> reason it was needed was related to the presence of
>> Linux device information for snapshots, which we
>> no longer have.  We can look up the name, etc. "on
>> the fly" about as easily as we can using the list,
>> and getting rid of this list means we can eliminate
>> a substantial bit of code.
>>
>> The final patch in this series gets rid of the snapshot
>> list and the rbd_snap structure.  The first three put
>> in place replacement functionality that doesn't require
>> the list.
>>
>>                     -Alex
>>
>> [PATCH 1/4] rbd: look up snapshot name in names buffer
>> [PATCH 2/4] rbd: use snap_id not index to look up snap info
>> [PATCH 3/4] rbd: define rbd_snap_size() and rbd_snap_features()
>> [PATCH 4/4] rbd: kill off the snapshot list
> 
> These patches look good, but bring up two things that should be
> addressed in later patches.
> 
> 1) inefficient snapshot id lookup for format 2 images
> 
> We're sending a single request for each snapshot id in the snapshot
> context. There could potentially be a very large number of snapshots
> there, hundreds or even thousands, which would slow down mapping
> a snapshot quite a bit. Aggregating this into a request with multiple
> ops so we get, perhaps, up to 500 snapshot names at a time would
> make this a lot faster.

That's a good idea.  And although the messenger is prepared
to handle that, the osd client and rbd still need some work
to really be able to handle generalized many-op requests.
I can see it on the horizon, but right now we still
really assume at most 2 ops, and only one of them (the
first) is a read.  Format 1 of course does the whole thing
in one shot.

The second thing I was going to say is that this change
actually makes it *better* than it was.  Previously
we would fetch all this stuff for every snapshot on
every refresh.  Now (for format 2 anyway) we get only
the snapshot context, and only when we're mapping do
we look up more detailed snapshot info.

On that, the only thing inefficient is looking up the
snapshot id given its name.  It is so inefficient it
might be worth offering an op that does that for us,
because as it is we have to do a sequential search
to find out a snapshot's name.  (Maybe it's not that
important to track the name for parent snapshots but
users might be interested.)

> 2) mapped snapshots never clear the EXISTS flag
> 
> Now that we're not keeping a snapshot list, we don't check whether
> the snapshot we mapped continues to exist. Since we know the snapshot
> id, we just need to see if it's still present in the updated snapshot
> context.

That should be pretty easy to fix.  I forgot about that.
I just lopped out that whole function and I guess I
missed that.

> These aren't critical though, so this patch series looks good as is:
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

