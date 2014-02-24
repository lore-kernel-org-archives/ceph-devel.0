From: <ghislain.chevalier@orange.com>
Subject: RE: [Ceph] Failure in osd creation
Date: Mon, 24 Feb 2014 08:42:38 +0000
Message-ID: <28499_1393231359_530B05FF_28499_3195_9_B9C8EFBF13B1354DB5FA000660D66DD00C0C2517@PEXCVZYM14.corporate.adroot.infra.ftgroup>
References: <6444_1392830813_5304E95D_6444_7235_1_B9C8EFBF13B1354DB5FA000660D66DD00C0C101F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
 <CA+7XDxP3O287xwUMUYzU0ivZimO+zD9zmCpKTWMkUcQkd2oWJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias92.francetelecom.com ([193.251.215.92]:30954 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbaBXIml convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Feb 2014 03:42:41 -0500
In-Reply-To: <CA+7XDxP3O287xwUMUYzU0ivZimO+zD9zmCpKTWMkUcQkd2oWJA@mail.gmail.com>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: eric mourgaya <eric.mourgaya@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Eric,

Great !! The cluster is totally up now

I got a wrong key in ceph.bootstrap-osd.keyring file in /etc/ceph of th=
e ceph-deploy server.



De=A0: eric mourgaya [mailto:eric.mourgaya@gmail.com]=20
Envoy=E9=A0: vendredi 21 f=E9vrier 2014 15:39
=C0=A0: CHEVALIER Ghislain IMT/OLPS
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: [Ceph] Failure in osd creation

Hi Ghislain,
Try to erase=A0 all keyring files and=A0 after=A0 exec ceph-deploy gath=
erkey mon_host befor=A0 trying to create your new osd!

:-)

=A0



2014-02-19 18:26 GMT+01:00 <ghislain.chevalier@orange.com>:

Hi all,

I'd like to submit a strange behavior...

Context : lab platform
CEPH emperor
Ceph-deploy 1.3.4
Ubuntu 12.04 LTS

=46YI : The problem occurs for another OSD with ceph-deploy 1.3.5 and U=
buntu 13.10; I upgraded the server in order to install The Rados Gatewa=
y that requires 13.04 minimum.

Issue:
We have 3 OSD up and running; we encountered no difficulties in creatin=
g them.
We tried to create an osd.3 using ceph-deploy on a storage node (r-ceph=
osd301) from an admin server (r-cephrgw01)
We have to use an external SATA 3 TB disk; the journal will be set on t=
he first sectors.
We encountered a lot of problems but we succeeded.

As we also encountered the same difficulties creating the osd.4 =A0(r-c=
ephosd302), I decided to trace the process.

We had the following lines in ceph.conf (journal size is set in the osd=
 section because it's not taken into account in osd.4 section)
[osd.4]
host =3D r-cephosd302
public_addr =3D 10.194.182.52
cluster_addr =3D 192.168.182.52

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd --zap-disk=
 create r-cephosd302:/dev/sdc
=A0[ceph_deploy.cli][INFO =A0] Invoked (1.3.4): /usr/bin/ceph-deploy --=
overwrite-conf osd --zap-disk create r-cephosd302:/dev/sdc
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks r-cephosd302:/de=
v/sdc:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO =A0] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to r-cephosd302
[r-cephosd302][DEBUG ] write cluster configuration to /etc/ceph/{cluste=
r}.conf
[r-cephosd302][INFO =A0] Running command: udevadm trigger --subsystem-m=
atch=3Dblock --action=3Dadd
[ceph_deploy.osd][DEBUG ] Preparing host r-cephosd302 disk /dev/sdc jou=
rnal None activate True
[r-cephosd302][INFO =A0] Running command: ceph-disk-prepare --zap-disk =
--fs-type xfs --cluster ceph -- /dev/sdc
[r-cephosd302][WARNIN] Caution: invalid backup GPT header, but valid ma=
in header; regenerating
[r-cephosd302][WARNIN] backup header from main header.
[r-cephosd302][WARNIN]
[r-cephosd302][WARNIN] Warning! Main and backup partition tables differ=
! Use the 'c' and 'e' options
[r-cephosd302][WARNIN] on the recovery & transformation menu to examine=
 the two tables.
