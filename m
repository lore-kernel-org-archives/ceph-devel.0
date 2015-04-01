From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: tcmalloc issue
Date: Wed, 1 Apr 2015 20:09:15 +0200 (CEST)
Message-ID: <1296516734.36376417.1427911755096.JavaMail.zimbra@oxygem.tv>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net> <551C1514.3060607@ubuntu.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39609 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbbDASJR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 14:09:17 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-maintainers@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

does this bug also apply on rhel7(.1)/centos7(.1) ?


In Intank repository, I see

in rhel7 repository:

http://ceph.com/rpm-giant/rhel7/x86_64/gperftools-libs-2.1-1.el7.x86_64=
=2Erpm =20


But I can't find it in centos repository

http://ceph.com/rpm-giant/el7/x86_64/

?



Does Intank will backport the patch to gperftools-libs-2.1-1.el7.x86_64=
=2Erpm  ?




----- Mail original -----
De: "Somnath Roy" <Somnath.Roy@sandisk.com>
=C3=80: "James Page" <james.page@ubuntu.com>, "Sage Weil" <sage@newdrea=
m.net>, ceph-maintainers@ceph.com
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 1 Avril 2015 19:54:32
Objet: RE: tcmalloc issue

Thanks James !=20

the tcmalloc bug is reported in the following link.=20

http://code.google.com/p/gperftools/issues/detail?id=3D585=20

So, do you want us to give the steps on how we are hitting the followin=
g trace or to reproduce the bug reported in the above link ?=20

If you are asking about hitting the stack trace I mentioned below, it i=
s just running ceph with lot of IOs for longer period of time.=20

Let us know.=20

Regards=20
Somnath=20

-----Original Message-----=20
=46rom: James Page [mailto:james.page@ubuntu.com]=20
Sent: Wednesday, April 01, 2015 8:56 AM=20
To: Sage Weil; ceph-maintainers@ceph.com=20
Cc: Somnath Roy; ceph-devel@vger.kernel.org=20
Subject: Re: tcmalloc issue=20

-----BEGIN PGP SIGNED MESSAGE-----=20
Hash: SHA256=20

I've logged:=20

https://bugs.launchpad.net/ubuntu/+source/google-perftools/+bug/1439277=
=20

The upstream fix applies cleanly to the version of gperftools in 14.04=20
- - I just need a good reproducer for the SRU test case.=20

If anyone has one, please detail in the bug report above - I'll also pi=
ng on the upstream bug (but that is from 2013 so might not get much luc=
k).=20

On 26/03/15 23:47, Sage Weil wrote:=20
> Hi James,=20
>=20
> Is it possible to get tcmalloc in trusty updated? See below.=20
>=20
> Thanks! sage=20
>=20
> On Thu, 26 Mar 2015, Somnath Roy wrote:=20
>=20
>> Sage, Here is the tcmalloc issue I was talking in the performance=20
>> meeting.=20
>>=20
>> http://code.google.com/p/gperftools/issues/detail?id=3D585=20
>>=20
>> The tcmalloc is consuming lot of cpus (and eventually slowing down=20
>> the performance) with the following perf top trace.=20
>>=20
>> 25.73% libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::FetchFromSpans() 12.52%=20
>> libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::=
=46=20
reeList*,=20
>> unsigned long, int) 11.62% libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::ReleaseToSpans(void*) 1.56% [kernel] [k]=20
>> __copy_user_nocache 1.44% libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::RemoveRange(void*, void*, int) 1.39%=20
>> libtcmalloc.so.4.1.2 [.]=20
>> tcmalloc::CentralFreeList::ReleaseListToSpans(void*) 0.89%=20
>> libtcmalloc.so.4.1.2 [.] operator new(unsigned long)=20
>>=20
>>=20
>> The TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is alleviating that but th=
e=20
>> env variable setting for this is a noop in the binary we are having=20
>> in Ubuntu 14.04. It is fixed in gperftools-2.1.90 release. See the=20
>> following link.=20
>>=20
>> http://code.google.com/p/gperftools/=20
>>=20
>> We can request Ubuntu guys to incorporate this version or the latest=
=20
>> tcmalloc version which is gperftools-2.4.=20
>>=20
>> It will be really helpful if you can push them to incorporate this i=
n=20
>> 14.04 updates.=20
>>=20
>> Thanks & Regards Somnath=20
>>=20
>> ________________________________=20
>>=20
>> PLEASE NOTE: The information contained in this electronic mail=20
>> message is intended only for the use of the designated=20
>> recipient(s) named above. If the reader of this message is not the=20
>> intended recipient, you are hereby notified that you have received=20
>> this message in error and that any review, dissemination,=20
>> distribution, or copying of this message is strictly prohibited. If=20
>> you have received this communication in error, please notify the=20
>> sender by telephone or e-mail (as shown=20
>> above) immediately and destroy any and all copies of this message in=
=20
>> your possession (whether hard copies or electronically stored=20
>> copies).=20
>>=20
>> -- To unsubscribe from this list: send the line "unsubscribe=20
>> ceph-devel" in the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
>=20


- --=20
James Page=20
Ubuntu and Debian Developer=20
james.page@ubuntu.com=20
jamespage@debian.org=20
-----BEGIN PGP SIGNATURE-----=20
Version: GnuPG v2=20

iQIcBAEBCAAGBQJVHBUUAAoJEL/srsug59jDfPYP/2zE62fCmvp9o+x7CxtDsALv=20
JvlEAdtjR7F4epx/IWlrJcRW7Z8EMmXYu7Enlsc4koZhSoIgw92SzBilaSwt+d7V=20
3M0xhFImlvednXJn8ppSBxIf5qrc8r57jQhnLv1rnw4+JrP+U6C994jmZCERKiN+=20
Ph9+j+A7yBmIqinjdx9kbes29/wZuUgRCyF5c7Wm2xm4W3aN8ZthNKa7mbXvzO9Y=20
ZNtXGcKZdKMWHbZYAmU64Sj82YQOWAdG/3FXOf+FmFOXDQG380UKCmd2aDRcqyvd=20
ySBFrJVoZG2s9wr9lJBhnIebAs48WoRPXhsDXtknncw0L/ZkErF8c8HKUm4WIztM=20
0fO/Zhue09vLTgOuBOmxcW6g0TW0CFhFPWXdTrb/gRfns6mOcuu57CdsvTePTEvH=20
iYpWQQaccaqgO5Yt2Y7lNR7JwoEYBEX4CahaxO2XmN9wl9N/RJxMd4AhyxKCuimL=20
La9YLZszHf+8qGMUjzY3NE6bgXlqUzjuNCE7ROu5rlyobrd4iRi8r4jeuZ37bR+m=20
0h5SY9UyAISegSwCmtwr457FqeC+V52vlrkYZy06+yxaOaeXd3pP9GZ2o0CLhqcP=20
cOva6Nt8OIemdKa6H1xm/V7uLqkJXl1xx3zEcONpzijmUS+2L6v4L3yhZQewif3d=20
Ms0rECbXfF8tmuDxn8MB=20
=3DP322=20
-----END PGP SIGNATURE-----=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

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
