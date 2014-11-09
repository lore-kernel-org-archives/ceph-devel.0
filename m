From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: ObjectStore collections
Date: Sun, 9 Nov 2014 10:20:57 +0100
Message-ID: <CACJqLyYEL5-DfUkNFQeOdr6eseD8eYqZ=R+55L5ybNNWyf4yxA@mail.gmail.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B30119DCC8@SHSMSX101.ccr.corp.intel.com>
	<CACJqLyaL4COg6CvkNF1jm_uZSrN96mP7SmvkO0FaZRZEN_r9vQ@mail.gmail.com>
	<alpine.DEB.2.00.1411081042010.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41114 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaKIJU6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Nov 2014 04:20:58 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so6662443wgh.34
        for <ceph-devel@vger.kernel.org>; Sun, 09 Nov 2014 01:20:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411081042010.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Xue, Chendi" <chendi.xue@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Nov 9, 2014 at 5:59 AM, Sage Weil <sage@newdream.net> wrote:
> On Sat, 8 Nov 2014, Haomai Wang wrote:
>> As for OOM, I think the root cause is the mistake commit above too.
>> Because "meta" collection will be updated each transaction and
>> StripObjectHeader::buffers will be always kept in memory because of
>> the strategy of cache. So this object's buffers will keep in
>> increasing all the time. So I think if we avoid cache "meta"
>> collection's object will just be fine. Although we don't observe OOM
>> for previous release except this mistake commit, I prefer to add codes
>> to discard "buffers" each submit transaction time to avoid potential
>> unpredicted memory growing.
>>
>> Do you have a more clear impl about it? I'm just thinking a better way
>> to solve the performance bottleneck for "meta" collections.
>
> I would really like to see if we can eliminate collections from the API
> entirely.  Or, perhaps more importantly, if that would be helpful.  For
> the most part, hobject_t's already sort themselves into collections based
> on the hash.  The exceptions are:
>
> - The 'meta' collection.  Mostly this includes the pg logs and pg info
> objects (which are per-pg and would otherwise need no locking) and the
> osdmap objects.
>
> - collection_move and collection_move_rename.  I think if we move
> everything to collection_move_rename and use temporary objects with
> unique names for everything (I think in-progress recovery objects is
> the main user of collection_move) then this really just turns into a
> rename operation.
>
> - object listing is currently in terms of pg, but could just as easily
> specify a hash range.
>
> - collection attributes can be moved to the pginfo objects.
>
> It sounds like the problem in KeyValueStore is that the pglog/pginfo
> objects are written by transactions in all PGs but the per-collection
> index/cache structures weren't being locked.  If we can find a way to fit
> these into the sorted hash in the right position that is conceptually
> simpler.  But I'm not sure if that simplicity actually helps with the
> implementation, where the data structure locking is the important part.
> Perhaps we need to keep a collection concept simply for that purpose and
> the only real problem is 'meta'?

Original, KeyvalueStore is true by just avoiding cache "meta"
collection for concurrent purpose.

I'm just thinking about is there a way to make "meta" collection ops
more parallelization. BTW, FileStore also can get the benefits because
of the same reason.

>
> sage



-- 
Best Regards,

Wheat
