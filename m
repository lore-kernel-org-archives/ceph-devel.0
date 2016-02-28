From: Loic Dachary <loic@dachary.org>
Subject: Re: make error while building ceph
Date: Sun, 28 Feb 2016 17:48:41 +0700
Message-ID: <56D2D089.7090109@dachary.org>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52327 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbcB1Ksx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Feb 2016 05:48:53 -0500
In-Reply-To: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jai <jai_97@rediffmail.com>, ceph-devel@vger.kernel.org

Hi,

You should try to run ./install-deps.sh first so that the required depe=
ndencies are all installed. Which operating system are you using ?
The bug tracker is at http://tracker.ceph.com/. Where did you find a li=
nk to http://tracker.newdream.net/projects/ceph ? It should be fixed :-=
)

Cheers

On 28/02/2016 17:29, Jai wrote:
> I followed instructions in the README, but "make" gives me this error=
 --
>=20
> In file included from ./include/types.h:21:0,
>                  from kv/LevelDBStore.h:6,
>                  from kv/KeyValueDB.cc:5:
> ./include/uuid.h:14:42: fatal error: boost/random/random_device.hpp:
> No such file or directory
> compilation terminated.
>=20
> I m compiling on ubuntu, and it looks like I have boost headers
> (/usr/include/boost), but this file is absent. llibboost appears to b=
e
> 1.46.1
> appreciate any pointers to resolve this error.
>=20
> Also, I couldn't access the web page for bugs
> (http://tracker.newdream.net/projects/ceph) - where can I find a list
> of bugs/ features ?
> --
> Jai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
