From: David Moreau Simard <dmsimard@iweb.com>
Subject: Re: Ceph & Cinder & HA
Date: Fri, 7 Nov 2014 08:46:43 +0000
Message-ID: <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com>
References: <545B9A53.4040502@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmx1.iweb.com ([70.38.127.135]:42416 "EHLO bmx1.iweb.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbaKGJBt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 04:01:49 -0500
In-Reply-To: <545B9A53.4040502@dachary.org>
Content-Language: en-US
Content-ID: <EDAB37FBFA29CA4EA3F9D7B7888EC570@corp.iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Florian Haas <florian.haas@hastexo.com>, "\"@@redhat.com\"@dachary.org" <"@@redhat.com"@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Loic,

Was there an etherpad ? I'm curious as I didn't attend that one.

HA with Cinder mostly revolves around setting up multiple cinder-api an=
d cinder-volume servers. Was there something else involved ?
I can probably contribute my knowledge on that..

--
David Moreau Simard

> On Nov 6, 2014, at 4:57 PM, Loic Dachary <loic@dachary.org> wrote:
>=20
> Hi Florian,
>=20
> I attended the Ceph & Cinder & HA session today at the summit. I've n=
ever really thought about strategies to implement HA and how Ceph can h=
elp. The extent of my knowledge on this topic is to make sure I do not =
confuse something that is "highly reliable" with something "highly avai=
lable" ;-)
>=20
> Guilio came to me after the session and I had to confess my ignorance=
 on the topic of HA. Hence this mail and the hope that you can shed som=
e light on this topic.
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
