From: David Blundell <David.Blundell@100percentit.com>
Subject: Re: Slow request warnings on 0.48
Date: Wed, 4 Jul 2012 22:03:37 +0000
Message-ID: <D3E52321-BD53-45FB-9AF1-AACCE2026843@100percentit.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
 <D9AB48B599C2406EB9C62F237DC58FF1@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.100percentit.com ([217.25.0.14]:38886 "EHLO
	smtp.100percentit.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755360Ab2GDWDn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 18:03:43 -0400
In-Reply-To: <D9AB48B599C2406EB9C62F237DC58FF1@inktank.com>
Content-Language: en-US
Content-ID: <345AF16C4A361F4E881A6EDDBC607E34@ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "<ceph-devel@vger.kernel.org>" <ceph-devel@vger.kernel.org>

On 4 Jul 2012, at 19:59, Gregory Farnum wrote:

> That's odd =97 there isn't too much that went into the OSD between 0.=
47 and 0.48 that I can think of, and most of that only impact OSDs when=
 they go through bootup. What does ceph -s display =97 are all the PGs =
healthy? =20
> -Greg
>=20


Hi Greg,

The PGs all seem to be healthy:

root@store1:~# ceph -s
   health HEALTH_OK
   monmap e1: 3 mons at {0=3D10.0.1.40:6789/0,1=3D10.0.1.41:6789/0,2=3D=
10.0.1.42:6789/0}, election epoch 40, quorum 0,1,2 0,1,2
   osdmap e342: 7 osds: 7 up, 7 in
    pgmap v5403: 1344 pgs: 1344 active+clean; 4620 MB data, 9617 MB use=
d, 1368 GB / 1377 GB avail
   mdsmap e50: 0/0/1 up

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
