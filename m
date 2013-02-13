From: Gregory Farnum <greg@inktank.com>
Subject: Re: Write Replication on Degraded PGs
Date: Wed, 13 Feb 2013 10:16:35 -0800
Message-ID: <CAPYLRziQC3FkOJy+EsFuQAmSY3j+9F0YZ9kTkc9Cc+JcUaZ7ug@mail.gmail.com>
References: <CAEU8emmTpA7TqYDuQ0=ybN_NkmosWAghn+vu=ggGEFwPeFps9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:64214 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965013Ab3BMSQi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 13:16:38 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so2264748qah.18
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 10:16:37 -0800 (PST)
In-Reply-To: <CAEU8emmTpA7TqYDuQ0=ybN_NkmosWAghn+vu=ggGEFwPeFps9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Rowland <ben.rowland@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 13, 2013 at 3:40 AM, Ben Rowland <ben.rowland@gmail.com> wr=
ote:
> Hi,
>
> Apologies that this is a fairly long post, but hopefully all my
> questions are similar (or even invalid!)
>
> Does Ceph allow writes to proceed if it's not possible to satisfy the
> rules for replica placement across failure domains, as specified in
> the CRUSH map?  For example, if my CRUSH map says to place one replic=
a
> on each of 2 hosts, and no devices are up on one of the hosts, what
> will happen?

As you've discovered, it will write to only the up host. You can
control this behavior by setting the min write size on your pools =E2=80=
=94
"ceph osd set <pool> min_size <size>" =E2=80=94 to be the minimum numbe=
r of
writes you'd like to guarantee are on disk. You can also set the "osd
pool default min size" parameter on the monitors; it defaults to 0
which is interpreted as "half of the requested size". (So for a size 2
pool, it will require at least one copy [d'oh], for a size 5 pool, it
will require at least 3 copies, etc.)
So it sounds from the rest of your post like you'd want to, for each
pool that RGW uses (it's not just .rgw), run "ceph osd set .rgw
min_size 2". (and for .rgw.buckets, etc etc)

> From tests on a small cluster, my finding is that Ceph will allow
> writes to proceed in this case, even when there are less OSDs "in" th=
e
> cluster than the replication size.
>
> If this is the expected behaviour of Ceph, then it seems to prefer
> write-availability over read-availability (in this case my data is
> only stored on 1 OSD, thus a SPOF).  Is there any way to change this
> trade-off, e.g. as you can in Cassandra with its write quorums?

I'm not quite sure this is describing it correctly =E2=80=94 Ceph guara=
ntees
that anything that's been written to disk will be readable later on,
and placement groups won't go active if they can't retrieve all data.
The sort of flexible policies allowed by Cassandra aren't possible
within Ceph =E2=80=94 it is a strictly consistent system.


> From reading the paper which details the CRUSH replica placement
> algorithm, I understand several concepts:
>
> - The CRUSH algorithm loops over n replicas, for each descending from
> items in the current set (buckets) until it finds a device
> - "CRUSH may reject and reselect items using a modi=EF=AC=81ed input =
for three
> different reasons: if an item has already been selected in the curren=
t
> set (a collision..., if a device is failed, or if a device is
> overloaded."
>
> I'm not clear on what will happen if these constraints cannot be met,
> say in the case mentioned above.  Does Ceph store the object once
> only, not meeting the replica size, or does it store the object twice
> on the same OSD somehow?  The latter would violate point 2 above,
> unless the word "reselect" is appropriate here.

CRUSH has a specified retry size; if it can't meet the constraints
then it spits out whatever replicas it was able to select. The
higher-level system needs to decide what to do with that list. Ceph
chooses to use whatever CRUSH gives back, within the minimum size
constraint specified above and a few other override mechanisms we
don't need to into here. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
