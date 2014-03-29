From: Kevin Greenan <kmgreen2@gmail.com>
Subject: Re: jerasure / gf-complete & 32 bits
Date: Sat, 29 Mar 2014 09:16:31 -0700
Message-ID: <BC86EB1E-D599-4286-A73E-29130DB0A5A2@gmail.com>
References: <5335AE3D.1050104@dachary.org> <53368DA3.7080206@dachary.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:54470 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaC2QQd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Mar 2014 12:16:33 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so6156603pde.29
        for <ceph-devel@vger.kernel.org>; Sat, 29 Mar 2014 09:16:33 -0700 (PDT)
In-Reply-To: <53368DA3.7080206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hey Loic,

I'll take a look on Monday.  I'll create a VM to try and reproduce (and=
 hopefully fix) this.

Thanks!
-kevin

On Mar 29, 2014, at 2:08 AM, Loic Dachary wrote:

> The gf-complete + jerasure tests run fine on Ubuntu saucy 32 bits. Th=
e problem is when trying to compile on a 32 bits machine as shown here
>=20
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-i386=
-basic/log.cgi?log=3Dcb624fc9ed1e891e51cc0d20622d43f6fcd08cd5
>=20
>=20
> On 28/03/2014 18:15, Loic Dachary wrote:
>> Hi Kevin,
>>=20
>> Someone mentionned a problem (no more information at the moment ;-) =
about running jerasure / gf-complete on a 32 bits machine. Does that ri=
ng a bell ? I'll try it out with the test method you suggested:
>>=20
>> "'gf_methods <w> -A -U' to run all of the tests for w=3D[4,8,16,32,6=
4,128]. Then, I install a fresh Jerasure and run test_all_gfs.sh and ti=
me_all_gfs_argv_init.sh. Finally, I install PyECLib (Python library tha=
t wraps Jerasure, ISA-L (soon) and has some homegrown XOR- codes) and r=
un the scripts under tests/."
>>=20
>> Cheers
>>=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
