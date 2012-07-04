From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow request warnings on 0.48
Date: Wed, 4 Jul 2012 11:59:55 -0700
Message-ID: <D9AB48B599C2406EB9C62F237DC58FF1@inktank.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63397 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab2GDS7w convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 14:59:52 -0400
Received: by pbbrp8 with SMTP id rp8so11438039pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 11:59:52 -0700 (PDT)
In-Reply-To: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, David Blundell <David.Blundell@100percentit.com>
Cc: ceph-devel@vger.kernel.org

That's odd =E2=80=94 there isn't too much that went into the OSD betwee=
n 0.47 and 0.48 that I can think of, and most of that only impact OSDs =
when they go through bootup. What does ceph -s display =E2=80=94 are al=
l the PGs healthy? =20
-Greg


On Wednesday, July 4, 2012 at 9:58 AM, Alexandre DERUMIER wrote:

> Hi, I see same messages here after upgrade to 0.48.
> =20
> with random write benchmark.
> =20
> I have more lags than before with 0.47 (but disks are at 100% usage, =
so can't tell if it's normal or not)
> =20
> =20
> ----- Mail original ----- =20
> =20
> De: "David Blundell" <David.Blundell@100percentit.com (mailto:David.B=
lundell@100percentit.com)> =20
> =C3=80: ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org=
) =20
> Envoy=C3=A9: Mercredi 4 Juillet 2012 18:53:02 =20
> Objet: Slow request warnings on 0.48 =20
> =20
> I have three servers running mon and osd using Ubuntu 12.04 that I ha=
ve been testing with RADOS storing RBD KVM instances =20
> =20
> 0.47.3 worked extremely well (once I got over a few btrfs issues). Th=
e same servers running 0.48 give a large number of "[WRN] slow request"=
 messages whenever I generate a lot of random IO in the KVM instances u=
sing iozone. The slow responses eventually leads to disk timeouts on th=
e KVM instances. =20
> =20
> I have erased the osds and recreated on new btrfs volumes with the sa=
me result. =20
> =20
> I have also tried switching to xfs using mkfs.xfs -n size=3D64k with =
noatime, inode64,delaylog,logbufs=3D8,logbsize=3D256k =20
> =20
> Xfs gives the same result - the iozone tests run fine until the rando=
m IO starts and then there are lots of slow request warnings. =20
> =20
> Does anyone have any ideas about the best place to start troubleshoot=
ing / debugging? =20
> =20
> Thanks, =20
> =20
> David =20
> -- =20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in =20
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org) =20
> More majordomo info at http://vger.kernel.org/majordomo-info.html =20
> =20
> =20
> =20
> -- =20
> =20
> -- =20
> =20
> =20
> =20
> =20
> Alexandre D e rumier =20
> =20
> Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux =20
> =20
> =20
> Fixe : 03 20 68 88 85 =20
> =20
> Fax : 03 20 68 90 88 =20
> =20
> =20
> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix =20
> 12 rue Marivaux 75002 Paris =20
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