[r-cephosd302][WARNIN]
[r-cephosd302][WARNIN] Warning! One or more CRCs don't match. You shoul=
d repair the disk!
[r-cephosd302][WARNIN]
[r-cephosd302][WARNIN] INFO:ceph-disk:Will colocate journal with data o=
n /dev/sdc
[r-cephosd302][DEBUG ] ************************************************=
****************************
[r-cephosd302][DEBUG ] Caution: Found protective or hybrid MBR and corr=
upt GPT. Using GPT, but disk
[r-cephosd302][DEBUG ] verification and recovery are STRONGLY recommend=
ed.
[r-cephosd302][DEBUG ] ************************************************=
****************************
[r-cephosd302][DEBUG ] GPT data structures destroyed! You may now parti=
tion the disk using fdisk or
[r-cephosd302][DEBUG ] other utilities.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] Information: Moved requested sector from 34 to 2=
048 in
[r-cephosd302][DEBUG ] order to align on 2048-sector boundaries.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] Information: Moved requested sector from 3891200=
1 to 38914048 in
[r-cephosd302][DEBUG ] order to align on 2048-sector boundaries.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] meta-data=3D/dev/sdc1 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
isize=3D2048 =A0 agcount=3D4, agsize=3D181925597 blks
[r-cephosd302][DEBUG ] =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 sectsz=3D512 =A0 attr=3D2, projid32bit=3D0
[r-cephosd302][DEBUG ] data =A0 =A0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 bsize=3D4096 =A0 blocks=3D727702385, imaxpct=3D5
[r-cephosd302][DEBUG ] =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 sunit=3D0 =A0 =A0 =A0swidth=3D0 blks
[r-cephosd302][DEBUG ] naming =A0 =3Dversion 2 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0bsize=3D4096 =A0 ascii-ci=3D0
[r-cephosd302][DEBUG ] log =A0 =A0 =A0=3Dinternal log =A0 =A0 =A0 =A0 =A0=
 bsize=3D4096 =A0 blocks=3D355323, version=3D2
[r-cephosd302][DEBUG ] =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 sectsz=3D512 =A0 sunit=3D0 blks, lazy-count=3D1
[r-cephosd302][DEBUG ] realtime =3Dnone =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 extsz=3D4096 =A0 blocks=3D0, rtextents=3D0
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][INFO =A0] Running command: udevadm trigger --subsystem-m=
atch=3Dblock --action=3Dadd
[ceph_deploy.osd][DEBUG ] Host r-cephosd302 is now ready for osd use.

the process seems to finish normally, but...

root@r-cephrgw01:/etc/ceph# ceph osd tree
# id =A0 =A0weight =A0type name =A0 =A0 =A0 up/down reweight
-1 =A0 =A0 =A04.06 =A0 =A0root default
-2 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd101
0 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.0 =A0 up =
=A0 =A0 =A01
-3 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd102
1 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.1 =A0 up =
=A0 =A0 =A01
-4 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd103
2 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.2 =A0 up =
=A0 =A0 =A01
-5 =A0 =A0 =A02.71 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd301
3 =A0 =A0 =A0 2.71 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.3 =A0 up =
=A0 =A0 =A01

The OSD is not in the cluster and it seems that Ceph tried to create a =
new osd.0 according to the log file found on the remote server.
root@r-cephosd302:/var/lib/ceph/osd/ceph-4# ll /var/log/ceph
total 12
drwxr-xr-x =A02 root root 4096 Jan 24 14:46 ./
drwxr-xr-x 11 root root 4096 Jan 24 13:27 ../
-rw-r--r-- =A01 root root 2634 Jan 24 14:47 ceph-osd.0.log
-rw-r--r-- =A01 root root =A0 =A00 Jan 24 14:46 ceph-osd..log

So, we did the following actions:

root@r-cephosd302:/var/lib/ceph/osd# mkdir ceph-4
root@r-cephosd302:/var/lib/ceph/osd# mount /dev/sdc1 ceph-4/
root@r-cephosd302:/var/lib/ceph/osd# cd ceph-4
root@r-cephosd302:/var/lib/ceph/osd/ceph-4# ll
total 20
drwxr-xr-x 2 root root =A0 78 Jan 24 14:47 ./
drwxr-xr-x 3 root root 4096 Jan 24 14:49 ../
-rw-r--r-- 1 root root =A0 37 Jan 24 14:47 ceph_fsid
-rw-r--r-- 1 root root =A0 37 Jan 24 14:47 fsid
lrwxrwxrwx 1 root root =A0 58 Jan 24 14:47 journal -> /dev/disk/by-part=
uuid/7a6924
63-9837-4297-a5e3-98dac12aaf70
-rw-r--r-- 1 root root =A0 37 Jan 24 14:47 journal_uuid
-rw-r--r-- 1 root root =A0 21 Jan 24 14:47 magic

Some files are missing...

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd prepare r-=
cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO =A0] Invoked (1.3.4): /usr/bin/ceph-deploy --ove=
rwrite-conf osd prepare r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks r-cephosd302:/va=
r/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO =A0] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to r-cephosd302
[r-cephosd302][DEBUG ] write cluster configuration to /etc/ceph/{cluste=
r}.conf
[r-cephosd302][INFO =A0] Running command: udevadm trigger --subsystem-m=
atch=3Dblock --action=3Dadd
[ceph_deploy.osd][DEBUG ] Preparing host r-cephosd302 disk /var/lib/cep=
h/osd/ceph-4 journal None activate False
[r-cephosd302][INFO =A0] Running command: ceph-disk-prepare --fs-type x=
fs --cluster ceph -- /var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Host r-cephosd302 is now ready for osd use.

