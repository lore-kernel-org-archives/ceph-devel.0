From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: RE: mkcephfs failing on v0.48 "argonaut"
Date: Sun, 8 Jul 2012 07:15:05 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495419104F51E6@exch10>
References: <81C477727102DA4E9B2605AC748C495419104F51B3@exch10>
 <Pine.LNX.4.64.1207051512360.21201@cobra.newdream.net>
 <81C477727102DA4E9B2605AC748C495419104F51DA@exch10>
 <Pine.LNX.4.64.1207052107290.565@cobra.newdream.net>
 <81C477727102DA4E9B2605AC748C495419104F51E0@exch10>
 <Pine.LNX.4.64.1207062117420.13271@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf2.mach.net.au ([115.165.172.4]:33618 "EHLO mf2.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2GGVp0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jul 2012 17:45:26 -0400
In-Reply-To: <Pine.LNX.4.64.1207062117420.13271@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage

Confirming running the commands from a root prompt in the same sequence as requested:
mkfs.btrfs /dev/sdc
 btrfs device scan
 mount /dev/sdc /srv/osd.0


root@dsanb1-coy:~# mkfs.btrfs /dev/sdc

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/sdc
        nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB
Btrfs Btrfs v0.19
root@dsanb1-coy:~# btrfs device scan
Scanning for Btrfs filesystems
root@dsanb1-coy:~# mount /dev/sdc /srv/osd.0
mount: wrong fs type, bad option, bad superblock on /dev/sdc,
       missing codepage or helper program, or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

root@dsanb1-coy:~# mount | grep btrfs
root@dsanb1-coy:~# mount -t btrfs /dev/sdc /srv/osd.0
root@dsanb1-coy:~# mount | grep btrfs
/dev/sdc on /srv/osd.0 type btrfs (rw)


So - you can see I had to explicitly set the flag to mount "-t btrfs".  It seems that when mkcepfs is running the command "mount -t btrfs -o noatime /dev/sdc /srv/osd.0" it is doing so with the effect that the "-t btrfs" was not present in the line, but it is (symptom the same at least). Crazy.

Secondly, as requested I cannot run the command "sh -x /sbin/mkcephfs -d /tmp/mkcephfs.xgk025tjkQ --prepare-osdfs osd.0" because the contents of the /tmp/ directory are deleted each time mkcephfs finishes its run. I have however called the overall mkcephfs command with "sh -x" so you can see what is occurring.

See below:

root@dsanb1-coy:~# sh -x /sbin/mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k /etc/ceph/keyring --crushmapsrc crushfile.txt -v
<SNIP>
=== osd.0 ===
+ return 0
+ [ -n  ]
+ rdir=/tmp/mkcephfs.kJjIwsEnfZ
+ [ 0 -eq 0 ]
+ cp /tmp/mkcephfs.kJjIwsEnfZ/conf /etc/ceph/ceph.conf
+ [ 1 -eq 1 ]
+ [ osd = osd ]
+ do_root_cmd /sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0
+ [ -z  ]
+ [ 1 -eq 1 ]
+ echo --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0
--- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0
+ ulimit -c unlimited
+ whoami
+ whoami=root
+ [ root = root ]
+ bash -c /sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0
umount: /srv/osd.0: not mounted
umount: /dev/sdc: not mounted
/sbin/mkfs.btrfs
RUNNING: mkfs.btrfs /dev/sdc

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/sdc
        nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB
Btrfs Btrfs v0.19
Scanning for Btrfs filesystems
/bin/mount
RUNNING: mount -t btrfs -o noatime /dev/sdc /srv/osd.0
mount: wrong fs type, bad option, bad superblock on /dev/sdc,
       missing codepage or helper program, or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

+ echo failed: '/sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0'
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.kJjIwsEnfZ --prepare-osdfs osd.0'
+ exit 1
+ rm -rf /tmp/mkcephfs.kJjIwsEnfZ
+ exit



-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com]
Sent: Saturday, 7 July 2012 2:20 PM
To: Paul Pettigrew
Cc: ceph-devel@vger.kernel.org
Subject: RE: mkcephfs failing on v0.48 "argonaut"

