From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 02:05:36 +0200
Message-ID: <5057BAD0.8080201@smart-weblications.de>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:56077 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932379Ab2IRAFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Sep 2012 20:05:51 -0400
In-Reply-To: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>


Hi,

i use ceph to provide storage via rbd for our virtualization cluster de=
livering
KVM based high availability Virtual Machines to my customers. I also us=
e it
as rbd device with ocfs2 on top of it for a 4 node webserver cluster as=
 shared
storage - i do this, because unfortunatelly cephfs is not ready yet ;)


Am 18.09.2012 00:14, schrieb Ross Turk:
> Hi, all!
>=20
> One of the most important parts of Inktank's mission is to spread the
> word about Ceph. We want everyone to know what it is and how to use
> it.
>=20
> In order to tell a better story to potential new users, I'm trying to
> get a sense for today's deployments. We've spent the last few months
> talking to folks around the world, but I'm sure there are a few great
> stories we haven't heard yet!
>=20
> If you've got a spare five minutes, I would love to hear what you're
> up to. What kind of projects are you working on, and in what stage?
> What is your workload? Are you using Ceph alongside other
> technologies? How has your experience been?
>=20
> This is also a good opportunity for me to introduce myself to those I
> haven't met yet! Feel free to copy the list if you think others would
> be interested (and you don't mind sharing).
>=20



--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
