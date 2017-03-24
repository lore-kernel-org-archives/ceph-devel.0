From: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Subject: RE: Print error into debug log by default
Date: Fri, 24 Mar 2017 03:01:06 +0000
Message-ID: <CY4PR10MB159116D3B2FB5D84FA380EFCE43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
References: <CY4PR10MB15917429D6B014495D0CE42EE43F0@CY4PR10MB1591.namprd10.prod.outlook.com>
 <alpine.DEB.2.11.1703231158210.30468@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:35283
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754298AbdCXDBL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 23:01:11 -0400
In-Reply-To: <alpine.DEB.2.11.1703231158210.30468@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage.=20

Currently, it seems the return value of " FileStore::lfn_open" assigned to =
a boolen variable in "OSDService::_get_map_bl". That causes upper has no kn=
owledge why the operation was failed.=20

Maybe we can change the return value of "OSDService::_get_map_bl" to "int",=
 and then print failure reason in "OSDService::try_get_map".


bool OSDService::_get_map_bl(epoch_t e, bufferlist& bl)
{
  bool found =3D map_bl_cache.lookup(e, &bl);
  if (found)
    return true;
  found =3D store->read(coll_t::meta(),
		      OSD::get_osdmap_pobject_name(e), 0, 0, bl) >=3D 0;
  if (found)
    _add_map_bl(e, bl);
  return found;
}


Thanks
Zhiye




-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Thursday, March 23, 2017 7:59 PM
To: Wang, Zhiye <Zhiye.Wang@Arcserve.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: Print error into debug log by default

On Thu, 23 Mar 2017, Wang, Zhiye wrote:
> Dear all,
>=20
> This is a small problem. I was not able to figure out the way to open an =
issue, so I just share it here.
>=20
> After some wrong operation steps (run ceph-osd command using root), I was=
 not be able to start ceph-osd anymore. I can see the following stack in de=
bug log.
>=20
>=20
> 2017-03-22 02:23:54.054907 7f0e87d8b940 -1 osd.0 0 failed to load OSD=20
> map for epoch 71, got 0 bytes
> 2017-03-22 02:23:54.056361 7f0e87d8b940 -1=20
> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_A
> RCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/relea
> se/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/osd/OSD.h: In function=20
> 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f0e87d8b940 time=20
> 2017-03-22 02:23:54.054921
> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_A
> RCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/relea
> se/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/osd/OSD.h: 997: FAILED=20
> assert(ret)
>=20
>  ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char=20
> const*)+0x85) [0x7f0e88869b35]
>  2: (OSDService::get_map(unsigned int)+0x3d) [0x7f0e8825d13d]
>  3: (OSD::init()+0x1fd2) [0x7f0e8820a452]
>  4: (main()+0x2cda) [0x7f0e8813bf4a]
>  5: (__libc_start_main()+0xf5) [0x7f0e8460cb15]
>  6: (()+0x413da9) [0x7f0e881b7da9]
>=20
>=20
> After dig this for problem for some time, I finally realize it should a p=
roblem of file permission (because of my previous wrong operation). The pro=
blem is that there was no tip in debug log.
>=20
> Look at the source code, I guess it's because we do not print file open e=
rror debug log in FileStore::lfn_open by default. Please correct me if I am=
 wrong. I'd suggest we can always print error message into debug log.
>=20
>   r =3D ::open((*path)->path(), flags, 0644);
>   if (r < 0) {
>     r =3D -errno;
>     dout(10) << "error opening file " << (*path)->path() << " with flags=
=3D"
>       << flags << ": " << cpp_strerror(-r) << dendl;
>     goto fail;
>   }

At this layer we can get ENOENT as a normal event (some client request asks=
 for an object that doesn't exist), so it doesn't make sense to log an erro=
r here.  The get_map() method should probably be modified to indicate that =
it failed to load map epoch N (using derr) before asserting or calling ceph=
_abort().

Thanks!
sage

