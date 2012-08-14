From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Pre-creating pools for radosgw
Date: Tue, 14 Aug 2012 10:54:00 -0700
Message-ID: <CAC-hyiFGeUDEDcR3VnCAFveHqU=G31G49pcJH6BqTtfx4kLQLA@mail.gmail.com>
References: <CAMmJxt+JsGEU_oxJSKv-=4ofVWGfHyU4rNnPMavjmJj+SqCLag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42977 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab2HNRyC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 13:54:02 -0400
Received: by bkwj10 with SMTP id j10so237911bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 10:54:00 -0700 (PDT)
In-Reply-To: <CAMmJxt+JsGEU_oxJSKv-=4ofVWGfHyU4rNnPMavjmJj+SqCLag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 14, 2012 at 10:29 AM, John Axel Eriksson <john@insane.se> wrote:
> Hi,
>
> Since we setup a test cluster, only for use with radosgw, we've
> noticed that pg_num is set to 8 for all the pools rgw uses. Our
> test-cluster only has two OSDs but when we go live we plan on having a
> few more of them. We anticipate going to maybe 10 OSDs in 6 months
> time.
> There's been talk on this list about this before and there have been
> some solutions... I'd like to properly set it up before we go live
> though and I've come to understand that it's not something you easily
> change after data has been stored to the cluster (through rgw). I've

Right.

> checked the existing pools and as I said, the rgw ones are all set to
> 8 pgs. I assume ALL pools starting with "." are created by rgw even
> though not all of them are called .rgw.<something> (such as .log,
> .intent-log, .users.email etc). Anyway, some of them could probably
> stay at 8 pgs I guess. I did a pretty quick calculation and came up
> with something like this:
>
> .rgw.buckets = 1024
> .log = 84
> .rgw: 52
> .rgw.control: 8 # eg. default value
> .users.uid: 32
> .users.email: 32
> .users: 8 # eg. default value
> .usage: 8 # eg. default value
> .intent-log: 32

As a rule of thumb we say that the number of pgs should be a multiple
(e.g., x10) of the number of osds you're expecting to have. However,
you should be careful of not having a too large number at this point.
Also note that a workaround for not having pg splitting would be to
copy the pool's data to another pool and then rename it (this requires
downtime). This can be done for most of the pools, but not to the
.rgw.buckets pool since (currently) rgw uses some internal pg state
info in order to maintain the bucket index. So I'd say that for most
of the pools you can have any number between 64 to 128, and for the
.rgw.buckets 1024 would be a good number.

>
> this totals to 1280. Afaik a power of two is slightly more performant.
> The other pools - data, metadata and rbd won't be used by us - they're
> all set to 256 by default. Adding that we end up with 2048 pools.
> Would this be a reasonable value? Also can we perhaps delete the data,
> metadata and rbd pools if we're only using rgw?

Yeah, you don't need these

>
> We plan on having 2 copies (the default I think) of everything in the
> cluster but may go to 3 - not sure.
>
> How would I pre-create the pools by the way? I assume you would go
> about it like this:
>
> rados mkpool .rgw.buckets
> ceph osd pool set .rgw.buckets pg_num 1024

ceph osd pool create .rgw.buckets 1024 1024

>
> etc
>
> All of that BEFORE ever starting/using RadosGW. I wouldn't have to
> create the pools with default values I guess. Am I correct in my
> assumptions?

Yes

>
> Also what do these mean (from docs):
>
> pg_num: See above.
> pgp_num: See above.
> lpg_num: The number of local PGs.
> lpgp_num: The number used for placing the local PGs.
>
> Should I set any of these?

The first two (as in my example), the last two are obsolete.

>
>
> I assume changing the number of replicas would be done like this:
>
> ceph osd pool set .rgw.buckets size 3 # for 3 replicas

yes

>
> Above can be done after data has been stored through rgw, right?
>
> I also assume that the actual data stored via radosgw is stored in
> .rgw.buckets. I know you're planning on adding pg-splitting but I'd
> like to do this well before that is released.

Yes, by default. Though you can manage the placement by using the
radosgw-admin pool add/rm command. Not that it only affects placement
to newly created buckets.


Yehuda