On Sat, 7 Jul 2012, Paul Pettigrew wrote:
> Hi again Sage
>
> This is very perplexing.  Confirming this system is a stock Ubuntu 12.04 x64, with no custom kernel or anything else, fully apt-get dist-upgrade'd up to date.
> root@dsanb1-coy:~# uname -r
> 3.2.0-26-generic
>
> I have added in the suggestions you made to the script, we now have:
>
>     modprobe btrfs || true
> which mkfs.btrfs
> echo "RUNNING: mkfs.btrfs $btrfs_devs"
>     mkfs.btrfs $btrfs_devs
>     btrfs device scan || btrfsctl -a
> which mount
> echo "RUNNING: mount -t btrfs $btrfs_opt $first_dev $btrfs_path"
>     mount -t btrfs $btrfs_opt $first_dev $btrfs_path echo "DID I GET
> HERE - OR CRASH OUT WITH mount ABOVE?"
>     chown $osd_user $btrfs_path
>
>
> See below that the same command within the mkcephfs that is failing,
> is working fine on a standard command line:

Weirdness!

>
> === osd.0 ===
> --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.xgk025tjkQ
> --prepare-osdfs osd.0

Can you run this command with -x to see exactly what bash is doing?

 sh -x /sbin/mkcephfs -d /tmp/mkcephfs.xgk025tjkQ --prepare-osdfs osd.0

In particular, I'm curious if you do

 mkfs.btrfs /dev/sdc
 btrfs device scan
 mount /dev/sdc /srv/osd.0

(or whatever the exact sequence that mkcephfs does is) from the command line, does it give you the same error?

sage


