From: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Subject: Print error into debug log by default
Date: Thu, 23 Mar 2017 10:02:01 +0000
Message-ID: <CY4PR10MB15917429D6B014495D0CE42EE43F0@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4128
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751660AbdCWKCE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 06:02:04 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear all,

This is a small problem. I was not able to figure out the way to open an is=
sue, so I just share it here.

After some wrong operation steps (run ceph-osd command using root), I was n=
ot be able to start ceph-osd anymore. I can see the following stack in debu=
g log.


2017-03-22 02:23:54.054907 7f0e87d8b940 -1 osd.0 0 failed to load OSD map f=
or epoch 71, got 0 bytes
2017-03-22 02:23:54.056361 7f0e87d8b940 -1 /home/jenkins-build/build/worksp=
ace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIS=
T/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/os=
d/OSD.h: In function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f0e87=
d8b940 time 2017-03-22 02:23:54.054921
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x=
86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/=
rpm/el7/BUILD/ceph-11.2.0/src/osd/OSD.h: 997: FAILED assert(ret)

 ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0=
x85) [0x7f0e88869b35]
 2: (OSDService::get_map(unsigned int)+0x3d) [0x7f0e8825d13d]
 3: (OSD::init()+0x1fd2) [0x7f0e8820a452]
 4: (main()+0x2cda) [0x7f0e8813bf4a]
 5: (__libc_start_main()+0xf5) [0x7f0e8460cb15]
 6: (()+0x413da9) [0x7f0e881b7da9]


After dig this for problem for some time, I finally realize it should a pro=
blem of file permission (because of my previous wrong operation). The probl=
em is that there was no tip in debug log.

Look at the source code, I guess it's because we do not print file open err=
or debug log in FileStore::lfn_open by default. Please correct me if I am w=
rong. I'd suggest we can always print error message into debug log.

  r =3D ::open((*path)->path(), flags, 0644);
  if (r < 0) {
    r =3D -errno;
    dout(10) << "error opening file " << (*path)->path() << " with flags=3D=
"
      << flags << ": " << cpp_strerror(-r) << dendl;
    goto fail;
  }


Thanks
Mike


