From: Sage Weil <sage@inktank.com>
Subject: Re: mkcephfs failing on v0.48 "argonaut"
Date: Thu, 5 Jul 2012 15:17:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207051512360.21201@cobra.newdream.net>
References: <81C477727102DA4E9B2605AC748C495419104F51B3@exch10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33666 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab2GEWR7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 18:17:59 -0400
In-Reply-To: <81C477727102DA4E9B2605AC748C495419104F51B3@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Paul,

On Wed, 4 Jul 2012, Paul Pettigrew wrote:
> Firstly, well done guys on achieving this version milestone. I 
> successfully upgraded to the 0.48 format uneventfully on a live (test) 
> system.
> 
> The same system was then going through "rebuild" testing, to confirm 
> that also worked fine.
> 
> 
> Unfortunately, the mkcephfs command is failing:
> 
> root@dsanb1-coy:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k /etc/ceph/keyring --crushmapsrc crushfile.txt -v
> temp dir is /tmp/mkcephfs.GaRCZ9i06a
> preparing monmap in /tmp/mkcephfs.GaRCZ9i06a/monmap
> /usr/bin/monmaptool --create --clobber --add alpha 10.32.0.10:6789 --add bravo 10.32.0.25:6789 --add charlie 10.32.0.11:6789 --print /tmp/mkcephfs.GaRCZ9i06a/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.GaRCZ9i06a/monmap
> /usr/bin/monmaptool: generated fsid c7202495-468c-4678-b678-115c3ee33402
> epoch 0
> fsid c7202495-468c-4678-b678-115c3ee33402
> last_changed 2012-07-04 15:02:31.732275
> created 2012-07-04 15:02:31.732275
> 0: 10.32.0.10:6789/0 mon.alpha
> 1: 10.32.0.11:6789/0 mon.charlie
> 2: 10.32.0.25:6789/0 mon.bravo
> /usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.GaRCZ9i06a/monmap (3 monitors)
> /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.0 "user"
> === osd.0 ===
> --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.GaRCZ9i06a --prepare-osdfs osd.0
> umount: /srv/osd.0: not mounted
> umount: /dev/disk/by-wwn/wwn-0x50014ee601246234: not mounted
> 
> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
> WARNING! - see http://btrfs.wiki.kernel.org before using
> 
> fs created label (null) on /dev/disk/by-wwn/wwn-0x50014ee601246234
>         nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB
> Btrfs Btrfs v0.19
> Scanning for Btrfs filesystems
> mount: wrong fs type, bad option, bad superblock on /dev/sdc,
>        missing codepage or helper program, or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> 
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.GaRCZ9i06a --prepare-osdfs osd.0'

Hmm.  Can you try running with -v?  That will tell us exactly which 
command it is running, and hopefully we can work backwards from there.

> dmesg/syslog is spitting out at the time of this failure:
> 
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.751945] device fsid 7de0d192-b710-4629-a201-849df1d9db17 devid 1 transid 27109 /dev/sdp
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.751987] device fsid 08fc3479-2fa2-4388-8b61-83e2a742a13e devid 1 transid 28699 /dev/sdo
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.752023] device fsid 8b4a7c43-1a05-4dcb-bbed-de2a5c933996 devid 1 transid 24346 /dev/sdn
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.752068] device fsid ba5fb1ca-c642-49b1-8a41-7f56f8e59fbd devid 1 transid 27274 /dev/sdm
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761453] device fsid 7fe8c5cf-bf8c-4276-90f2-c3f57f5275fb devid 1 transid 28724 /dev/sdi
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761518] device fsid 93fa3631-1202-4d42-8908-e5ef4d3e600d devid 1 transid 25201 /dev/sdh
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761579] device fsid b9a1b5e4-3e5e-4381-a29a-33470f4b870f devid 1 transid 23375 /dev/sdg
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761635] device fsid 280ea990-23f8-4c43-9e56-140c82340fdc devid 1 transid 25559 /dev/sdf
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761693] device fsid 2f724cde-6de5-4262-b195-1ba3eea2256e devid 1 transid 176 /dev/sde
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761732] device fsid a66f890f-8b08-4393-aab0-f222637ca5a4 devid 1 transid 7 /dev/sdd
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761769] device fsid 6c181a94-697c-4e0c-af0d-05eb04d3626c devid 1 transid 7 /dev/sdc
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.775931] device fsid 6c181a94-697c-4e0c-af0d-05eb04d3626c devid 1 transid 7 /dev/sdc
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.779716] btrfs bad fsid on block 20971520
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.791594] btrfs bad fsid on block 20971520
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.803608] btrfs bad fsid on block 20971520
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.815541] btrfs bad fsid on block 20971520
> Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.815878] btrfs bad fsid on block 20971520
> Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.823554] btrfs bad fsid on block 20971520
> Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.823797] btrfs bad fsid on block 20971520
> Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.823887] btrfs: failed to read chunk root on sdc
> Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.825622] btrfs: open_ctree failed

