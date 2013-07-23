From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] rgw bucket index
Date: Mon, 22 Jul 2013 23:50:13 -0700
Message-ID: <CAC-hyiGmabPu2ErhkDgfy1eGjuz3CbiR=yCJCx5m=+psLOV-dw@mail.gmail.com>
References: <CAMNMNTwVrs29yZnCi8_nXJt8PyJ4C2Bx5Pv4m4rLdWj7GJx1VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:58970 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3GWGuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jul 2013 02:50:15 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so5906877lbh.38
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jul 2013 23:50:13 -0700 (PDT)
In-Reply-To: <CAMNMNTwVrs29yZnCi8_nXJt8PyJ4C2Bx5Pv4m4rLdWj7GJx1VQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dominik Mostowiec <dominikmostowiec@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Sun, Jul 21, 2013 at 12:48 AM, Dominik Mostowiec
<dominikmostowiec@gmail.com> wrote:
> Hi,
> Rgw bucket index is in one file (one osd performance issues).
> Is there on roudmap sharding or other change to increase performance?
>
>

Excellent question. Note that the upcoming Dupling release will have
the ability to separate the bucket index from the objects' data, so it
will be possible to put the index on faster storage. We have discussed
other changes the past, and it's certainly on our mind. I think that
might be a good candidate for a blueprint for the upcoming Emperor
release, if anyone is willing to pick that up. In any case, it can be
a good topic to discuss in the upcoming CDS.

As I see it, there are a few directions in which we can tackle the issue. E.g.,

1. Blind buckets

In certain environment we might not need the bucket index at all.
Extra performance may be gained by losing the ability to list bucket's
objects (at least in the way it's done right now, having sorted
objects, etc.)

2. Bucket sharding

Keep bucket index over multiple objects. A trivial implementation will
just set a constant number of shards per index. A (much much) more
complex implementation will adjust the number of shards on the fly
according to the number of objects it holds.

3. Relaxed consistency

Not my favorite, but certain write operations may benefit from
relaxing the strict read-after-write, read-after-rewrite consistency
that we have.


Again, if anyone wants to have a go at one of the above, we'll be
happy to discuss and give guidance. Note that the first issue is
probably the easiest. whereas the second (the dynamic version) is the
hardest. I don't really consider the third option as a real solution.

Yehuda
