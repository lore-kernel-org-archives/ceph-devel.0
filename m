From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 18:17:56 +0200 (CEST)
Message-ID: <53ea621c-eac1-42d0-a887-02b47949f74b@mailpro>
References: <CADvuQREFunAWAzYUuN73LevBk3AwH-QsUu3rH6P1N5Fyu-TRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38775 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab2FRQSS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 12:18:18 -0400
In-Reply-To: <CADvuQREFunAWAzYUuN73LevBk3AwH-QsUu3rH6P1N5Fyu-TRKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

noatime and nodiratime are already enabled

cat /etc/fstab

/dev/sdb       /srv/osd.0          xfs     noatime,nodiratime  0       =
0


(drive was formatted simply with mkfs.xfs /dev/sdb)




----- Mail original -----=20

De: "Tommi Virtanen" <tv@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 18:01:52=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On Mon, Jun 18, 2012 at 5:34 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:=20
> I'm doing test with rados bench, and I see constant writes to osd dis=
ks.=20
> Is it the normal behaviour ? with write-ahead should write occur each=
 20-30 seconde ?=20

Is the osd data filesystem perhaps doing atime updates? noatime is your=
 friend.=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
