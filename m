From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Fri, 25 Nov 2011 19:54:42 +0100
Message-ID: <4ECFE472.9020603@widodh.nl>
References: <4366451.BU1d1YAr76@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38324 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1KYSyp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Nov 2011 13:54:45 -0500
In-Reply-To: <4366451.BU1d1YAr76@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hi Guido,

On 11/25/2011 05:53 PM, Guido Winkelmann wrote:
> Hi,
>
> When trying to mount a Ceph filesystem with "mount.ceph 10.3.1.33:6789:/ /mnt",
> the command hangs for several minutes and then fails with the message
>
> mount error 5 = Input/output error

Does "ceph -s" work? If so, what is the output?

>
> Background:
>
> I'm trying to set up a small 3-machine Ceph cluster, to be used for network-
> transparent block- and file storage for Qemu server virtualization. This is the
> first time I'm doing anything at all with Ceph, so many of the concepts are
> still new and a bit confusing to me.
>
> My plan was to set up each of the three machines equally with one mon, one osd
> and one mds, and to add more servers, or replace the existing ones with bigger
> machines, as need arises.

If should be enough to have 3 OSD's and 1 MON and 1 MDS, for basic 
testing that is all you'd need.

>
> So far, I have only started with one of the three servers, to get at least a
> basic configuration working and to get some feel for the system and its
> components, before adding the other two.
>
> The machines are all running a basic installation of CentOS 6. What I did so
> far on the first machine was:
>
> - Build a newer kernel (3.1.1) with built-in support for btrfs and ceph,
> reboot with it
> - Prepare two larger empty partitions (sda5 and sdb5) for data storage
> - Download and unpack ceph-0.38.tar.gz, cd ceph-0.38
> - Run ./configure
> - Repeat numerous times while installing one dependency after the other,
> eventually ending up with ./configure --without-fuse --without-tcmalloc

I'd recommend using tcmalloc, it will save a lot of memory usage.

> - make&&  make install
> - Copy src/init-ceph to /etc/init.d/
> - Create /usr/local/etc/ceph/ceph.conf with this content:
>
> [global]
>          max open files = 131072
>          log file = /var/log/ceph/$name.log
>          log_to_syslog = true
>          pid file = /var/run/ceph/$name.pid

You want to log to syslog and files simultaneously? That will cause 
double the I/O on that system.

>
> [mon]
>          mon data = /mondata/$name
>
> [mon.ceph1]
>          host = ceph1
>          mon addr = 10.3.1.33:6789
>
> [mds]
>          keyring = /cephxdata/keyring.$name
>

Why did you specify a keyring here? You did not enable the cephx 
authentication.

> [mds.alpha]
>          host = ceph1
>
> [osd]
>          osd data = /data/$name
>          osd journal = /data/$name/journal
>          osd journal size = 1000 ; journal size, in megabytes
>
> [osd.0]
>          host = ceph1
>          btrfs devs = /dev/sda5 /dev/sdb5
>

Does that actually work? Never tested with specifying to devices. What 
are you trying to do? Create a striped filesystem?

> (Slightly adjusted from src/sample.ceph.conf, comments removed for brevity)
>
> - Run mkcephfs -c /usr/local/etc/ceph/ceph.conf --mkbtrfs -a -k \
> /usr/local/etc/ceph/keyring.bin
> - Run /etc/init.d/ceph start
>
> After these steps, I tried to mount the ceph filesystem (on the same machine)
> with "mount.ceph 10.3.1.33:6789:/ /mnt" and got the aforementioned error.
>

Mounting the Ceph filesystem on the same host as where your OSD is 
running is not recommended. Although it should probably work, you could 
run into some trouble.

You could take a look at my ceph.conf: http://zooi.widodh.nl/ceph/ceph.conf

That might give you some more clues!

Wido

> The only thing that happens in the logs when I try to mount is this one line
> in mon log:
> 2011-11-25 17:26:53.216745 7f0ee75df700 -- 10.3.1.33:6789/0>>
> 10.3.1.33:0/1719960241 pipe(0x7f0ee0001320 sd=12 pgs=0 cs=0 l=0).accept peer
> addr is really 10.3.1.33:0/1719960241 (socket is 10.3.1.33:46908/0)
>
> The osd and mds logs do not show any activity at that point.
>
> Does anybody have any idea what could be going wrong here?
>
> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
