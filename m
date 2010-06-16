From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: simple performance tests
Date: Wed, 16 Jun 2010 07:45:47 -0700
Message-ID: <AANLkTikactG3sjz7mwC1620jM19_6N6W3IPTrbgmIpvr@mail.gmail.com>
References: <hva4nu$2nr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54254 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758560Ab0FPOpv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 10:45:51 -0400
Received: by gxk21 with SMTP id 21so1234570gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 07:45:50 -0700 (PDT)
In-Reply-To: <hva4nu$2nr$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

How's your CPU utilization on that processor? It'd be good if all
those daemons ran fine on an Atom but I'm not sure?
What's your config file look like? Journaling enabled?

On Wed, Jun 16, 2010 at 2:15 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> hi
>
> i've done some performance tests on a small system.
>
> HW:
> * Supermicro X7SPA-HF (with IMPI and KVMoverIP integrated))
> * Atom D510 1.6GHz DualCore and HT
> * WD RE3 500GB 7200umin disks
> * 4GB RAM
>
> SW:
> * Debian 5.0 "Lenny"
> * Kernel 2.6.32 (backports.org)
> * ceph/unstable
> * ceph-client-standalone/unstable-backport
>
> values are MB/s. all tests are local.
>
> dbench 1 results:
> * 1 disk, btrfs: 115
> * 2 disks, btrfs data/metadata raid0: 115
> * 1 osd/disk, 1 mds, 1 mon: 7
> * 2 osd/disk, 1 mds, 1mon: 6.2117
> * 1 disk, btrfs, samba: 14.02
> * 2 disks, btrfs data/metadata raid0, samba: 13.781
>
> dbench 10 results:
> * 1 disk, btrfs: 271.724
> * 2 disks, btrfs data/metadata raid0: 270.043
> * 1 osd/disk, 1 mds, 1 mon: -
> * 2 osd/disk, 1 mds, 1mon: 12.1862
> * 1 disk, btrfs, samba: 20.22
> * 2 disks, btfs data/metadata raid0, samba: 20.26
>
> dd bs=3D1M count=3D8192 if=3D/dev/zero
> * 1 disk, btrfs: 126
> * 2 disks, btrfs data/metadata raid0: =A0271
> * 1 osd/disk, 1 mds, 1 mon: -
> * 2 osd/disk, 1 mds, 1mon: 51.2
> * 1 disk, btrfs, samba: 95.2
> * 2 disks, btrfs data/metadata raid0, samba: 85.9
>
> will add a AOC-USAS-H8iR (LSI) RAID card to the mix if =A0i get the c=
ables
> needed.
>
> i'm a bit suprised about the low rates of ceph. i'll try to to the sa=
me
> tests on a more powerfull machine.
>
> - Thomas
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
