From: Sage Weil <sage@newdream.net>
Subject: Re: Print error into debug log by default
Date: Thu, 23 Mar 2017 11:59:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703231158210.30468@piezo.novalocal>
References: <CY4PR10MB15917429D6B014495D0CE42EE43F0@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60958 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbdCWL7a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 07:59:30 -0400
In-Reply-To: <CY4PR10MB15917429D6B014495D0CE42EE43F0@CY4PR10MB1591.namprd10.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 23 Mar 2017, Wang, Zhiye wrote:
> Dear all,
> 
> This is a small problem. I was not able to figure out the way to open an issue, so I just share it here.
> 
> After some wrong operation steps (run ceph-osd command using root), I was not be able to start ceph-osd anymore. I can see the following stack in debug log.
> 
> 
> 2017-03-22 02:23:54.054907 7f0e87d8b940 -1 osd.0 0 failed to load OSD map for epoch 71, got 0 bytes
> 2017-03-22 02:23:54.056361 7f0e87d8b940 -1 /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/osd/OSD.h: In function 'OSDMapRef OSDService::get_map(epoch_t)' thread 7f0e87d8b940 time 2017-03-22 02:23:54.054921
> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/osd/OSD.h: 997: FAILED assert(ret)
> 
>  ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x85) [0x7f0e88869b35]
>  2: (OSDService::get_map(unsigned int)+0x3d) [0x7f0e8825d13d]
>  3: (OSD::init()+0x1fd2) [0x7f0e8820a452]
>  4: (main()+0x2cda) [0x7f0e8813bf4a]
>  5: (__libc_start_main()+0xf5) [0x7f0e8460cb15]
>  6: (()+0x413da9) [0x7f0e881b7da9]
> 
> 
> After dig this for problem for some time, I finally realize it should a problem of file permission (because of my previous wrong operation). The problem is that there was no tip in debug log.
> 
> Look at the source code, I guess it's because we do not print file open error debug log in FileStore::lfn_open by default. Please correct me if I am wrong. I'd suggest we can always print error message into debug log.
> 
>   r = ::open((*path)->path(), flags, 0644);
>   if (r < 0) {
>     r = -errno;
>     dout(10) << "error opening file " << (*path)->path() << " with flags="
>       << flags << ": " << cpp_strerror(-r) << dendl;
>     goto fail;
>   }

At this layer we can get ENOENT as a normal event (some client 
request asks for an object that doesn't exist), so it doesn't make sense 
to log an error here.  The get_map() method should probably be modified to 
indicate that it failed to load map epoch N (using derr) before asserting 
or calling ceph_abort().

Thanks!
sage

