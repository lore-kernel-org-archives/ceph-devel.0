From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] More writes on filestore than on journal ?
Date: Mon, 23 Mar 2015 15:35:34 +0100
Message-ID: <1427121334.16770.36.camel@daevel.fr>
References: <1427116891.16770.25.camel@daevel.fr>
	 <CAC6JEv9J7jEtgv3tcruXr8TN6gXFn1_iNexv8S_F772MY2vjXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:59939 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbbCWOfi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:35:38 -0400
In-Reply-To: <CAC6JEv9J7jEtgv3tcruXr8TN6gXFn1_iNexv8S_F772MY2vjXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Le lundi 23 mars 2015 =C3=A0 07:29 -0700, Gregory Farnum a =C3=A9crit :
> On Mon, Mar 23, 2015 at 6:21 AM, Olivier Bonvalet <ceph.list@daevel.f=
r> wrote:
> > Hi,
> >
> > I'm still trying to find why there is much more write operations on
> > filestore since Emperor/Firefly than from Dumpling.
>=20
> Do you have any history around this? It doesn't sound familiar,
> although I bet it's because of the WBThrottle and flushing changes.

I only have history for block device stats and global stats reports by
=C2=ABceph status=C2=BB.
When I have upgrade from Dumpling to Firefly (via Emperor), write
operations increased a lot on OSD.
I suppose it's because of WBThrottle too, but can't find any parameter
able to confirm that.


> >
> > So, I add monitoring of all perf counters values from OSD.
> >
> > From what I see : =C2=ABfilestore.ops=C2=BB reports an average of 7=
8 operations
> > per seconds. But, block device monitoring reports an average of 113
> > operations per seconds (+45%).
> > please thoses 2 graphs :
> > - https://daevel.fr/img/firefly/osd-70.filestore-ops.png
> > - https://daevel.fr/img/firefly/osd-70.sda-ops.png
>=20
> That's unfortunate but perhaps not surprising =E2=80=94 any filestore=
 op can
> change a backing file (which requires hitting both the file and the
> inode: potentially two disk seeks), as well as adding entries to the
> leveldb instance.
> -Greg
>=20

Ok thanks, so this part can be =C2=ABnormal=C2=BB.

> >
> > Do you see what can explain this difference ? (this OSD use XFS)
> >
> > Thanks,
> > Olivier
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
