From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Increasing the number of PGs
Date: Tue, 27 Mar 2012 13:37:27 -0700
Message-ID: <CAORUGqCqEwaTfpRuSK64EX=w2Ak9_q7qhL8F2dK1U=ECxe-V2A@mail.gmail.com>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt> <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
 <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59990 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab2C0Uhs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 16:37:48 -0400
Received: by gghe5 with SMTP id e5so322476ggh.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 13:37:47 -0700 (PDT)
In-Reply-To: <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm@doc.ic.ac.uk>
Cc: =?UTF-8?Q?Cl=C3=A1udio_Martins?= <ctpm@ist.utl.pt>, ceph-devel@vger.kernel.org

2012/3/27 David McBride <dwm@doc.ic.ac.uk>:
> Does the act of adding OSDs itself result in the PG count being
> increased?
>
> This seems to be the behaviour I've just observed on my testing clust=
er
> (running 0.44) using an incantation like:
>
>> for i in `seq 14 27`; do
>> ceph osd create $i
>> ceph osd crush add $i osd.$i 1.0 host=3D$hostname rack=3D$rack pool=3D=
default
>> ceph-osd -i $i --mkfs --mkkey
>> ceph -i /etc/ceph/keyring.osd.$i auth add osd.$i osd "allow *" mon "=
allow rwx"
>> done
>
> The number of PGs seems to have roughly doubled, and half of my
> OSDs now assert in OSD::get_or_create_pg() with "FAILED assert(role =3D=
=3D 0)".
>
> This seems to be a similar failure-mode for others who report issues =
after
> PG-splitting; as in those cases, `ceph -w` also reports errors of the=
 form:
>
> =C2=A0[ERR] mkpg 1.1p23 up [5,12] !=3D acting [12]
>
> Have I done something wrong? =C2=A0Is there some alternate sequence o=
f steps
> that avoids / suppresses PG splitting?

As Sage said, the operations you mentioned should not have changed the
number of PGs.

However, if you ever changed the number of PGs on a live system (on a
non-empty pool), your cluster may be in some weird corrupt state, and
that could cause all the symptoms you are seeing.

As far as I know, work on the PG splitting/joining feature is
currently suspended in favor of the leveldb-based key-value store and
improving commit latency. Hopefully Sam can get back to PG splits in
the near future, I see regular demand for it.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
