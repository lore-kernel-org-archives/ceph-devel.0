From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rgw quota
Date: Mon, 23 Sep 2013 16:47:11 -0700
Message-ID: <CABBk=J9cZTkjiQzf663zUpgoAidBJns87CMcOB78VfVzeavErw@mail.gmail.com>
References: <CABBk=J_XYE8Pz7ZDLATVaw9atniZjZmJgv2FiEMmN3xZEp6RBQ@mail.gmail.com>
	<alpine.DEB.2.00.1309231602470.7394@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:50377 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3IWXrM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 19:47:12 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so2893803vbg.31
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 16:47:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309231602470.7394@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 4:11 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 23 Sep 2013, Yehuda Sadeh wrote:
>> Real short description of rgw quota feature implementation as was discussed:
>>
>> 1. Implement per-bucket quota
>>
>>  - we already have a per-bucket total info
>>  - cache per-bucket info in rgw
>>  - define per-bucket max (can set default per system, per user, per bucket)
>>  - define a threshold for which operations are synchronous (e.g., 90%)
>>  - if bucket crossed soft threshold then before each write, update
>> internal cache, check that not crossed hard limit
>>  - update internal cache with approximated bucket info after write
>>  - if not crossed soft threshold then use a ttl to determine when to
>> re-read the bucket info
>>      - should reuse data log mechanism for that
>
> Sounds good.  What would the TTL be?

configurable, should be in the order of minutes.
>
>> 2. per-user quota
>>
>>  - create a new user objclass
>>  - move user bucket-list omap operations to objclass
>>  - add a new namespace to user info omap
>
> add attr version to indicate whether to do a format-upgrade on the
> object content?

Not really required, we can do that in the same way we introduced
extra data to the bucket index omap. We define a single char prefix
for new entries from the set of chars that were not allowed to be used
up until now (the buckets names can only contain specific set of
chars). E.g., prefixing all new data with 0x80.

>
>>  - add user objclass functions:
>>     - set buckets info
>>     - get total
>>     - update per-bucket info
>>  - per-user ttl should determine when to re-examine all user buckets.
>> This should only be used if user have had data modification since last
>> time all buckets were checked.
>
> is there an existing way to know whehter there has been a modification?
>

Maybe we can read the bucket index mtime for that. In any case we
should have some versioning within the bucket index, though I'm not
sure it's readily exported.

> i was thinking:
>
>  - objclass function set_refresh_stamp(now + some interval) to indicate
> that we may modify a particular bucket that is covered by a quota

Not sure about the 'we may modify a particular bucket' here. As we're
now looking at the per-user overall info, so there's no sense for
setting that on a per-bucket. What this should indicate is that the
bucket info is fresh enough that there's really no need to re-examine
it.


>  - if the refresh stamp has expired, an(other) rgw should refresh the
> stats for that bucket in the user info omap

There's no such async mechanism that'll trigger this operation. This
is only going to be triggered on ad-hoc basis when new write requests
arrive.

>    - if there have been no changes since the last refresh, don't reset of
> the refresh in the future but zero it out instead (i.e., mark the bucket
> idle)

Well, we actually look at it probably when we're just about to write
new data into the bucket. Does setting the bucket idle make sense?
Also, is the added idle state really worth the added complexity?
I was thinking of having a per-user last modified field within the
user info. If that's behind the last complete scan timestamp then we
wouldn't need to do a complete re-scan.

>
> ?
>
>>  - cache per-user total in gateway
>>  - if crossed soft threshold switch to sync mode (like in the bucket case)
>>  - touched buckets should be updated periodically (in the user buckets list)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
