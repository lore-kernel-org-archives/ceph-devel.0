From: Travis Rhoden <trhoden@gmail.com>
Subject: can "rbd unmap" detect if device is mounted?
Date: Mon, 16 Jul 2012 15:59:16 -0400
Message-ID: <CACkq2mqt5ae4U_-yhNM94GYQnE_negqXqHTf3JaSZ0zsxya9Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39718 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab2GPT7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 15:59:38 -0400
Received: by bkwj10 with SMTP id j10so5078999bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 12:59:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

I've made this mistake a couple of times now (completely my fault,
when will I learn?), and am wondering if a bit of protection can be
put in place against user errors.

I mapped a device "rbd map", then formatted and and mounted the device
("mkfs.extf /dev/rbd0..., mount /dev/rbd0...").  Then sometime later,
I want to remove the RBD device.  Stupidly, I do the "rbd unmap"
command before I unmount the device.  The kernel doesn't really care
for this.  Or more accurately, I can't remap that same RBD because I
run into:

kernel: [2248653.941688] sysfs: cannot create duplicate filename
'/devices/virtual/block/rbd0'
....
kernel: [2248653.941833] kobject_add_internal failed for rbd0 with
-EEXIST, don't try to register things with the same name in the same
directory.

At this point, the "rbd map" command hangs indefinitely (producing the
logs from above).  Ctrl-C does exit out, though.  But if I try to fix
my mistake by doing the unmount now, I get the error:

umount: device is busy.

So really I get stuck.  I can't unmount without the device, and I
can't remap the device to the old block device.  I have to reboot to
clean up and move on.

I imagine other bad things can happen with the block device goes away
out from under the mount point.  Any way the "rbd unmap" command can
detect when the device is in use or mounted and inform the user?

Thanks,

 - Travis
