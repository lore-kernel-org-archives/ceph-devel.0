From: Gregory Farnum <greg@inktank.com>
Subject: Re:
Date: Tue, 23 Oct 2012 22:58:54 -0700
Message-ID: <162E8EA1E858481C9CD55412C597577E@inktank.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
 <50868471.1070105@widodh.nl>
 <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54667 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470Ab2JXF64 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 01:58:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so135854pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 22:58:56 -0700 (PDT)
In-Reply-To: <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On Tuesday, October 23, 2012 at 10:48 PM, jie sun wrote:
> My vm kernel version is "Linux ubuntu12 3.2.0-23-generic".
> 
> "ceph-s" shows
> " health HEALTH_OK
> monmap e1: 1 mons at {a=10.100.211.146:6789/0}, election epoch 0, quorum 0 a
> osdmap e152: 10 osds: 9 up, 9 in
> pgmap v48479: 2112 pgs: 2112 active+clean; 23161 MB data, 46323 MB
> used, 2451 GB / 2514 GB avail
> mdsmap e31: 1/1/1 up {0=a=up:active} "
> 
> In my vm, I do operations like:
> I install 4 debs on my vm, such as libnss3, libnspr4, librados2,
> librbd1. And then execute "modprobe rbd" so that I can map a image to
> my vm.
> Then "rbd create foo --size 10240 -m $monIP(my ceph mon IP)",
> "rbd map foo -m $monIP" ------ Here a device /dev/rbd0 can be
> used as a local device
> "mkfs -t ext4 /dev/rbd0"
> "mount /dev/rbd0 /mnt(or some other directory)"
> After the operations above, I can use this device. But it oftern
> prompt some log like "libceph: osd9 10.100.211.68:6809 socket closed".
> I just want to mount a device to my vm, so I didn't install a ceph
> client. Is this proper to do so?

You might consider using the native QEMU/libvirt instead; it offers some more advanced options. But if you're happy with it, this certainly works!

The "socket closed" messages are just noise; it's nothing to be concerned about (you'll notice they're happening every 15 minutes for each OSD; probably you aren't doing any disk accesses). I think these warnings actually got removed from our master branch a few days ago.
-Greg

