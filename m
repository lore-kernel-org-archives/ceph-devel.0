From: Ilya Dryomov <idryomov@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Reboot_blocked_when_undoing_unmap_op=2E?=
Date: Mon, 4 Jan 2016 19:21:49 +0300
Message-ID: <CAOi1vP8tY=vPGG6-tpmR2Ci_Zo1S9=q4XdYhJNq4BZ+TVNO0zg@mail.gmail.com>
References: <47D132BF400BE64BAE6D71033F7D3D7518DD2C@H3CMLB12-EX.srv.huawei-3com.com>
	<CAOi1vP-eP_unRJFkZ-z2bQyWOcnpxnV+zBk1pRt2Q1OLnSU79Q@mail.gmail.com>
	<47D132BF400BE64BAE6D71033F7D3D7503DEF839@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37624 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbcADQVv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 11:21:51 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so221091819wmf.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jan 2016 08:21:50 -0800 (PST)
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7503DEF839@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 4, 2016 at 10:51 AM, Wukongming <wu.kongming@h3c.com> wrote:
> Hi, Ilya,
>
> It is an old problem.
> When you say "when you issue a reboot, daemons get killed and the kernel client ends up waiting for the them to come back, because of outstanding writes issued by umount called by systemd (or whatever)."
>
> Do you mean if umount rbd successfully, the process of kernel client will stop waiting? What kind of Communication mechanism between libceph and daemons(or ceph userspace)?

If you umount the filesystem on top of rbd and unmap rbd image, there
won't be anything to wait for.  In fact, if there aren't any other rbd
images mapped, libceph will clean up after itself and exit.

If you umount the filesystem on top of rbd but don't unmap the image,
libceph will remain there, along with some amount of communication
(keepalive messages, watch requests, etc).  However, all of that is
internal and is unlikely to block reboot.

If you don't umount the filesystem, your init system will try to umount
it, issuing FS requests to the rbd device.  We don't want to drop those
requests, so, if daemons are gone by then, libceph ends up blocking.

Thanks,

                Ilya
