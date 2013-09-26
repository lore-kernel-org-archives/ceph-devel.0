From: Gregory Farnum <greg@inktank.com>
Subject: Re: bloom filter thoughts
Date: Thu, 26 Sep 2013 09:06:10 -0700
Message-ID: <CAPYLRziJpzq3W+vAC-A30xwO7KtPuU10P+v96JTi2hYugxsKeg@mail.gmail.com>
References: <alpine.DEB.2.00.1309251629090.12717@cobra.newdream.net>
	<524434A7.9020001@inktank.com>
	<alpine.DEB.2.00.1309260848390.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:54474 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3IZQGL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 12:06:11 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so1422956wes.27
        for <ceph-devel@vger.kernel.org>; Thu, 26 Sep 2013 09:06:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309260848390.12714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Sep 26, 2013 at 8:52 AM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 26 Sep 2013, Mark Nelson wrote:
>> On 09/25/2013 07:34 PM, Sage Weil wrote:
>> > I spent some time on the plane playing with bloom filters.  We're =
looking
>> > at using these on the OSD to (more) efficiently keep track of whic=
h
>> > objects have (probably) been touched in recent history.  This can =
then be
>> > used by the caching and tiering code to identify objects that have
>> > (definitely) not been touched that should be demoted or purged fro=
m a
>> > given tier.
>>
>> You know this is making me want to work on my photon mapping engine =
again
>> instead of running benchmarks for Bryan. :P  Anyway, this seems like=
 a great
>> use case.  Are there any other places we want to fast intersection t=
ests where
>> we could use these?  k-nearest-neighbor searches would be tons of fu=
n to do
>> too if we only had a use case!
>>
>> >
>> > The false positive probility (in our case, probability we'll think=
 an
>> > object has been touched when it actually hasn't) is dependent on s=
ize of
>> > the bloom filter and the number of insertions.
>> >
>> > When you create the bloom_filter, you tell it how many insertions =
you
>> > expect to do and what fpp you want and it sizes itself.  For ~1% f=
pp, it
>> > costs just over 1 byte per insertion.
>>
>> It's been a long time since I looked at bloom filters, but isn't thi=
s also
>> affected by the number of hash functions used?  Are we going to try =
to have it
>> auto-select the number?
>
> The bloom_filter class hides this.  You feed it the desired fpp and
> insertion count and it chooses the number of hashes (actually, 1 hash=
 but
> N salts) and table size.  Unit tests verify the actual fpp very close=
ly
> matches the target.
>
>>
>> >
>> > wip-bloom has some cleanups and unit tests that test the false pos=
itive
>> > behavior.
>> >
>> > A few issues/notes:
>> >
>> > - If we build a sequence of filters covering intervals of time, th=
is let's
>> > us estimate "atime".  However, if we have N filters of 1/Nth the s=
ize, our
>> > total_ffp =3D N * fpp, so each bin's bloom needs to be 1/Nth as bi=
g with
>> > 1/Nth the desired fpp.  In my simple test, going from 1 to 16 bins=
 moves
>> > the bloom_filter size from 20 KB to 32 KB (that's 16k insertions a=
nd
>> > target_ffp of .01).
>> >
>> > - In the OSD, we won't necessarily know how many insertions a bin =
will
>> > have.  The user inputs will/should be something like:
>> >   - target fpp
>> >   - time interval we want to record/estimate over (say, 1 day)
>> > and we'll need to translate that into a particular sized bloom.  W=
e
>> > probably need to estimate that based on recent pg workload/activit=
y.  If
>> > we have a filter that "fills up" quickly, the next one will be big=
ger.  If
>> > we have an unfull one after some period of time, we can compress/f=
old it
>> > down into a smaller filter (a convenient trick) and start the next=
 smaller
>> > one.
>>
>> So basically we try to keep a running log of the PG activity so we c=
an guess
>> as to how big future filters should be, and if our guess is short we=
 move on
>> and make the next one bigger, but if we overshot we compress it into=
 a smaller
>> filter and make the next one smaller?  I think this is exactly what =
you said
>> but I want to make sure I got it. :)
>
> Exactly.
>
>> >
>> > I suggest the pg_pool_t get:
>> >
>> >   uint8_t bloom_fpp_pow;  //< desired false positive rate =3D=3D
>> > 2^(-bloom_fpp_pow)
>> >   uint16_t bloom_period;  //< period for that false positive rate =
(seconds)
>> >   uint16_t bloom_bins;    //< the approx "resolution" we want
>> >   uint16_t bloom_max;     //< how many periods we retain history f=
or
>> >
>> > which would make the OSD try to create a new filter roughly every
>> > (period/bins) seconds with some simple estimation.
>> >
>> > Other thoughts on the OSD side stuff:
>> >
>> > - The past history of filters may be large.  I suggest we stick th=
em in an
>> > omap object that lives with the PG and is recovered/backfilled but=
 that
>> > needs to happen in a way that is out of band wrt to other objects.=
  It
>> > should get scrubbed.
>>
>> Any guesses as to how large this will get yet?  It's too early in th=
e morning
>> for me to do math...
>
> Greg did a quick calc yesterday, I forget.  It was enough that it mig=
ht
> fit in RAM for a spinning disk for 1-2 days of history, but only
> marginally.

Well, depends on the sort of windows and overlaps we want, but:
120 ops/s * 3600 s/hour * 1 byte/op =3D ~422KB/hour, or <10MB/day.
(where we here assume each op touches a different object, which is unli=
kely)

So it should actually fit in RAM just fine as long as we make it
durable =97 but we need to handle all-SSD setups as well, and those can
get much larger. What's more interesting here is that we can feasibly
store a list of actual, touched objects for only 4 times as much data
(4 byte hashes versus 1 byte/insert in the bloom filter) for those who
require it.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
