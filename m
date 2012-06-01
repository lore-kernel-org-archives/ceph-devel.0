From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd command : is it possible to pass authkey in argument ?
Date: Fri, 01 Jun 2012 15:36:33 +0200 (CEST)
Message-ID: <99c07e74-1098-4d45-acb0-1a412f75439e@mailpro>
References: <CADvuQRFSCJH5yyuUMK_QpnTW60xBXaPtuYujARjyxD+8=NgjYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33544 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759581Ab2FANhA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 09:37:00 -0400
In-Reply-To: <CADvuQRFSCJH5yyuUMK_QpnTW60xBXaPtuYujARjyxD+8=NgjYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Tommi,
I was looking for a way to pass a keyfile, just found it

--keyfile  (both rbd and qemu drive option)


Better indeed ;)



----- Mail original -----=20

De: "Tommi Virtanen" <tv@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 30 Mai 2012 19:40:46=20
Objet: Re: rbd command : is it possible to pass authkey in argument ?=20

On Wed, May 30, 2012 at 2:15 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:=20
> Is it possible to pass authkey as argument in rbd command line ? (I c=
an do in with qemu-rbd drive option)=20

I see you got an answer for your actual question. I wanted to take a=20
different angle.=20

You should really avoid putting secrets on command lines, or in=20
process environment. Those are readable to all local users. This is=20
why I advocate keyring files.=20

Alternatively, with qemu, the monitor command mechanism they have=20
would let you add the drives, before starting up the vm, without the=20
secrets being visible to others.=20



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
