From: kefu chai <tchaikov@gmail.com>
Subject: Re: Ceph installation packages on Ubuntu
Date: Thu, 29 Dec 2016 14:55:47 +0800
Message-ID: <CAJE9aOP1NAu1GFgV_4hLNx-UZmyO1h+W-Q5t0c_nYxtVYBp+mw@mail.gmail.com>
References: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:34654 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbcL2Gzt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 01:55:49 -0500
Received: by mail-wj0-f181.google.com with SMTP id sd9so166964369wjb.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Dec 2016 22:55:49 -0800 (PST)
In-Reply-To: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tone Zhang <tone.zhang@linaro.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 21, 2016 at 4:21 PM, Tone Zhang <tone.zhang@linaro.org> wrote:
> Hi Cephers,
>
> In recent, I tried to deploy Ceph cluster on Ubuntu 16.04 on ARM
> platform via "ceph-deploy".
>
> When I ran "ceph-deploy install" command, I got "cannot find ceph-osd"
> and "ceph-mon". I checked the ceph download center for Ubuntu on ARM
> (https://download.ceph.com/debian-jewel/pool/main/c/ceph/), it seems
> since Ceph 10.2.4, there is no deb packages for ARM any more. What's
> happened? Does it mean ceph jewel delivery on ARM platform will be
> stopped?


also i noticed that the aarch64 gitbuilder has been failing since v10.2.3. but
the reason of failure is still unknown. @Tone can you reproduce this in your
environment? if not, it's very likely environmental issues in our gitbuilder.

quote from http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-xenial-aarch64-basic/log.cgi?log=ecc23778eb545d8dd55e2e4735b53cc93f92e65b
<quote>
dpkg-deb: building package 'libcephfs-jni' in
'../libcephfs-jni_10.2.3-1xenial_arm64.deb'.

make: *** wait: No child processes. Stop.

make: *** Waiting for unfinished jobs....

make: *** wait: No child processes. Stop.
</quote>
so v10.2.3 build on aarch64 failed.

quote from http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-xenial-aarch64-basic/log.cgi?log=9411351cc8ce9ee03fbd46225102fe3d28ddf611

<quote>
dpkg-deb: building package 'python-rbd' in
'../python-rbd_10.2.4-1xenial_arm64.deb'.
dpkg-deb --build debian/python-cephfs ..
dpkg-deb: building package 'python-cephfs' in
'../python-cephfs_10.2.4-1xenial_arm64.deb'.
dpkg-deb --build debian/libcephfs-jni ..
dpkg-deb: building package 'libcephfs-jni' in
'../libcephfs-jni_10.2.4-1xenial_arm64.deb'.
debian/rules:112: recipe for target 'binary-arch' failed
</quote>
so v10.2.4 build on aarch64 failed also.



>
> If I want to deploy Ceph jewel 10.2.2 via ceph-deploy, how shall I do?
> Except download all the deb packaged for 10.2.2 and install ceph
> manually, is there an easier way?
>
> Thanks a lot!
>
> Br,
> Tone
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
