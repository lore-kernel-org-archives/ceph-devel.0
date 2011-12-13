From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: How to know the status of the monitors?
Date: Tue, 13 Dec 2011 13:35:37 +0000
Message-ID: <1323783337.3067.1.camel@squire.doc.ic.ac.uk>
References: <8512670932FB654F81AF0FEF1BE6D49D9DD46F@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cardinal.doc.ic.ac.uk ([146.169.1.194]:36036 "EHLO
	cardinal.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab1LMN5u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 08:57:50 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D9DD46F@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

On Tue, 2011-12-13 at 17:12 +0800, Eric_YH_Chen@wistron.com wrote:
> Hi, all:
>=20
>     Is there any command or API can retrieve the status of all monito=
rs?
>=20
>     I use =E2=80=98ceph mon stat=E2=80=99 to get this information. Ho=
wever, the mon.e is not available (server is shutdown).
>=20
>       2011-12-13 17:08:35.499022 mon <- [mon,stat]
> =E3=80=80=E3=80=80=E3=80=802011-12-13 17:08:35.499716 mon.1 -> 'e3: 5=
 mons at {a=3D172.16.33.5:6789/0,b=3D172.16.33.6:6789/0,c=3D172.16.33.7=
:6789/0,d=3D172.16.33.71:6789/0,e=3D172.16.33.72:6789/0}, election epoc=
h 16, quorum 0,1,2,3' (0)
>    =20
>     Even I use =E2=80=98ceph mon dump=E2=80=99, I still cannot know i=
f the monitor is alive or not.
>=20
> 		0: 172.16.33.5:6789/0 mon.a
> 		1: 172.16.33.6:6789/0 mon.b
> 		2: 172.16.33.7:6789/0 mon.c
> 		3: 172.16.33.71:6789/0 mon.d
> 		4: 172.16.33.72:6789/0 mon.e
>=20

I think the 'quorum 0,1,2,3' tells you which mon nodes are not in the
current live set -- note that entry 4 (i.e. mon.e) does not appear.

Cheers,
David
--=20
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
