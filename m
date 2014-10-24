From: Sage Weil <sage@newdream.net>
Subject: Re: Having issues trying to get the OSD up on a MIPS64!!!
Date: Thu, 23 Oct 2014 17:53:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410231749420.13498@cobra.newdream.net>
References: <loom.20141023T030922-990@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51346 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbaJXAxf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 20:53:35 -0400
In-Reply-To: <loom.20141023T030922-990@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Prashanth Nednoor <Prashanth.nednoor@taec.toshiba.com>
Cc: ceph-devel@vger.kernel.org

Hi Prashanth,

On Thu, 23 Oct 2014, Prashanth Nednoor wrote:
> Hello Everyone,
> 
> We are using ceph-0.86, good news is we were able to compile and load 
> all the libraries and binaries needed to configure a CEPH-OSD on MIPS 64 
> platform. The CEPH monitor is also able to detect the OSD, but not up 
> yet, as the osd activate failed.
> Since we don?t have the required CEPH deploy utility for MIPS64, we are 
> following the manual procedure to create and activate an OSD.
> We have disabled authentication between the clients and the OSD?s for 
> now.
> 
> Has any body tried CEPH on a MIPS64?
> /dev/sda is a 2TB local hard drive.
> 
> This is how my partition looks after ceph-disk-prepare
> /home/prashan/ceph-0.86/src# parted
> GNU Parted 2.3
> Using /dev/sda
> Welcome to GNU Parted! Type 'help' to view a list of commands.
> (parted) p
> Model: ATA TOSHIBA MQ01ABB2 (scsi)
> Disk /dev/sda: 2000GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: gpt
> 
> Number  Start   End     Size    File system  Name          Flags
>  2      1049kB  5369MB  5368MB               ceph journal
>  1      5370MB  2000GB  1995GB  xfs          ceph data
> 
> 
> 
> The following are the steps to create an OSD
> 1)	ceph-disk zap /dev/sda
> 2)	ceph-disk-prepare --cluster  f615496c-b40a-4905-bbcd-
> 2d3e181ff21a --fs-type xfs /dev/sda
> 3)	mount /dev/sda1 /var/lib/ceph/osd/ceph-0/
> 4)	ceph-osd -i 0 ?mkfs is giving an error , 
> filestore(/var/lib/ceph/osd/ceph-0) could not find 
> 23c2fcde/osd_superblock/0//-1 in index: (2) No such file.
> After this it segfaults. We have analyzed this further with the help of 
> strace and root caused this as objectmap file reading issue.
> open("/var/lib/ceph/osd/ceph-0/current/omap/000005.log", O_RDONLY) = 11, 
> the first time it reads 32k, the read succeeds with 63 bytes and it
> tries to read again with 27k and the read returns 0 bytes and the CEPH 
> osd segfaults.

Can you generate a full log with --debug-osd 20 --debug-filestore 20 
--debug-jouranl 20 passed to ceph-osd --mkfs and post that somewhere?  It 
should tell us where things are going wrong.  In particular, we want to 
see if that file/object is being written properly.  It will also have a 
backtrace showing exactly where it crashed.

> Please note that ceph-disk prepare creates a journal in a path which is 
> not valid(dev/disk/by-partuuid/cbd4a5d1-012f-4863-b492-080ad2a505cb).
> So after step3 above I remove this journal below and manually create a 
> journal file before doing step4 above.
> 
> 
> ls -l /var/lib/ceph/osd/ceph-0/
> total 16
> -rw-r--r-- 1 root root 37 Oct 22 21:40 ceph_fsid
> -rw-r--r-- 1 root root 37 Oct 22 21:40 fsid
> lrwxrwxrwx 1 root root 58 Oct 22 21:40 journal -> /dev/disk/by-
> partuuid/cbd4a5d1-012f-4863-b492-080ad2a505cb

Is there anything in /dev/disk/by-partuuid/ or is it missing entirely?  
Maybe you have an old udev.  What distro is this?

sage

> -rw-r--r-- 1 root root 37 Oct 22 21:40 journal_uuid
> -rw-r--r-- 1 root root 21 Oct 22 21:40 magic
> 
> Any pointers to move ahead will be greatly appreciated??
> 
> thanks
> Prashanth
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
