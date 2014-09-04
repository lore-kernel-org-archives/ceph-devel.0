From: Milosz Tanski <milosz@adfin.com>
Subject: Re: ceph data locality
Date: Thu, 4 Sep 2014 11:59:09 -0400
Message-ID: <CANP1eJH97O+B_rGYKbLJvpu_hLvfUj+vs-UrrBrQuTwEjxfiOQ@mail.gmail.com>
References: <D02D591B.57E%johnugeo@cisco.com>
	<D02D5C36.583%johnugeo@cisco.com>
	<D02D5FAE.58B%johnugeo@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:52903 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaIDP7L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 11:59:11 -0400
Received: by mail-la0-f44.google.com with SMTP id hz20so12350361lab.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Sep 2014 08:59:09 -0700 (PDT)
In-Reply-To: <D02D5FAE.58B%johnugeo@cisco.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Johnu,

Keep in mind HDFS was more less designed and thus optimized for MR
jobs versus general filesystem use. It was also optimized for a case
of hardware in the past, eg. slower networks then today (1gigE or
less). Theres's lots of little hacks in hadoop to optimize for that,
for example local mmaped reads in hdfs client). It will tough to beat
MR on HDFS in that scenario and hadoop. If hadoop is a smaller piece
in a large data-pipeline (that includes non-hadoop, regular fs work)
then it makes more sense.

Now if you're talking about the hardware and network of tomorrow
(10gigE or 40gigE) then locality of placement starts to matter less.
=46or example the Mellanox people claim that they are able to get 20%
more performance out of Ceph in the 40gigE scenario.

And if we're designing for the network for future then there's a lot
we can clean from the Quantcast hadoop filesystem
(http://quantcast.github.io/qfs/). Take a look at their recent
publication: http://db.disi.unitn.eu/pages/VLDBProgram/pdf/industry/p80=
8-ovsiannikov.pdf.
They essentially forked KFS, added erasure coding support created a
hadoop filesystem driver for it. They were able to get much better
write performance by reducing write amplifications (1.5x copies versus
3 copies) thus reducing network traffic and possibly freeing up that
previous bandwidth for read traffic. They claim to have improved read
performance compared to HDFS a tad.

QFS unlike Ceph places the erasure coding logic inside of the client
so it's not a apples-to-apples comparison. but I think you get my
point, and it would be possible to implement a rich Ceph
(filesystem/hadoop) client like this as well.

In summary, if Hadoop on Ceph is a major priority I think it would be
best to "borrow" the good ideas for QFS and implement them in Hadoop
Ceph filesystem and Ceph it self (letting a smart client get chunks
directly, write chunks directly). I don't doubt that it's a lot of
work but the results might be worth it in in terms of performance you
get for the cost.


Some food for though. I don't have a horse in this particular game but
I am interested in DFSs and VLDBs so I'm constantly reading into
research / what folks are building.

Cheers,
- Milosz

P.S: Forgot to Reply-to-all, haven't had my coffee yet.

On Thu, Sep 4, 2014 at 3:16 AM, Johnu George (johnugeo)
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
>
> I am wondering if someone any benchmark results for various object si=
zes.
> If you have them, it will be helpful if you share them.
>
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
>
> Also, Sage wrote about a way to specify a node to be primary for hado=
op
> like environments.
> (http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/1548 ) =
Is
> this through primary affinity configuration?
>
> Thanks,
> Johnu
>



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
