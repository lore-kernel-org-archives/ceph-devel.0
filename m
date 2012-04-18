From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: pgs stuck inactive
Date: Wed, 18 Apr 2012 00:35:19 -0400 (EDT)
Message-ID: <9d40aac2-54af-4570-95e5-53175a026006@mail.linserv.se>
References: <CA990ABA69C04ECBB750275912830DD0@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:46568 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2DREpp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 00:45:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 6C842DA032
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 00:35:23 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zi59KrUFe4tF for <ceph-devel@vger.kernel.org>;
	Wed, 18 Apr 2012 00:35:19 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 55ECCDA031
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 00:35:19 -0400 (EDT)
In-Reply-To: <CA990ABA69C04ECBB750275912830DD0@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I think I have a simmilar problem, but only 2 pgs inacive and 2 pgs unc=
lean.
They have been there since yesterday. I'm running kernel 3.2 and ceph 0=
=2E45

 /Regards Martin

----- Ursprungligt meddelande -----=20

=46r=C3=A5n: "Greg Farnum" <gregory.farnum@dreamhost.com>=20
Till: "Damien Churchill" <damoxc@gmail.com>=20
Kopia: "Samuel Just" <sam.just@dreamhost.com>, ceph-devel@vger.kernel.o=
rg=20
Skickat: tisdag, 17 apr 2012 18:49:03=20
=C3=84mne: Re: pgs stuck inactive=20

On Monday, April 16, 2012 at 10:32 PM, Damien Churchill wrote:=20
> On 17 April 2012 01:06, Greg Farnum <gregory.farnum@dreamhost.com (ma=
ilto:gregory.farnum@dreamhost.com)> wrote:=20
> > Yep!=20
> > We looked into this more today and have discovered some definite od=
dness. Have you by any chance tried to change the number of PGs in your=
 pools?=20
>=20
>=20
>=20
> I haven't no (at least certainly not on purpose!). All I've really=20
> done is copy a bit of stuff onto the unix fs and create a few rbd=20
> volumes, as well as upgrade it when a new version comes out.=20

Drat, that means there's actually a problem to track down somewhere.=20
Do you know what version this was created with, and what upgrades you'v=
e been through? My best guess right now is that there's a problem with =
the encoding and decoding that I'm going to have to track down, and mor=
e context will make it a lot easier. :)=20
-Greg=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
