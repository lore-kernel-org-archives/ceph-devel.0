From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Usermode iSCSI-SCST updated to use Ceph RBD as backing storage
Date: Thu, 27 Apr 2017 16:18:58 -0400
Message-ID: <CA+aFP1AHdctAgbdc+pZ0NcY4PVvftc-LqqZES_td8XB5-u-APg@mail.gmail.com>
References: <CALiN7rz7kXB5ok_=XNAiufQBGVKOT8Lh4d_Uf3rE0nEDPWdpdw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34016 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756390AbdD0UTA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Apr 2017 16:19:00 -0400
Received: by mail-yb0-f171.google.com with SMTP id 8so10926847ybw.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Apr 2017 13:18:59 -0700 (PDT)
In-Reply-To: <CALiN7rz7kXB5ok_=XNAiufQBGVKOT8Lh4d_Uf3rE0nEDPWdpdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Butterfield <dab21774@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for sharing and contributing to the adoption of RBD.

For a point of comparison, I know that SPDK has recently introduced a
pure user-space iSCSI librbd backing device [1] and we are actively
working on deeply integrating librbd with LIO's TCMU [2] (which is
split kernel and user-space).

[1] https://github.com/spdk/spdk/blob/master/lib/bdev/rbd/blockdev_rbd.c
[2] https://github.com/open-iscsi/tcmu-runner/blob/master/rbd.c

On Thu, Apr 27, 2017 at 2:29 PM, David Butterfield <dab21774@gmail.com> wrote:
> An update on the port of SCST to run entirely in usermode:
>
> I've created a new branch "ceph_rbd" in my SCST-Usermode-Adaptation
> repository which includes a "shim" between the SCST BLOCKIO code (when
> running in usermode), and the Ceph librbd API.
>
> https://github.com/DavidButterfield/SCST-Usermode-Adaptation/blob/ceph_rbd/scst/src/dev_handlers/scst_vdisk_ceph_rbd.c
>
> This enables a purely usermode instance of SCST to serve iSCSI
> initiators in a TCP/IP network using calls to librbd for access to the
> backing store.  There is no SCST code running in the kernel -- the
> usermode server uses regular socket(2) calls for access to the network,
> with the iSCSI protocol interpreter and the core SCSI engine both
> running in usermode.
>
> Running the iSCSI/SCST/RBD server in usermode using regular socket calls
> opens the possibility of building it for non-Linux systems (e.g. FreeBSD).
>
> I just decided to write this shim to Ceph RBD three days ago, and got it
> working today, so consider it "alpha".  It doesn't handle everything
> perfectly right, but it runs, and read/write seem to be working.
>
> So far I've tested it by running an iSCSI session from another Linux
> machine (open-iscsi) to the usermode SCST/RBD server, exporting a 4GB
> image I created on the Ceph server: I copied some files in and out of it
> a few times, and compared the result with the original.  That worked.
>
> At the moment you have to compile it either to use local aio(7) calls or
> librbd calls -- making them work side-by-side is TBD.
>
> (The idea to connect the usermode iSCSI server with Ceph came to
> me from Adrian Saul.)
>
> On Fri, Apr 21, 2017 at 2:18 PM, David Butterfield <dab21774@gmail.com> wrote:
>> This may be of interest, running SCST as an iSCSI server entirely in usermode.
>> It uses regular socket calls on the network and preadv/pwritev on the
>> backing store.
>> It looks like it would be straightforward to adapt it to make direct
>> calls to librados.
>>
>> One thing mentioned in the paper is that with iSCSI/SCST running entirely in
>> usermode using regular system calls, iSCSI/SCST could be compiled not only on
>> Linux systems, but on any POSIX-style system with gcc and the other libraries
>> (e.g. freebsd).
>>
>> https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_Usermode.html
>>
>> Regards,
>> David Butterfield
>> -----------------
>>
>> iSCSI-SCST Storage Server Usermode Adaptation
>> An adaptation of the iSCSI-SCST storage server software to run
>> entirely in usermode on an unmodified kernel
>> David A. Butterfield
>>
>> This paper describes an adaptation of the iSCSI-SCST storage server software to
>> run entirely in usermode on an unmodified Linux kernel; performance
>> measurements and model; and an experimental algorithm to improve performance
>> for small Read operations.
>>
>> In a standard installation of SCST the iscsi-scstd daemon runs as a
>> single-threaded Linux usermode process that cooperates with the kernel-resident
>> SCST datapath implementation using ioctl(2) and netlink(7) for communication.
>>
>> In the iSCSI-SCST Usermode Adaptation the iscsi-scstd daemon runs on the main
>> thread in a multi-threaded process in which other usermode threads are
>> concurrently providing the services and executing the SCST code that would be
>> running inside the kernel in a standard installation of SCST.
>>
>> The iSCSI server executable program can run as a regular (non-super) user, as
>> long as it has permission to access the backing storage (file or block device).
>> Administration is done in the usual SCST way using scstadmin, which accesses
>> the running server program through a fuse-mounted filesystem implemented using
>> a shim to connect the SCST procfs calls with the fuse(8) filesystem API.
>>
>> The subset of SCST used supports the iSCSI transport type and SCSI Block
>> Commands (vdisk).  It includes the SCST Core, the iSCSI daemon and kernel
>> logic, the vdisk device, and the /proc interface; comprising about 80,000 lines
>> of SCST source code.  To support running in usermode, around 55 (fifty-five)
>> lines of executable C code had to be added or changed in SCST source files.
>>
>> For a single session over 1 Gb Ethernet being serviced by a single 2.4 GHz CPU:
>> the described Adaptive Nagle optimization improves peak throughput performance
>> for 512-Byte Random Read of /dev/zero from around 63,000 IOPS to more than
>> 100,000 IOPS, with no adverse impact below Queue Depth 17.
>>
>> Paper:  https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_Usermode.html
>> Code:   https://github.com/DavidButterfield/SCST-Usermode-Adaptation
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
