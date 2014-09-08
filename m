From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph data locality
Date: Mon, 8 Sep 2014 12:51:06 -0700
Message-ID: <CAPYLRzgUfXDOF3g4pHVT_+=smeCr1iUY=_WeGYSKqNngZSQPgQ@mail.gmail.com>
References: <D02D591B.57E%johnugeo@cisco.com>
	<D02D5C36.583%johnugeo@cisco.com>
	<D02D5FAE.58B%johnugeo@cisco.com>
	<CANP1eJH97O+B_rGYKbLJvpu_hLvfUj+vs-UrrBrQuTwEjxfiOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:43355 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbaIHTvH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Sep 2014 15:51:07 -0400
Received: by mail-qc0-f170.google.com with SMTP id r5so16630168qcx.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Sep 2014 12:51:07 -0700 (PDT)
In-Reply-To: <CANP1eJH97O+B_rGYKbLJvpu_hLvfUj+vs-UrrBrQuTwEjxfiOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 4, 2014 at 12:16 AM, Johnu George (johnugeo)
<johnugeo@cisco.com> wrote:
> Hi All,
>         I was reading more on Hadoop over ceph. I heard from Noah tha=
t
> tuning of Hadoop on Ceph is going on. I am just curious to know if th=
ere
> is any reason to keep default object size as 64MB. Is it because of t=
he
> fact that it becomes difficult to encode
>  getBlockLocations if blocks are divided into objects and to choose t=
he
> best location for tasks if no nodes in the system has a complete bloc=
k.?

We used 64MB because it's the HDFS default and in some *very* stupid
tests it seemed to be about the fastest. You could certainly make it
smaller if you wanted, and it would probably work to multiply it by
2-4x, but then you're using bigger objects than most people do.

> I see that Ceph doesn=C2=B9t place objects considering the client loc=
ation or
> distance between client and the osds where data is stored.(data-local=
ity)
> While, data locality is the key idea for HDFS block placement and
> retrieval for maximum throughput. So, how does ceph plan to perform b=
etter
> than HDFS as ceph relies on random placement
>  using hashing unlike HDFS block placement? Can someone also point ou=
t
> some performance results comparing ceph random placements vs hdfs loc=
ality
> aware placement?

I don't think we have any serious performance results; there hasn't
been enough focus on productizing it for that kind of work.
Anecdotally I've seen people on social media claim that it's as fast
or even many times faster than HDFS (I suspect if it's many times
faster they had a misconfiguration somewhere in HDFS, though!).
In any case, Ceph has two plans for being faster than HDFS:
1) big users indicate that always writing locally is often a mistake
and it tends to overfill certain nodes within your cluster. Plus,
networks are much faster now so it doesn't cost as much to write over
it, and Ceph *does* export locations so the follow-up jobs can be
scheduled appropriately.

>
> Also, Sage wrote about a way to specify a node to be primary for hado=
op
> like environments.
> (http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/1548 ) =
Is
> this through primary affinity configuration?

That mechanism ("preferred" PGs) is dead. Primary affinity is a
completely different thing.


On Thu, Sep 4, 2014 at 8:59 AM, Milosz Tanski <milosz@adfin.com> wrote:
> QFS unlike Ceph places the erasure coding logic inside of the client
> so it's not a apples-to-apples comparison. but I think you get my
> point, and it would be possible to implement a rich Ceph
> (filesystem/hadoop) client like this as well.
>
> In summary, if Hadoop on Ceph is a major priority I think it would be
> best to "borrow" the good ideas for QFS and implement them in Hadoop
> Ceph filesystem and Ceph it self (letting a smart client get chunks
> directly, write chunks directly). I don't doubt that it's a lot of
> work but the results might be worth it in in terms of performance you
> get for the cost.

Unfortunately implementing CephFS on top of RADOS' EC pools is going
to be a major project which we haven't done anything to scope out yet,
so it's going to be a while before that's really an option. But it is
a "real" filesystem, so we still have that going for us. ;)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
