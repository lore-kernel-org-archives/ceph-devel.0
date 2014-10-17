From: David Zafman <david.zafman@inktank.com>
Subject: Re: vstart.sh crashes MON with --paxos-propose-interval=0.01 and one MDS
Date: Thu, 16 Oct 2014 19:42:52 -0700
Message-ID: <734FCEB2-7161-4B6E-8886-9BC0126D997F@inktank.com>
References: <54404C3F.4030904@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37901 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbaJQCm5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 22:42:57 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so4386809pdj.9
        for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 19:42:57 -0700 (PDT)
In-Reply-To: <54404C3F.4030904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <john.spray@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>


I have this change in my branch so that test/ceph_objectstore_tool.py w=
orks again after that change from John.  I wonder if this would fix you=
r case too:

commit 18937cf49be616d32b4e2d0b6deef2882321fbe4
Author: David Zafman <dzafman@redhat.com>
Date:   Tue Oct 14 18:45:41 2014 -0700

    vstart.sh: Disable "mon pg warn min per osd" to get healthy

    Signed-off-by: David Zafman <dzafman@redhat.com>

diff --git a/src/vstart.sh b/src/vstart.sh
index febfa56..7a0ec1c 100755
--- a/src/vstart.sh
+++ b/src/vstart.sh
@@ -394,7 +394,7 @@ $COSDDEBUG
 $COSDMEMSTORE
 $extra_conf
 [mon]
-        mon pg warn min per osd =3D 10
+        mon pg warn min per osd =3D 0
         mon osd allow primary affinity =3D true
         mon reweight min pgs per osd =3D 4
 $DAEMONOPTS

David Zafman
Senior Developer
http://www.inktank.com




On Oct 16, 2014, at 3:52 PM, Loic Dachary <loic@dachary.org> wrote:

> Hi John,
>=20
> I would be gratefull if you could take a quick look at http://tracker=
=2Eceph.com/issues/9794 . It is bisected to the reduction of pg and I'm=
 able to reproduce it in a ubuntu-14.04 docker fresh install. For some =
reason it does not happen in gitbuilder but I think you can reproduce i=
t locally now.
>=20
> Cheers
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
