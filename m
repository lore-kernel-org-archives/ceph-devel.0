From: Alexey Shvetsov <alexxy@gentoo.org>
Subject: Re: MDS crash on 0.60 after upgrade from 0.58
Date: Tue, 09 Apr 2013 16:02:02 +0400
Message-ID: <e424a8f1c14106827dc9c72eb812670e@omrb.pnpi.spb.ru>
References: <dcbb6527421f9a4537782e43dcaf4e47@omrb.pnpi.spb.ru>
 <515D419B.3000002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from omrb.pnpi.spb.ru ([91.151.181.195]:57695 "EHLO omrb.pnpi.spb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936644Ab3DIMCK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Apr 2013 08:02:10 -0400
In-Reply-To: <515D419B.3000002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello!

There issue on bugtracker that describes this problems
http://tracker.ceph.com/issues/4644

Unfortunately i cannot login to it since i dont get registration mail.

Also patches listed on this issue doesnt work for me. MDS still keeps=20
crashing


Joao Eduardo Luis =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 04-04-2013 13:02:
> On 04/04/2013 09:27 AM, Alexey Shvetsov wrote:
>> Hi all!
>>=20
>> I'm getting mds crash on 0.60 after i upgraded to it from 0.58=20
>> release.
>> MDS log looks like http://bpaste.net/show/88863/
>> MON log looks like http://bpaste.net/show/88864/
>>=20
>> Interesting that if we didnt started osd then mds will not crash
>>=20
>> PS configuration consist of 18 osd + 1 mon + 1 mds
>>=20
>=20
> Hello Alexey,
>=20
> First of all, it appears that your monitors have not been upgraded.
> Their crash dumps state their version to be 0.59 still.
>=20
> Furthermore, the issue you're suffering from is the one described in
> ticket #4519 at the tracker [1], and the fix [2] is already present o=
n
> v0.60, just not 0.59.
>=20
>   -Joao
>=20
> [1] - http://tracker.ceph.com/issues/4519
> [2] - 71ec9c6bd54d560cc2bca4b6d0dbb3e6961df135
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Best Regards,
Alexey 'Alexxy' Shvetsov
Petersburg Nuclear Physics Institute, NRC Kurchatov Institute,=20
Gatchina, Russia
Department of Molecular and Radiation Biophysics
Gentoo Team Ru
Gentoo Linux Dev
mailto:alexxyum@gmail.com
mailto:alexxy@gentoo.org
mailto:alexxy@omrb.pnpi.spb.ru
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