> umount: /srv/osd.0: not mounted
> umount: /dev/sdc: not mounted
> /sbin/mkfs.btrfs
> RUNNING: mkfs.btrfs /dev/sdc
>
> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL WARNING! - see
> http://btrfs.wiki.kernel.org before using
>
> fs created label (null) on /dev/sdc
>         nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB Btrfs
> Btrfs v0.19 Scanning for Btrfs filesystems
> /bin/mount
> RUNNING: mount -t btrfs -o noatime /dev/sdc /srv/osd.0 /bin/mount
> mount: wrong fs type, bad option, bad superblock on /dev/sdc,
>        missing codepage or helper program, or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
>
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.xgk025tjkQ --prepare-osdfs osd.0'
> root@dsanb1-coy:~# /bin/mount -t btrfs -o noatime /dev/sdc /srv/osd.0
> root@dsanb1-coy:~# mount | grep btrfs /dev/sdc on /srv/osd.0 type
> btrfs (rw,noatime)
>
>
> Remember, this is not isolated to btrfs, as per my original post it fails when not specifying to use btrfs.
>
> I can only conclude that /bin/sh &/or /bin/bash and the way they interact with the mkcephfs script, which does call itself etc, is somehow now become fuddled up?  Must be something wiggy, when the script output confirms it is calling the same command ( /bin/mount ) but somehow finds a way for that to not work and therefore cause the mkcephfs script terminate.
>
> Many thanks - will be a relief to sort this out, as all our Ceph project works are on hold til we can sort this one out.
>
> Cheers
>
> Paul
>
>
>
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Friday, 6 July 2012 2:09 PM
> To: Paul Pettigrew
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: mkcephfs failing on v0.48 "argonaut"
>
> On Fri, 6 Jul 2012, Paul Pettigrew wrote:
> > Hi Sage - thanks so much for the quick response :-)
> >
> > Firstly, and it is a bit hard to see, but the command output below is run with the "-v" option. To help isolate what command line in the script is failing, I have added in some simple echo output, and the script now looks like:
> >
> >
> > ### prepare-osdfs ###
> >
> > if [ -n "$prepareosdfs" ]; then
> > <<SNIP>>
> >     modprobe btrfs || true
> > echo "RUNNING: mkfs.btrfs $btrfs_devs"
> >     mkfs.btrfs $btrfs_devs
> >     btrfs device scan || btrfsctl -a echo "RUNNING: mount -t btrfs
> > $btrfs_opt $first_dev $btrfs_path"
> >     mount -t btrfs $btrfs_opt $first_dev $btrfs_path echo "DID I GET
> > HERE - OR CRASH OUT WITH mount ABOVE?"
> >     chown $osd_user $btrfs_path
> >     chmod +w $btrfs_path
> >
> >     exit 0
> > fi
> >
> > Per the modified script the above, here is the output displayed when running the script:
> >
> > root@dsanb1-coy:/srv# /sbin/mkcephfs -c /etc/ceph/ceph.conf
> > --allhosts --mkbtrfs -k /etc/ceph/keyring --crushmapsrc
> > crushfile.txt -v temp dir is /tmp/mkcephfs.uelzdJ82ej preparing
> > monmap in /tmp/mkcephfs.uelzdJ82ej/monmap /usr/bin/monmaptool
> > --create --clobber --add alpha 10.32.0.10:6789 --add bravo
> > 10.32.0.25:6789 --add charlie
> > 10.32.0.11:6789 --print /tmp/mkcephfs.uelzdJ82ej/monmap
> > /usr/bin/monmaptool: monmap file /tmp/mkcephfs.uelzdJ82ej/monmap
> > /usr/bin/monmaptool: generated fsid
> > b254abdd-e036-4186-b6d5-e32b14e53b45
> > epoch 0
> > fsid b254abdd-e036-4186-b6d5-e32b14e53b45
> > last_changed 2012-07-06 12:31:38.416848 created 2012-07-06
> > 12:31:38.416848
> > 0: 10.32.0.10:6789/0 mon.alpha
> > 1: 10.32.0.11:6789/0 mon.charlie
> > 2: 10.32.0.25:6789/0 mon.bravo
> > /usr/bin/monmaptool: writing epoch 0 to
> > /tmp/mkcephfs.uelzdJ82ej/monmap (3 monitors) /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.0 "user"
> > === osd.0 ===
> > --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.uelzdJ82ej
> > --prepare-osdfs osd.0
> > umount: /srv/osd.0: not mounted
> > umount: /dev/sdc: not mounted
> > RUNNING: mkfs.btrfs /dev/sdc
> >
> > WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL WARNING! - see
> > http://btrfs.wiki.kernel.org before using
> >
> > fs created label (null) on /dev/sdc
> >         nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB
> > Btrfs Btrfs v0.19 Scanning for Btrfs filesystems
> > RUNNING: mount -t btrfs -o noatime /dev/sdc /srv/osd.0
> > mount: wrong fs type, bad option, bad superblock on /dev/sdc,
> >        missing codepage or helper program, or other error
> >        In some cases useful info is found in syslog - try
> >        dmesg | tail  or so
> >
> > failed: '/sbin/mkcephfs -d /tmp/mkcephfs.uelzdJ82ej --prepare-osdfs osd.0'
> >
> >
> > Which clearly isolates the issue to the "mount" command line.
> >
> > The trouble is, I can run this precise line on the command line directly without error:
> >
> > root@dsanb1-coy:/srv# mount -t btrfs -o noatime /dev/sdc /srv/osd.0
> > root@dsanb1-coy:/srv# mount | grep btrfs
> > /dev/sdc on /srv/osd.0 type btrfs (rw,noatime)
>
> What if you run the exact sequence of commands that mkcephfs is doing?
> (mkfs.btrfs, btrfs ..., mount ...).  If that doesn't work, put `which mkfs.btfs` etc in the script to make sure you're running the exact version the script is...
>
> sage
>
>
>
> >
> >
> > Therefore, what could possibly be preventing the mkcephfs running a simple mount command on the first OSD disk it gets to, that otherwise works fine from the command line?
> >
> > Many thanks Sage
> >
> > Paul
> >
> > PS: changing the " btrfs device scan || btrfsctl -a" line as proposed had no effect, and neither did putting in a "sleep 10" immediately before the mount line.
> > PPS: zerofilling the /dev/sdc and then re-creating a partition and mounting manually, then writing data to it is all fine. Same errors if we substitute any of the other HDD's in the server as 1st/osd.0. Ie, cannot see any issues with the hardware.
> >
> >
> >
> >
> >
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Friday, 6 July 2012 8:18 AM
> > To: Paul Pettigrew
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: mkcephfs failing on v0.48 "argonaut"
> >
> > Hi Paul,
> >
> > On Wed, 4 Jul 2012, Paul Pettigrew wrote:
> > > Firstly, well done guys on achieving this version milestone. I
> > > successfully upgraded to the 0.48 format uneventfully on a live
> > > (test) system.
> > >
> > > The same system was then going through "rebuild" testing, to
> > > confirm that also worked fine.
> > >
> > >
> > > Unfortunately, the mkcephfs command is failing:
> > >
> > > root@dsanb1-coy:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts
> > > --mkbtrfs -k /etc/ceph/keyring --crushmapsrc crushfile.txt -v temp
> > > dir is /tmp/mkcephfs.GaRCZ9i06a preparing monmap in
> > > /tmp/mkcephfs.GaRCZ9i06a/monmap /usr/bin/monmaptool --create
> > > --clobber --add alpha 10.32.0.10:6789 --add bravo 10.32.0.25:6789
> > > --add charlie
> > > 10.32.0.11:6789 --print /tmp/mkcephfs.GaRCZ9i06a/monmap
> > > /usr/bin/monmaptool: monmap file /tmp/mkcephfs.GaRCZ9i06a/monmap
> > > /usr/bin/monmaptool: generated fsid
> > > c7202495-468c-4678-b678-115c3ee33402
> > > epoch 0
> > > fsid c7202495-468c-4678-b678-115c3ee33402
> > > last_changed 2012-07-04 15:02:31.732275 created 2012-07-04
> > > 15:02:31.732275
> > > 0: 10.32.0.10:6789/0 mon.alpha
> > > 1: 10.32.0.11:6789/0 mon.charlie
> > > 2: 10.32.0.25:6789/0 mon.bravo
> > > /usr/bin/monmaptool: writing epoch 0 to
> > > /tmp/mkcephfs.GaRCZ9i06a/monmap (3 monitors) /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.0 "user"
> > > === osd.0 ===
> > > --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.GaRCZ9i06a
> > > --prepare-osdfs osd.0
> > > umount: /srv/osd.0: not mounted
> > > umount: /dev/disk/by-wwn/wwn-0x50014ee601246234: not mounted
> > >
> > > WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL WARNING! - see
> > > http://btrfs.wiki.kernel.org before using
> > >
> > > fs created label (null) on /dev/disk/by-wwn/wwn-0x50014ee601246234
> > >         nodesize 4096 leafsize 4096 sectorsize 4096 size 1.82TB
> > > Btrfs Btrfs v0.19 Scanning for Btrfs filesystems
> > > mount: wrong fs type, bad option, bad superblock on /dev/sdc,
> > >        missing codepage or helper program, or other error
> > >        In some cases useful info is found in syslog - try
> > >        dmesg | tail  or so
> > >
> > > failed: '/sbin/mkcephfs -d /tmp/mkcephfs.GaRCZ9i06a --prepare-osdfs osd.0'
> >
> > Hmm.  Can you try running with -v?  That will tell us exactly which command it is running, and hopefully we can work backwards from there.
> >
> > > dmesg/syslog is spitting out at the time of this failure:
> > >
> > > Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.751945] device fsid
> > > 7de0d192-b710-4629-a201-849df1d9db17 devid 1 transid 27109
> > > /dev/sdp Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.751987] device
> > > fsid 08fc3479-2fa2-4388-8b61-83e2a742a13e devid 1 transid 28699
> > > /dev/sdo Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.752023] device
> > > fsid
> > > 8b4a7c43-1a05-4dcb-bbed-de2a5c933996 devid 1 transid 24346
> > > /dev/sdn Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.752068] device
> > > fsid ba5fb1ca-c642-49b1-8a41-7f56f8e59fbd devid 1 transid 27274
> > > /dev/sdm Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761453] device
> > > fsid 7fe8c5cf-bf8c-4276-90f2-c3f57f5275fb devid 1 transid 28724
> > > /dev/sdi Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761518] device
> > > fsid 93fa3631-1202-4d42-8908-e5ef4d3e600d devid 1 transid 25201
> > > /dev/sdh Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761579] device
> > > fsid b9a1b5e4-3e5e-4381-a29a-33470f4b870f devid 1 transid 23375
> > > /dev/sdg Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761635] device
> > > fsid 280ea990-23f8-4c43-9e56-140c82340fdc devid 1 transid 25559
> > > /dev/sdf Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.761693] device
> > > fsid 2f724cde-6de5-4262-b195-1ba3eea2256e devid 1 transid 176
> > > /dev/sde Jul
> > > 4 15:02:31 dsanb1-coy kernel: [ 2306.761732] device fsid
> > > a66f890f-8b08-4393-aab0-f222637ca5a4 devid 1 transid 7 /dev/sdd
> > > Jul
> > > 4
> > > 15:02:31 dsanb1-coy kernel: [ 2306.761769] device fsid
> > > 6c181a94-697c-4e0c-af0d-05eb04d3626c devid 1 transid 7 /dev/sdc
> > > Jul
> > > 4
> > > 15:02:31 dsanb1-coy kernel: [ 2306.775931] device fsid
> > > 6c181a94-697c-4e0c-af0d-05eb04d3626c devid 1 transid 7 /dev/sdc
> > > Jul
> > > 4
> > > 15:02:31 dsanb1-coy kernel: [ 2306.779716] btrfs bad fsid on block
> > > 20971520 Jul  4 15:02:31 dsanb1-coy kernel: [ 2306.791594] btrfs
> > > bad fsid on block 20971520 Jul  4 15:02:31 dsanb1-coy kernel: [
> > > 2306.803608] btrfs bad fsid on block 20971520 Jul  4 15:02:31
> > > dsanb1-coy kernel: [ 2306.815541] btrfs bad fsid on block 20971520
> > > Jul
> > > 4 15:02:31 dsanb1-coy kernel: [ 2306.815878] btrfs bad fsid on
> > > block
> > > 20971520 Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.823554] btrfs
> > > bad fsid on block 20971520 Jul  4 15:02:32 dsanb1-coy kernel: [
> > > 2306.823797] btrfs bad fsid on block 20971520 Jul  4 15:02:32
> > > dsanb1-coy kernel: [ 2306.823887] btrfs: failed to read chunk root
> > > on sdc Jul  4 15:02:32 dsanb1-coy kernel: [ 2306.825622] btrfs:
> > > open_ctree failed
> >
> > Long shot, but is the kernel on that machine recent?
> >
> > > Also fails if not forcing to use btrfs, eg:
> > >
> > > root@dsanb1-coy:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -k
> > > /etc/ceph/keyring --crushmapsrc crushfile.txt -v temp dir is
> > > /tmp/mkcephfs.ZOh6tBPAH0 preparing monmap in
> > > /tmp/mkcephfs.ZOh6tBPAH0/monmap /usr/bin/monmaptool --create
> > > --clobber --add alpha 10.32.0.10:6789 --add bravo 10.32.0.25:6789
> > > --add charlie
> > > 10.32.0.11:6789 --print /tmp/mkcephfs.ZOh6tBPAH0/monmap
> > > /usr/bin/monmaptool: monmap file /tmp/mkcephfs.ZOh6tBPAH0/monmap
> > > /usr/bin/monmaptool: generated fsid
> > > adb8d65c-a823-4dc2-9415-22b0d7252699
> > > epoch 0
> > > fsid adb8d65c-a823-4dc2-9415-22b0d7252699
> > > last_changed 2012-07-04 15:04:17.423368 created 2012-07-04
> > > 15:04:17.423368
> > > 0: 10.32.0.10:6789/0 mon.alpha
> > > 1: 10.32.0.11:6789/0 mon.charlie
> > > 2: 10.32.0.25:6789/0 mon.bravo
> > > /usr/bin/monmaptool: writing epoch 0 to
> > > /tmp/mkcephfs.ZOh6tBPAH0/monmap (3 monitors) /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.0 "user"
> > > === osd.0 ===
> > > --- dsanb1-coy# /sbin/mkcephfs -d /tmp/mkcephfs.ZOh6tBPAH0
> > > --init-daemon osd.0
> > > 2012-07-04 15:04:17.789064 7fc7fadca780 -1 filestore(/srv/osd.0)
> > > limited size xattrs -- enable filestore_xattr_use_omap
> > > 2012-07-04 15:04:17.789120 7fc7fadca780 -1 OSD::mkfs: couldn't
> > > mount
> > > FileStore: error -95
> > > 2012-07-04 15:04:17.789161 7fc7fadca780 -1  ** ERROR: error
> > > creating empty object store in /srv/osd.0: (95) Operation not
> > > supported
> > > failed: '/sbin/mkcephfs -d /tmp/mkcephfs.ZOh6tBPAH0 --init-daemon osd.0'
> > >
> > >
> > > Confirming all this was working previously, and the crushmap,
> > > config file, etc are all proven to be OK (get same failure when
> > > not specifying a custom crushmap also). Also note that whilst the
> > > above is failing on
> > > osd.0 creation, I have swapped disk references and still get the
> > > same failure on different HDD's when they are hooked in as osd.0
> >
> > The only thing that changed from v0.47 is the below.  Can you try replacing 'btrfs device scan || btrfsctl -a' with 'btrfs device scan ; btrfsctl -a'?  Maybe the btrfs tool isn't being pendantic about return codes...
> >
> > sage
> >
> >
> > commit a414fd51c7c5ae5dbe9e3af7db6f17741a58c1a7
> > Author: Sage Weil <sage.weil@dreamhost.com>
> > Date:   Sat Feb 11 13:43:23 2012 -0800
> >
> >     init-ceph, mkcephfs: try 'btrfs device scan' before 'btrfsctl -a'
> >
> >     Fixes: #2023
> >     Reported-by: Wido den Hollander <wido@widodh.nl>
> >     Signed-off-by: Sage Weil <sage.weil@dreamhost.com>
> >
> > diff --git a/src/mkcephfs.in b/src/mkcephfs.in index
> > 83fb932..17b6014
> > 100644
> > --- a/src/mkcephfs.in
> > +++ b/src/mkcephfs.in
> > @@ -332,7 +332,7 @@ if [ -n "$prepareosdfs" ]; then
> >
> >      modprobe btrfs || true
> >      mkfs.btrfs $btrfs_devs
> > -    btrfsctl -a
> > +    btrfs device scan || btrfsctl -a
> >      mount -t btrfs $btrfs_opt $first_dev $btrfs_path
> >      chown $osd_user $btrfs_path
> >      chmod +w $btrfs_path
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
>
>


