From: David Butterfield <dab21774@gmail.com>
Subject: Adaptation of iSCSI-SCST to run entirely in usermode on unmodified kernel
Date: Fri, 21 Apr 2017 14:18:19 -0600
Message-ID: <CALiN7ry0en6UgyeuXJZm48pQuBhpOUjjZkZstzFz2oH0dmOHpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36692 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161437AbdDUUSV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Apr 2017 16:18:21 -0400
Received: by mail-vk0-f42.google.com with SMTP id q78so16424830vke.3
        for <ceph-devel@vger.kernel.org>; Fri, 21 Apr 2017 13:18:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This may be of interest, running SCST as an iSCSI server entirely in usermode.
It uses regular socket calls on the network and preadv/pwritev on the
backing store.
It looks like it would be straightforward to adapt it to make direct
calls to librados.

One thing mentioned in the paper is that with iSCSI/SCST running entirely in
usermode using regular system calls, iSCSI/SCST could be compiled not only on
Linux systems, but on any POSIX-style system with gcc and the other libraries
(e.g. freebsd).

https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_Usermode.html

Regards,
David Butterfield
-----------------

iSCSI-SCST Storage Server Usermode Adaptation
An adaptation of the iSCSI-SCST storage server software to run
entirely in usermode on an unmodified kernel
David A. Butterfield

This paper describes an adaptation of the iSCSI-SCST storage server software to
run entirely in usermode on an unmodified Linux kernel; performance
measurements and model; and an experimental algorithm to improve performance
for small Read operations.

In a standard installation of SCST the iscsi-scstd daemon runs as a
single-threaded Linux usermode process that cooperates with the kernel-resident
SCST datapath implementation using ioctl(2) and netlink(7) for communication.

In the iSCSI-SCST Usermode Adaptation the iscsi-scstd daemon runs on the main
thread in a multi-threaded process in which other usermode threads are
concurrently providing the services and executing the SCST code that would be
running inside the kernel in a standard installation of SCST.

The iSCSI server executable program can run as a regular (non-super) user, as
long as it has permission to access the backing storage (file or block device).
Administration is done in the usual SCST way using scstadmin, which accesses
the running server program through a fuse-mounted filesystem implemented using
a shim to connect the SCST procfs calls with the fuse(8) filesystem API.

The subset of SCST used supports the iSCSI transport type and SCSI Block
Commands (vdisk).  It includes the SCST Core, the iSCSI daemon and kernel
logic, the vdisk device, and the /proc interface; comprising about 80,000 lines
of SCST source code.  To support running in usermode, around 55 (fifty-five)
lines of executable C code had to be added or changed in SCST source files.

For a single session over 1 Gb Ethernet being serviced by a single 2.4 GHz CPU:
the described Adaptive Nagle optimization improves peak throughput performance
for 512-Byte Random Read of /dev/zero from around 63,000 IOPS to more than
100,000 IOPS, with no adverse impact below Queue Depth 17.

Paper:  https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_Usermode.html
Code:   https://github.com/DavidButterfield/SCST-Usermode-Adaptation
