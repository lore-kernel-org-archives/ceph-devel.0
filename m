From: Sage Weil <sage@newdream.net>
Subject: Re: Change the weight of osd
Date: Mon, 9 May 2011 16:42:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105091639590.24760@cobra.newdream.net>
References: <BANLkTimvC_s9PSdojK9A+kQXy7NkyjsPWw@mail.gmail.com>
 <BANLkTi=eF+3vSunQMAR=siYNLu_ifHceTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1124792617-1304984525=:24760"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1EIXlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 19:41:21 -0400
In-Reply-To: <BANLkTi=eF+3vSunQMAR=siYNLu_ifHceTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: Ceph <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1124792617-1304984525=:24760
Content-Type: TEXT/PLAIN; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefanie,

On Mon, 9 May 2011, doki74216@gmail.com wrote:
> > domain dom8 {
> >        id -9           # do not change unnecessarily
> >        alg uniform     # do not change bucket size (3) unnecessarily
               ^^^^^^^

The problem is that the bucket algorithm is 'uniform', which uniformly=20
distributes objects across the items.  Weighting isn't supported, and the=
=20
weight value is ignored.  (We should make the crushmap compiler spit out a=
=20
warning to that effect if the weights vary at all!)

If you switch the alg to straw, the data will reshuffle, but you'll be=20
able to set the weights however you like.

sage


 > >        hash 0  # rjenkins1
> >        item device24 weight 1.000 pos 0
> >        item device25 weight 1.000 pos 1
> >        item device26 weight 1.000 pos 2
> > }
> > domain dom9 {
> >        id -10          # do not change unnecessarily
> >        alg uniform     # do not change bucket size (3) unnecessarily
> >        hash 0  # rjenkins1
> >        item device27 weight 1.000 pos 0
> >        item device28 weight 1.000 pos 1
> >        item device29 weight 3.000 pos 2
> >                                      ^^^^^^^^
> >                                         I replace 1.000 with 3.000 .
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 3) I execute "crushtool -c /tmp/crushmap.txt -o /tmp/crushmap_new"and"
> > ceph osd setcrushmap -i /tmp/crushmap_new"
> > 4) I thought the crushmap has already changed.
> >    If I write data, the data will more prbable placed in osd29 . right?
> >    When I excute" time dd if=3D/dev/zero
> > of=3D/mnt/ceph/reweight_64k_64M_1.dbf bs=3D64k count=3D1024 oflag=3Ddsy=
nc"
> >    I check the folder size by excuting "/mnt/ext4/osd24/current/"....
> > "/mnt/ext4/osd29/current/".
> >    I found that the folder size is not growed in accordance with the
> > wight I edit (osd24 osd25 osd26 osd27 osd28 weight=3D>1.000, osd29
> > weight=3D>3.000).
> >    Here is the increasing folder size.
> > In OSD9
> > =83=DC       osd24  4124 kB
> > =83=DC       osd25  28748 kB
> > =83=DC       osd26  34064 kB
> > In OSD10
> > =83=DC       osd27  4124 kB
> > =83=DC       osd28  28748 kB
> > =83=DC       osd29  34060 kB
> >                 ^^^^^^^^^^^^^^^^^^
> >                Why  the folder size is not growed in accordance with
> > the wight I edit ?
> >
> >
> > If I want to change the weight of osd . Are the steps I mentioned above=
 correct?
> > Do you have any good idea or advice to our test? I really want to know
> > how to change the weight of osd and how to verify it.
> > Thank you very much...^^
> >
> > Stefanie Chen
> >
>=20
>=20
> Please helping me to solve this problem.
> I appreciate it.
> Stefanie Chen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1124792617-1304984525=:24760--