Long shot, but is the kernel on that machine recent?

> Also fails if not forcing to use btrfs, eg:
> 
> root@dsanb1-coy:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -k /etc/ceph/keyring --crushmapsrc crushfile.txt -v
> temp dir is /tmp/mkcephfs.ZOh6tBPAH0
> preparing monmap in /tmp/mkcephfs.ZOh6tBPAH0/monmap
> /usr/bin/monmaptool --create --clobber --add alpha 10.32.0.10:6789 --add bravo 10.32.0.25:6789 --add charlie 10.32.0.11:6789 --print /tmp/mkcephfs.ZOh6tBPAH0/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.ZOh6tBPAH0/monmap
> /usr/bin/monmaptool: generated fsid adb8d65c-a823-4dc2-9415-22b0d7252699
> epoch 0
> fsid adb8d65c-a823-4dc2-9415-22b0d7252699
> last_changed 2012-07-04 15:04:17.423368
> created 2012-07-04 15:04:17.423368
> 0: 10.32.0.10:6789/0 mon.alpha
> 1: 10.32.0.11:6789/0 mon.charlie
> 2: 10.32.0.25:6789/0 mon.bravo
> /usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.ZOh6tBPAH0/monmap (3 monitors)
> /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.0 "user"
> === osd.0 ===
> --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.ZOh6tBPAH0 --init-daemon osd.0
> 2012-07-04 15:04:17.789064 7fc7fadca780 -1 filestore(/srv/osd.0) limited size xattrs -- enable filestore_xattr_use_omap
> 2012-07-04 15:04:17.789120 7fc7fadca780 -1 OSD::mkfs: couldn't mount FileStore: error -95
> 2012-07-04 15:04:17.789161 7fc7fadca780 -1  ** ERROR: error creating empty object store in /srv/osd.0: (95) Operation not supported
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.ZOh6tBPAH0 --init-daemon osd.0'
> 
> 
> Confirming all this was working previously, and the crushmap, config 
> file, etc are all proven to be OK (get same failure when not specifying 
> a custom crushmap also). Also note that whilst the above is failing on 
> osd.0 creation, I have swapped disk references and still get the same 
> failure on different HDD's when they are hooked in as osd.0

The only thing that changed from v0.47 is the below.  Can you try 
replacing 'btrfs device scan || btrfsctl -a' with 'btrfs device scan ; 
btrfsctl -a'?  Maybe the btrfs tool isn't being pendantic about return 
codes...

sage


commit a414fd51c7c5ae5dbe9e3af7db6f17741a58c1a7
Author: Sage Weil <sage.weil@dreamhost.com>
Date:   Sat Feb 11 13:43:23 2012 -0800

    init-ceph, mkcephfs: try 'btrfs device scan' before 'btrfsctl -a'
    
    Fixes: #2023
    Reported-by: Wido den Hollander <wido@widodh.nl>
    Signed-off-by: Sage Weil <sage.weil@dreamhost.com>

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 83fb932..17b6014 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -332,7 +332,7 @@ if [ -n "$prepareosdfs" ]; then
 
     modprobe btrfs || true
     mkfs.btrfs $btrfs_devs
-    btrfsctl -a
+    btrfs device scan || btrfsctl -a
     mount -t btrfs $btrfs_opt $first_dev $btrfs_path
     chown $osd_user $btrfs_path
     chmod +w $btrfs_path


