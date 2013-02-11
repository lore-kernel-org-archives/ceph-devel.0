From: Gregory Farnum <greg@inktank.com>
Subject: Re: preferred OSD
Date: Mon, 11 Feb 2013 12:11:45 -0800
Message-ID: <CAPYLRzgJLzzs4HXatvyJnXzMn2A5LaN0evN0=+xvbPdnT7r2Pg@mail.gmail.com>
References: <CALFpzo5YGNi0tNc2HeauCQ_Kh4hgxzEtVLu5TdT1Nb-GZBvKTw@mail.gmail.com>
	<alpine.DEB.2.00.1302081642230.13223@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51966 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab3BKULq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 15:11:46 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so1336692qan.12
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 12:11:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302081642230.13223@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 8, 2013 at 4:45 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Marcus-
>
> On Fri, 8 Feb 2013, Marcus Sorensen wrote:
>> I know people have been disscussing on and off about providing a
>> "preferred OSD" for things like multi-datacenter, or even within a
>> datacenter, choosing an OSD that would avoid traversing uplinks.  Ha=
s
>> there been any discussion on how to do this? I seem to remember peop=
le
>> saying things like 'the crush map doesn't work that way at the
>> moment'. Presumably, when a client needs to access an object, it loo=
ks
>> up where the object should be stored via the crush map, which return=
s
>> all OSDs that could be read from.

Exactly.

>> I was thinking this morning that you
>> could potentially leave the crush map out of it, by setting a locati=
on
>> for each OSD in the ceph.conf, and an /etc/ceph/location file for th=
e
>> client.  Then use the absolute value of the difference to determine
>> preferred OSD. So, if OSD0 was location=3D1, and OSD1 was location=3D=
3,
>> and client 1 was location=3D2, then it would do the normal thing, bu=
t if
>> client 1 was location=3D1.3, then it would prefer OSD0 for reads.
>> Perhaps that's overly simplistic and wouldn't scale to meet everyone=
's
>> requirements, but you could do multiple locations and sprinkle clien=
ts
>> in between them all in various ways.  Or perhaps the location is a
>> matrix, so you could literally map it out on a grid with a set of
>> coordinates. What ideas are being discussed around how to implement
>> this?
>
> We can do something like this for reads today, where we pick a read
> replica based on the closest IP or some other metric/mask.  We genera=
lly
> don't enable this because it leads to non-optimal cache behavior, but=
 it
> could in principle be enabled via a config option for certain cluster=
s
> (and in fact some of that code is already in place).

Just to be specific =97 there are currently flags which will let the
client read from local-host if it can figure that out, and those
aren't heavily-tested but do work when we turn them on. Other metrics
of "close" don't appear yet, though.
In general, CRUSH locations seem like a good measure of closeness that
the client could rely on, rather than a separate "location" value, but
it does restrict the usefulness if you've configured multiple CRUSH
root nodes. I think it would need to support a tree of some kind
though, rather than just a linear value.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
