From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: osd stops
Date: Wed, 13 Apr 2011 14:12:51 +0200 (CEST)
Message-ID: <174374365.14569.1302696771139.JavaMail.root@mail.linserv.se>
References: <E54DF381DDD4475587E24CDF6D4C25D0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:54946 "EHLO
	mail.linserv.se" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab1DMMTw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2011 08:19:52 -0400
In-Reply-To: <E54DF381DDD4475587E24CDF6D4C25D0@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This is my config,

;
; Sample ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

; If a 'host' is defined for a daemon, the start/stop script will
; verify that it matches the hostname (or else ignore it).  If it is
; not defined, it is assumed that the daemon is intended to start on
; the current host (e.g., in a setup with a startup.conf on each
; node).

; global
[global]
        ; enable secure authentication
        auth supported =3D cephx
        keyring =3D /etc/ceph/keyring.bin

        ; allow ourselves to open a lot of files
        max open files =3D 131072
        pid file =3D /var/run/ceph/$name.pid
        debug ms =3D 1

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
        mon data =3D /data/mon$id

        ; logging, for debugging monitor crashes, in order of
        ; their likelihood of being helpful :)
        ;debug ms =3D 1
        ;debug mon =3D 20
        ;debug paxos =3D 20
        ;debug auth =3D 20

[mon0]
        host =3D ceph1
        mon addr =3D 10.0.6.10:6789

[mon1]
        host =3D ceph2
        mon addr =3D 10.0.6.11:6789

[mon2]
        host =3D ceph3
        mon addr =3D 10.0.6.12:6789

; mds
;  You need at least one.  Define two to get a standby.
[mds]
        ; where the mds keeps it's secret encryption keys
        keyring =3D /etc/ceph/keyring.$name

        ; mds logging to debug issues.
        ;debug ms =3D 1
        ;debug mds =3D 20

[mds0]
        host =3D ceph1

[mds1]
        host =3D ceph2

[mds2]
        host =3D ceph3

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
        sudo =3D true
        ; This is where the btrfs volume will be mounted.
        osd data =3D /data/osd$id
        ; where the ods keeps it's secret encryption keys
        keyring =3D /etc/ceph/keyring.$name

        ; Ideally, make this a separate disk or partition.  A few
        ; hundred MB should be enough; more if you have fast or many
        ; disks.  You can use a file under the osd data dir if need be
        ; (e.g. /data/osd$id/journal), but it will be slower than a
        ; separate disk or partition.

        ; This is an example of a file-based journal.
        ;osd journal =3D /data/osd$id/journal
        ;osd journal size =3D 1000 ; journal size, in megabytes

        ; osd logging to debug osd issues, in order of likelihood of be=
ing
        ; helpful
;       debug ms =3D 1
;       debug osd =3D 25
;       debug monc =3D 20
;       debug journal =3D 20
;       debug filestore =3D 10
;       osd use stale snap =3D true

[osd0]
        host =3D ceph1

        ; if 'btrfs devs' is not specified, you're responsible for
        ; setting up the 'osd data' dir.  if it is not btrfs, things
        ; will behave up until you try to recover from a crash (which
        ; usually fine for basic testing).
        btrfs devs =3D /dev/sdc
        osd journal =3D /dev/sda1

[osd1]
        host =3D ceph1
        btrfs devs =3D /dev/sdd
        osd journal =3D /dev/sda2

[osd2]
        host =3D ceph2
        btrfs devs =3D /dev/sdc
        osd journal =3D /dev/sda1

[osd3]
        host =3D ceph2
        btrfs devs =3D /dev/sdd
        osd journal =3D /dev/sda2

[osd4]
        host =3D ceph3
        btrfs devs =3D /dev/sdc
        osd journal =3D /dev/sda1

[osd5]
        host =3D ceph3
        btrfs devs =3D /dev/sdd
        osd journal =3D /dev/sda2

The statistics of the disks, this is after the crash of osd2 and osd4.

/dev/sdc             143373312 124954676  18418636  88% /data/osd0
/dev/sdd             143373312 137639524   5733788  97% /data/osd1

/dev/sdc             143373312 120350584  23022728  84% /data/osd2
/dev/sdd             143373312 141986188   1387124 100% /data/osd3

/dev/sdc             143373312 112025716  31347596  79% /data/osd4
/dev/sdd             143373312 115163124  28210188  81% /data/osd5

I will send some statistic of the ext3 as well

----- Ursprungligt meddelande -----=20
=46r=C3=A5n: "Gregory Farnum" <gregory.farnum@dreamhost.com>=20
Till: "Martin Wilderoth" <martin.wilderoth@linserv.se>=20
Kopia: ceph-devel@vger.kernel.org=20
Skickat: tisdag, 12 apr 2011 14:24:14=20
=C3=84mne: Re: osd stops=20

On Tuesday, April 12, 2011 at 11:05 AM, Martin Wilderoth wrote:=20
Thanks for the answer, now I know the reson. Some of my osd had 90% of =
data, dmesg also shows error with the btrfs on the hosts. I will run th=
e test with another file system ext3 :-) or is any other filesystem bet=
ter. It's a backuppc filesystem with a lot of hardlinks and data I woul=
d like to test to run in ceph.=20

ext3 or really any other FS will handle it better, although Ceph itself=
 is also not super-resilient to such situations. Eventually we will hav=
e automatic rebalancing of data but it's not in there right now.=20

Could you maybe send along your config file and the local filesystem st=
atistics on each of your OSDs? CRUSH is psuedo-random and so it's not g=
oing to have perfectly even utilization but if the variance is too high=
 we'll want to look into it sooner rather than later.=20
-Greg=20



--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