the new osd is prepared but trying to active it....

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd activate r=
-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO =A0] Invoked (1.3.4): /usr/bin/ceph-deploy --ove=
rwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Activating cluster ceph disks r-cephosd302:/v=
ar/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO =A0] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] activating host r-cephosd302 disk /var/lib/ce=
ph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] will use init type: upstart
[r-cephosd302][INFO =A0] Running command: ceph-disk-activate --mark-ini=
t upstart --mount /var/lib/ceph/osd/ceph-4
[r-cephosd302][WARNIN] 2014-01-24 14:54:01.890234 7fe795693700 =A00 lib=
rados: client.bootstrap-osd authentication error (1) Operation not perm=
itted
[r-cephosd302][WARNIN] Error connecting to cluster: PermissionError

The bootstrap-osd/ceph.keyring is not correct...
So, I update it with the key created before.

root@r-cephosd302:/var/lib/ceph/osd/ceph-4# more ../../bootstrap-osd/ce=
ph.keyring
[client.bootstrap-osd]
=A0 =A0 =A0 =A0 key =3D AQB0gN5SMIojBBAAGQwbLM1a+5ZdzfuYu91ZDg=3D=3D

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root@r-cephosd302:/var/lib/ceph/osd/cep=
h-4# vi ../../bootstrap-osd/ceph.keyring
[client.bootstrap-osd]
=A0 =A0 =A0 =A0 key =3D AQCrid5S6BSwORAAO4ch+GGGKhXW1BEVBHA2Bw=3D=3D

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd activate r=
-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO =A0] Invoked (1.3.4): /usr/bin/ceph-deploy --ove=
rwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Activating cluster ceph disks r-cephosd302:/v=
ar/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO =A0] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] activating host r-cephosd302 disk /var/lib/ce=
ph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] will use init type: upstart
[r-cephosd302][INFO =A0] Running command: ceph-disk-activate --mark-ini=
t upstart --mount /var/lib/ceph/osd/ceph-4
[r-cephosd302][WARNIN] got latest monmap
[r-cephosd302][WARNIN] 2014-01-24 14:59:12.889327 7f4f47f49780 -1 journ=
al read_header error decoding journal header
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.051076 7f4f47f49780 -1 files=
tore(/var/lib/ceph/osd/ceph-4) could not find 23c2fcde/osd_superblock/0=
//-1 in index: (2) No such file or directory
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220053 7f4f47f49780 -1 creat=
ed object store /var/lib/ceph/osd/ceph-4 journal /var/lib/ceph/osd/ceph=
-4/journal for osd.4 fsid 632d789a-8560-469b-bf6a-8478e12d2cb6
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220135 7f4f47f49780 -1 auth:=
 error reading file: /var/lib/ceph/osd/ceph-4/keyring: can't open /var/=
lib/ceph/osd/ceph-4/keyring: (2) No such file or directory
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220572 7f4f47f49780 -1 creat=
ed new key in keyring /var/lib/ceph/osd/ceph-4/keyring
[r-cephosd302][WARNIN] added key for osd.4
root@r-cephrgw01:/etc/ceph# ceph -s
=A0 =A0 cluster 632d789a-8560-469b-bf6a-8478e12d2cb6
=A0 =A0 =A0health HEALTH_OK
=A0 =A0 =A0monmap e3: 3 mons at {r-cephosd101=3D10.194.182.41:6789/0,r-=
cephosd102=3D10.194.182.42:6789/0,r-cephosd103=3D10.194.182.43:6789/0},=
 election epoch 6, quorum 0,1,2 r-cephosd101,r-cephosd102,r-cephosd103
=A0 =A0 =A0osdmap e37: 5 osds: 5 up, 5 in
=A0 =A0 =A0 pgmap v240: 192 pgs, 3 pools, 0 bytes data, 0 objects
=A0 =A0 =A0 =A0 =A0 =A0 139 MB used, 4146 GB / 4146 GB avail
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0192 active+clean

root@r-cephrgw01:/etc/ceph# ceph osd tree
# id =A0 =A0weight =A0type name =A0 =A0 =A0 up/down reweight
-1 =A0 =A0 =A06.77 =A0 =A0root default
-2 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd101
0 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.0 =A0 up =
=A0 =A0 =A01
-3 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd102
1 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.1 =A0 up =
=A0 =A0 =A01
-4 =A0 =A0 =A00.45 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd103
2 =A0 =A0 =A0 0.45 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.2 =A0 up =
=A0 =A0 =A01
-5 =A0 =A0 =A02.71 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd301
3 =A0 =A0 =A0 2.71 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.3 =A0 up =
=A0 =A0 =A01
-6 =A0 =A0 =A02.71 =A0 =A0 =A0 =A0 =A0 =A0host r-cephosd302
4 =A0 =A0 =A0 2.71 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd.4 =A0 up =
=A0 =A0 =A01

Now, the new osd is up....

I didn't understand where the problem is...

Why isn't the "osd journal size" in the osd.# section taken into accoun=
t?
Why does ceph try to recreate osd.0?
Why does ceph-deploy indicate that the osd is ready for use?
Why doesn't ceph-deploy create all the files?
Why is the bootstrap-osd not correct?

Thanks


- - - - - - - - - - - - - - - - -
Ghislain Chevalier
ORANGE LABS FRANCE
Storage Service Architect
=A0+33299124432
ghislain.chevalier@orange.com


_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Eric Mourgaya,


Respectons la planete!
Luttons contre la mediocrite!=20

_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
