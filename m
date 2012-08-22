From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 07:35:28 -0500
Message-ID: <5034D210.8060109@inktank.com>
References: <50349E62.90405@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52086 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab2HVMfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 08:35:31 -0400
Received: by yhmm54 with SMTP id m54so599133yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 05:35:30 -0700 (PDT)
In-Reply-To: <50349E62.90405@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

On 08/22/2012 03:54 AM, Denis Fondras wrote:
> Hello all,

Hello!

David had some good comments in his reply, so I'll just add in a couple 
of extra thoughts...

>
> I'm currently testing Ceph. So far it seems that HA and recovering are
> very good.
> The only point that prevents my from using it at datacenter-scale is
> performance.
>
> First of all, here is my setup :
> - 1 OSD/MDS/MON on a Supermicro X9DR3-F/X9DR3-F (1x Intel Xeon E5-2603 -
> 4 cores and 8GB RAM) running Debian Sid/Wheezy and Ceph version 0.49

Not sure what version of glibc Wheezy has, but try to make sure you have 
one that supports syncfs (you'll also need a semi-new kernel, 3.0+ 
should be fine).

> (commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac). It has 1x 320GB drive
> for the system, 1x 64GB SSD (Crucial C300 - /dev/sda) for the journal
> and 4x 3TB drive (Western Digital WD30EZRX). Everything but the boot
> partition is BTRFS-formated and 4K-aligned.
> - 1 client (P4 3.00GHz dual-core, 1GB RAM) running Debian Sid/Wheezy and
> Ceph version 0.49 (commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac).
> Both servers are linked over a 1Gb Ethernet switch (iperf shows about
> 960Mb/s).
>
> Here is my ceph.conf :
> ------cut-here------
> [global]
> auth supported = cephx
> keyring = /etc/ceph/keyring
> journal dio = true
> osd op threads = 24
> osd disk threads = 24
> filestore op threads = 6
> filestore queue max ops = 24
> osd client message size cap = 14000000
> ms dispatch throttle bytes = 17500000
>

default values are quite a bit lower for most of these.  You may want to 
play with them and see if it has an effect.

> [mon]
> mon data = /home/mon.$id
> keyring = /etc/ceph/keyring.$name
>
> [mon.a]
> host = ceph-osd-0
> mon addr = 192.168.0.132:6789
>
> [mds]
> keyring = /etc/ceph/keyring.$name
>
> [mds.a]
> host = ceph-osd-0
>
> [osd]
> osd data = /home/osd.$id
> osd journal = /home/osd.$id.journal
> osd journal size = 1000
> keyring = /etc/ceph/keyring.$name
>
> [osd.0]
> host = ceph-osd-0
> btrfs devs = /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201
> btrfs options = rw,noatime

Just fyi, we are trying to get away from btrfs devs.

> ------cut-here------
>
> Here are some figures :
> * Test with "dd" on the OSD server (on drive
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 123,746 s, 139 MB/s

Good job using a data file that is much bigger than main memory! That 
looks pretty accurate for a 7200rpm spinning disk.  For dd benchmarks, 
you should probably throw in conv=fdatasync at the end though.

>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 0,00 0,00 0,52 41,99 0,00 57,48
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sdf 247,00 0,00 125520,00 0 125520
>
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz to the OSD
> server (on drive
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :
> # time tar xzf src.tar.gz
> real 0m9.669s
> user 0m8.405s
> sys 0m4.736s
>
> # time rm -rf *
> real 0m3.647s
> user 0m0.036s
> sys 0m3.552s
>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 10,83 0,00 28,72 16,62 0,00 43,83
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sdf 1369,00 0,00 9300,00 0 9300
>
> * Test with "dd" from the client using RBD :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 406,941 s, 42,2 MB/s

RBD caching should definitely be enabled for a test like this.  I'd be 
surprised if you got 42MB/s without it though...

>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 4,57 0,00 30,46 27,66 0,00 37,31
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sda 317,00 0,00 57400,00 0 57400
> sdf 237,00 0,00 88336,00 0 88336
>
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the
> client using RBD :
> # time tar xzf src.tar.gz
> real 0m26.955s
> user 0m9.233s
> sys 0m11.425s
>
> # time rm -rf *
> real 0m8.545s
> user 0m0.128s
> sys 0m8.297s
>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 4,59 0,00 24,74 30,61 0,00 40,05
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sda 239,00 0,00 54772,00 0 54772
> sdf 441,00 0,00 50836,00 0 50836
>
> * Test with "dd" from the client using CephFS :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 338,29 s, 50,8 MB/s
>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 2,26 0,00 20,30 27,07 0,00 50,38
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sda 710,00 0,00 58836,00 0 58836
> sdf 722,00 0,00 32768,00 0 32768
>
>
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the
> client using CephFS :
> # time tar xzf src.tar.gz
> real 3m55.260s
> user 0m8.721s
> sys 0m11.461s
>

Ouch, that's taking a while!  In addition to the comments that David 
made, be aware that you are also testing the metadata server with 
cephFS.  Right now that's not getting a lot of attention as we are 
primarily focusing on RADOS performance at the moment.  For this kind of 
test though, distributed filesystems will never be as good as local disks...

> # time rm -rf *
> real 9m2.319s
> user 0m0.320s
> sys 0m4.572s
>
> => iostat (on the OSD server) :
> avg-cpu: %user %nice %system %iowait %steal %idle
> 14,40 0,00 15,94 2,31 0,00 67,35
>
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn
> sda 174,00 0,00 10772,00 0 10772
> sdf 527,00 0,00 3636,00 0 3636
>
> => from top :
> PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
> 4070 root 20 0 992m 237m 4384 S 90,5 3,0 18:40.50 ceph-osd
> 3975 root 20 0 777m 635m 4368 S 59,7 8,0 7:08.27 ceph-mds
>
>
> Adding an OSD doesn't change much of these figures (and it is always for
> a lower end when it does).

Are you putting both journals on the SSD when you add an OSD?  If so, 
what's the throughput your SSD can sustain?

> Neither does migrating the MON+MDS on the client machine.
>
> Are these figures right for this kind of hardware ? What could I try to
> make it a bit faster (essentially on the CephFS multiple little files
> side of things like uncompressing Linux kernel source or OpenBSD sources) ?
>
> I see figures of hundreds of megabits on some mailing-list threads, I'd
> really like to see this kind of numbers :D

With a single OSD and 1x replication on 10GbE I can sustain about 
110MB/s with 4MB writes if the journal is on an alternate disk.  I've 
also got some hardware though that does much worse than that (I think 
due to raid controller interference).  50MB/s does seem kind of low for 
cephFS in your dd test.

You may want to check and see how big the IOs going to disk are on the 
OSD node, and how quickly you are filling up the journal vs writing out 
to disk.  "collectl -sD -oT" will give you a nice report.  Iostat can 
probably tell you all of the same stuff with the right flags.

>
> Thank you in advance for any pointer,
> Denis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

