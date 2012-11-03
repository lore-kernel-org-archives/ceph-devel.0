From: Gregory Farnum <greg@inktank.com>
Subject: Re: Rados Performance help needed...
Date: Sat, 3 Nov 2012 18:36:04 +0100
Message-ID: <CAPYLRziYohzzS9p6B-5a=+txYNCM+_p+S9E3UoJOGf-wHv7mow@mail.gmail.com>
References: <F5955DC568F9AF4DB00BE0F7E950BE0C3490D064@BLUPRD0411MB438.namprd04.prod.outlook.com>
	<F5955DC568F9AF4DB00BE0F7E950BE0C3490D07F@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59811 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab2KCRgF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:36:05 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6363439iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:36:04 -0700 (PDT)
In-Reply-To: <F5955DC568F9AF4DB00BE0F7E950BE0C3490D07F@BLUPRD0411MB438.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Oct 31, 2012 at 11:55 PM, Ryan Nicholson
<Ryan.Nicholson@kcrg.com> wrote:
> Correction:
>
> Missed a carriage return when I copy/pasted at first, sorry...
>
> Ryan
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ryan Nicholson
> Sent: Wednesday, October 31, 2012 5:50 PM
> To: ceph-devel@vger.kernel.org
> Subject: Rados Performance help needed...
>
> Guys:
> I have some tuning questions. I'm not getting the write speeds I'm expecting, and am open to suggestions.
> I using Rados, on Ceph 0.48.0. I have 12 OSD's split up (using crush/rados pools) into 2 pools this way:
> 4 OSD Servers
>                 - Dell 2850's, 12GB ram
>                 - 64-bit CentOS 6.2
>                 - 2 SCSI osd's each
>                 - 1 eSATA osd each
>                 - Each server is connected to lan using 2GB/s bond
> 3 Separate Monitor Servers as well
>                 - Dell 1850's, 8 GB ram
> SCSI pool:
>                 8 OSD's of 146GB a piece, each made of a pair of Ultra-320 disks in a stripe.
>                 Disks are partitioned with 20GB at the front for Ceph journal, and the remainder is the OSD partition. Journal is for the OSD on the same disk.
>                 Formatted ext4, mounted (rw,noatime,data=writeback,barrier=0,nobh)
>
> Large "data" pool:
>                 4 OSD's of 3.2TB a piece, each made of an identically configured LaCie Big4 Disk Quadra.
>                 Each LaCie's specs are: 4TB of 7200RPM SATA, in a RAID-5 which is handled directly by the local hardware, and attached to the server using a 64-bit Sil3124 eSATA card.
>                 Note: The LaCie's do NOT support JBOD, believe it or not. you can stripe them tho.
>                 Formatted ext4, mounted (rw,noatime,data=writeback,barrier=0,nobh)
>                 Journal for these disks is an entire 146GB SCSI stripe each
>
>
> Ok, so here's my issue:
> As a test, I stopped ceph completely, and at each server, i did a simple disk/filesystem write/read test. here are those results:
> command: (dd if=10GB_testFile of /path-to-osd-mount/test.io BS=1048576)
>
>                 SCSI: 10GB file written at 365MB/s to a single SCSI stripe of 2 73GB Ultra-320's.
>                                 same 10GB file read fat 595MB/s.
>                 eSATA: (same) 10GB file written at 275MB/s to a single LaCie and I read that file back at 443MB/s.
>
> I understand that real life numbers and dd numbers are hardly ever the same.
> Now using ceph, I produced 2 identical Rados images called Test20G, and put in both of the pools. I know (leterally by watching the drive access lights) that the pools are created to the proper place and writing the desired drives. The images were mounted using the same client, and formatted ext4. i mounted (rw,noatime,data=writeback,barrier=0,nobh).
> i did the same dd test, and found the SCSI's to write average 105MB/s, and the LaCie's write averaged 25MB/s.

How did you create these "Rados images"? Do you mean RBD images? And
you then mounted them using the kernel rbd driver? What is your
client's network connection?
Well, keep in mind that when you went from your local dd to an RBD dd,
you added quite a bit of writing. Each data block is written to two
OSDs, and each of those OSDs writes the data to both its journal and
its backing store.

I'm not sure why your LaCie drives did so badly.

You can start some basic debugging by running "ceph -w" in a terminal,
leaving it open (to see the log), and then elsewhere running "ceph osd
tell \* bench", which will instruct each of your OSDs to do a basic
benchmark of its disk system. Let us know what those results look
like.
-Greg
