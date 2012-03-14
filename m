From: Sage Weil <sage@newdream.net>
Subject: Re: timed out in osd1 error in dmes
Date: Wed, 14 Mar 2012 10:59:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203141057030.11925@cobra.newdream.net>
References: <loom.20120313T083325-276@post.gmane.org> <4F5FACD8.8090902@dreamhost.com>
 <loom.20120314T051739-894@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53022 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688Ab2CNR7Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 13:59:25 -0400
In-Reply-To: <loom.20120314T051739-894@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 14 Mar 2012, madhusudhana wrote:
> Josh Durgin <josh.durgin <at> dreamhost.com> writes:
> 
> > 
> > On 03/13/2012 12:35 AM, madhusudhana wrote:
> > > Hi all,
> > > The server in which i have mounted file system using mount -t ceph
> > > is showing below errors in dmesg.
> > >
> > >
> > > libceph:  tid 79987 timed out on osd2, will reset osd
> > > libceph:  tid 81516 timed out on osd0, will reset osd
> > > libceph:  tid 81133 timed out on osd1, will reset osd
> > > libceph: skipping osd1 10.25.12.127:6800 seq 1 expected 2
> > > libceph:  tid 80108 timed out on osd2, will reset osd
> > > libceph:  tid 81134 timed out on osd1, will reset osd
> > > libceph:  tid 81641 timed out on osd1, will reset osd
> > >
> > >
> > > Is is because of this, write/copy operation in my cluster
> > > is slow ? is this a error which needs attention or can be
> > > safely ignored ?
> > 
> > These are usually harmless, and could just mean the osds can't keep up 
> > with the requests you're giving them. Given your other issues, it might 
> > be a symptom of a problem with your osds.
> > 
> > What filesystem are the osds using? Are there any warnings from these 
> > filesystems in dmesg?
> 
> All my osd's are using btrfs.  below are the dmesg tailed from all osd's

Heh, I should read my mail in order.  It sounds like the cp's are probably 
slow due to the OSDs.  

> ceph-node-6
> generic-usb 0003:0603:00F2.0004: input,hiddev0: USB HID v1.10 Device [NOVATEK 
> USB Keyboard] on usb-0000:00:1d.1-1/input1
> usb 5-1: USB disconnect, device number 3
> device fsid aed12ad8-4053-4066-9074-9a9f2419c03f devid 1 transid 7 /dev/sda5
> device fsid aed12ad8-4053-4066-9074-9a9f2419c03f devid 1 transid 7 /dev/sda5
> device fsid ee29fef4-5e07-4be7-bf2c-592e3b9fa62b devid 1 transid 7 /dev/sda5
> device fsid ee29fef4-5e07-4be7-bf2c-592e3b9fa62b devid 1 transid 7 /dev/sda5
> device fsid ee29fef4-5e07-4be7-bf2c-592e3b9fa62b devid 1 transid 12 /dev/sda5
> btrfs: truncated 1 orphans
> btrfs: truncated 1 orphans

These are harmless noise, BTW, you can ignore them.

Can you tell us how your OSDs are configured?  Where are the data 
directories and journals located?  (The [osd] section of ceph.conf would 
be helpful.)

Another useful piece of information would be the ceph-osd's raw 
performance writing to the local disk+journal, which you can get with

 $ ceph tell osd.0 bench

You might want to check it for several nodes to see if it's consistent, 
etc.

Thanks!
sage



> ceph-node-7
> device fsid 7baa8339-8d1e-4cca-9e61-c5f9bd4c3ab0 devid 1 transid 10 /dev/sda5
> device fsid b8aa714a-347a-4d6c-8bae-8a732bfc380f devid 1 transid 13 /dev/sda4
> device fsid 3c3a56cf-2d00-4fea-a49d-c2cb19af1ea2 devid 1 transid 7 /dev/sda5
> device fsid 3c3a56cf-2d00-4fea-a49d-c2cb19af1ea2 devid 1 transid 7 /dev/sda5
> device fsid b8aa714a-347a-4d6c-8bae-8a732bfc380f devid 1 transid 13 /dev/sda4
> device fsid 7c3d2b55-118f-447e-9e65-767005893fec devid 1 transid 7 /dev/sda5
> device fsid 7c3d2b55-118f-447e-9e65-767005893fec devid 1 transid 7 /dev/sda5
> device fsid b8aa714a-347a-4d6c-8bae-8a732bfc380f devid 1 transid 13 /dev/sda4
> device fsid 7c3d2b55-118f-447e-9e65-767005893fec devid 1 transid 12 /dev/sda5
> btrfs: truncated 1 orphans
> 
> ceph-node-8
> usb 5-1: New USB device found, idVendor=0603, idProduct=00f2
> usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 5-1: Product: USB Keyboard
> usb 5-1: Manufacturer: NOVATEK
> input: NOVATEK USB Keyboard as /devices/pci0000:00/0000:00:1d.1/usb5/5-1/5-
> 1:1.0/input/input3
> generic-usb 0003:0603:00F2.0001: input: USB HID v1.10 Keyboard [NOVATEK USB 
> Keyboard] on usb-0000:00:1d.1-1/input0
> input: NOVATEK USB Keyboard as /devices/pci0000:00/0000:00:1d.1/usb5/5-1/5-
> 1:1.1/input/input4
> generic-usb 0003:0603:00F2.0002: input,hiddev0: USB HID v1.10 Device [NOVATEK 
> USB Keyboard] on usb-0000:00:1d.1-1/input1
> usb 5-1: USB disconnect, device number 2
> btrfs: truncated 1 orphans
> 
> do you see any issue with osd? all 3 osd's are showing "btrfs: truncated 1 
> orphans" error.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
