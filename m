From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Radosgw - bucket index
Date: Fri, 16 May 2014 09:42:44 -0700
Message-ID: <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
	<BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl>
	<alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:60545 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaEPQmp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 12:42:45 -0400
Received: by mail-vc0-f171.google.com with SMTP id lc6so6469361vcb.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 May 2014 09:42:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Guang <yguang11@outlook.com>, haomaiwang@gmail.com, Ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 16, 2014 at 6:09 AM, Sage Weil <sage@inktank.com> wrote:
> Hi Guang,
>
> [I think the problem is that your email is HTML formatted, and vger
> silently drops those.  Make sure your mailer is set to plain text mode.]
>
> On Fri, 16 May 2014, Guang wrote:
>
>>       * *Key/value OSD backend* (experimental): An alternative storage
>>       backend
>>        for Ceph OSD processes that puts all data in a key/value
>>       database like
>>        leveldb.  This provides better performance for workloads
>>       dominated by
>>        key/value operations (like radosgw bucket indices).
>>
>> Hi Yehuda and Haomai,I managed to set up a K/V store backend and played
>> around with it, as Sage mentioned in the release note, I thought K/V store
>> could be the solution for radosgw?s bucket indexing feature which currently
>> has scaling problems [1], however, after playing around with K/V store and
>> understanding the requirement for bucket indexing, I think at least for now
>> there is still gap to fix the bucket indexing by leveraging the K/V store.
>>
>> In my opinion, one requirement (API) to implement bucket indexing is to
>> support ordered scan (prefix filter), which is not part of the API of rados,
>> and as K/V store does not extend the rados API (it is not supposed to) but
>> only  change the underlying object store strategy. It is not likely to help
>> for the bucket indexing, except that we use the original way using omap to
>> store bucket indexing and each bucket corresponds to one object.
>
> The rados omap API does allow a prefix filter, although it's somewhat
> implicit:
>
>     /**
>      * omap_get_keys: keys from the object omap
>      *
>      * Get up to max_return keys beginning after start_after
>      *
>      * @param start_after [in] list keys starting after start_after
>      * @parem max_return [in] list no more than max_return keys
>      * @param out_keys [out] place returned values in out_keys on completion
>      * @param prval [out] place error code in prval upon completion
>      */
>     void omap_get_keys(const std::string &start_after,
>                        uint64_t max_return,
>                        std::set<std::string> *out_keys,
>                        int *prval);
>
> Since all keys are sorted alphanumerically, you simply have to set
> start_after == your prefix, and start ignoring the results once you get a
> key that does not contain your prefix.  This could be improved by having
> an explicit prefix argument that does this server-side, but for now at you
> can get the right data (plus a bit a extra at the end).
>
> Is that what you mean by prefix scan, or are you referring to the ability
> to scan for rados objects that begin with a prefix?  If it's the latter,
> you are right: objects are hashed across nodes and there is no sorted
> object name index to allow prefix filtering.  There is a list_objects
> filter option, but it is still O(objects in the pool).
>
>> Did I miss anything obvious here?
>>
>> We are very interested in the effort to improve the scalability of bucket
>> index [1] as the blueprint mentioned, here is my thoughts on top of this:
>>  1. It would be nice we can refactor the interface so that it is easy to
>> switch to a different underlying storage system for bucket indexing, for
>> example, DynamoDB seems like being used for S3?s implementation [2], and SWIFT
>> uses sqllite [1] and has a flat namespace for listing purpose (with prefix
>> and delimiter).
>
> radosgw is using the omap key/value API for objects, which is more or less
> equivalent to what swift is doing with sqlite.  This data passes straight
> into leveldb on the backend (or whatever other backend you are using).
> Using something like rocksdb in its place is pretty simple and ther are
> unmerged patches to do that; the user would just need to adjust their
> crush map so that the rgw index pool is mapped to a different set of OSDs
> with the better k/v backend.
>
>>  2. As mentioned in the blueprint, if we go with the approach to do sharding
>> for the bucket index object, what is the design choice? Are we going to
>> maintain a B- tree structure get all keys sorted and sharidng on demand,
>> like having a background thread do the sharding when it reaches a certain
>> threshold?
>
> I don't know... I'm sure Yehuda has a more well-formed opinion on this.  I
> suspect something simpler than a B tree (like a single-level hash-based
> fan out) would be sufficient, although you'd pay a bit of a price for
> object enumeration.
>

My more well-formed opinion is that we need to come up with a good
design. It needs to be flexible enough to be able to grow (and maybe
shrink), and I assume there would be some kind of background operation
that will enable that. I also believe that making it hash based is the
way to go. It looks like that the more complicated issue is here is
how to handle the transition in which we shard buckets.

Yehuda
