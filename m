From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Re: Questions about bucket algorithm and bucket choose
Date: Sat, 21 Apr 2012 16:50:36 +0800
Message-ID: <CALwGbPJ1C4uL=VZ455WBV=JkqhGarBQcajRzWmuXtTLZUa3byQ@mail.gmail.com>
References: <CALwGbPKqXyubH1O-cBoYm-LaJ86LR3QOzzd=mYyL8HESx1+13g@mail.gmail.com>
	<Pine.LNX.4.64.1204161425180.31853@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63755 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2DUIug convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Apr 2012 04:50:36 -0400
Received: by iagz16 with SMTP id z16so14381545iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Apr 2012 01:50:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204161425180.31853@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Oh, perhaps I find the reason for the bad behavior.

According to Jenkins hash algorithm, any number of lower bits of the
hash result is uniformly distributed, but the modular arithmetic can
destroy the uniform distribution, unless the size of the bucket is the
power of 2!

Am I right?

On Tue, Apr 17, 2012 at 5:29 AM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 15 Apr 2012, =A0wrote:
>> Hi everyone.
>>
>> One question is about performance of bucket algorithms, it seems tha=
t
>> on every aspect, straw bucket is at least not worse than list bucket=
=2E
>> So does it mean we shall always use straw bucket instead of list
>> bucket?
>
> Well, list on average will calculate a hash for 1/2 of the items, whi=
le
> straw always does every item. =A0That said, we use straw by default f=
or all
> buckets. =A0As long as there is _some_ hierarchy, the individual buck=
ets
> don't get too big, and CRUSH is so cheap anyway that it doesn't reall=
y
> matter... especially when compared to the cost of moving data due to =
a
> less-than-optimal remapping.
>
>> I was browsing branch tree of ceph to trace back earlier versions of
>> the implementation. I noticed that crush_uniform_bucket_choose has
>> been significantly changed. I read the comment which said the origin=
al
>> method (seems to be described in the thesis) is not random enough an=
d
>> has some bad behavior, but I don't know what kind of bad behavior is
>> that. For what reason a random permutation is a better choice?
>
> If I remember correctly, the problem was that it would favor certain =
nodes
> when there were too many or certain patterns of failures within the
> bucket (I don't remember the details). =A0The original algorithmw as
> supposed to give you a random permutation too, but it didn't always d=
o
> that.
>
> I think that code is also used as a fallback if the sampling fails to
> return a good value after too many tries.
>
> This will be one of the things we look at in a month or two when we
> take a careful look at CRUSH.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
