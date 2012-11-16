From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: ceph-osd cpu usage
Date: Fri, 16 Nov 2012 09:41:17 +0100 (CET)
Message-ID: <f23bc508-a0c1-445d-a2bd-062898847507@mailpro>
References: <50A54FDE.9070403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55555 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2KPIls convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 03:41:48 -0500
In-Reply-To: <50A54FDE.9070403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

>>Any other ideas how to reduce ceph-osd while doing randwrite?=20
>>
>>Randread gives me with 3 VMs: 60.000 iops=20
>>Randwrite gives me with 3 VMs: 25.000 iops=20

Great to see that read scale !

=46or randwrite, what is the bottleneck now with filestore xattr use om=
ap =3D true ?

Always cpu ?




----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 15 Novembre 2012 21:26:06=20
Objet: Re: ceph-osd cpu usage=20

Am 15.11.2012 16:14, schrieb Sage Weil:=20
> On Thu, 15 Nov 2012, Stefan Priebe - Profihost AG wrote:=20
> Hmm, most significant time seems to be in the allocator and doing=20
> fsetxattr(2) (10%!). Also some path traversal stuff.=20
Yes fsetxattr seems to be CPU hungry.=20

> Can you try the wip-fd-simple-cache branch, which tries to spend less=
 time=20
> closing and reopening files? I'm curious how much of a different it w=
ill=20
> make for you for both IOPS and CPU utilization.=20
It seems to give me around 1000 iops across 3 VMs.=20

> It is also possible to use leveldb for most attrs. If you set=20
> 'filestore xattr use omap =3D true' it should put most attrs in level=
db.=20
Tried this but this raises CPU by 20%.=20

Any other ideas how to reduce ceph-osd while doing randwrite?=20

Randread gives me with 3 VMs: 60.000 iops=20
Randwrite gives me with 3 VMs: 25.000 iops=20

Stefan=20
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
