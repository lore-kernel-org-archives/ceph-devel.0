From: <ghislain.chevalier@orange.com>
Subject: [Ceph] Failure in osd creation
Date: Wed, 19 Feb 2014 17:26:52 +0000
Message-ID: <6444_1392830813_5304E95D_6444_7235_1_B9C8EFBF13B1354DB5FA000660D66DD00C0C101F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias243.francetelecom.com ([80.12.204.243]:22104 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754532AbaBSRgj convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Feb 2014 12:36:39 -0500
Received: from omfeda07.si.francetelecom.fr (unknown [xx.xx.xx.200])
	by omfeda11.si.francetelecom.fr (ESMTP service) with ESMTP id 806AB1B80FC
	for <ceph-devel@vger.kernel.org>; Wed, 19 Feb 2014 18:26:53 +0100 (CET)
Received: from Exchangemail-eme1.itn.ftgroup (unknown [10.114.1.186])
	by omfeda07.si.francetelecom.fr (ESMTP service) with ESMTP id 5D09415809C
	for <ceph-devel@vger.kernel.org>; Wed, 19 Feb 2014 18:26:53 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi all,

I'd like to submit a strange behavior...

Context : lab platform
CEPH emperor
Ceph-deploy 1.3.4
Ubuntu 12.04 LTS

FYI : The problem occurs for another OSD with ceph-deploy 1.3.5 and Ubuntu 13.10; I upgraded the server in order to install The Rados Gateway that requires 13.04 minimum.

Issue:
We have 3 OSD up and running; we encountered no difficulties in creating them.
We tried to create an osd.3 using ceph-deploy on a storage node (r-cephosd301) from an admin server (r-cephrgw01)
We have to use an external SATA 3 TB disk; the journal will be set on the first sectors.
We encountered a lot of problems but we succeeded.

As we also encountered the same difficulties creating the osd.4  (r-cephosd302), I decided to trace the process. 

We had the following lines in ceph.conf (journal size is set in the osd section because it's not taken into account in osd.4 section)
[osd.4]
host = r-cephosd302
public_addr = 10.194.182.52
cluster_addr = 192.168.182.52

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd --zap-disk create r-cephosd302:/dev/sdc
 [ceph_deploy.cli][INFO  ] Invoked (1.3.4): /usr/bin/ceph-deploy --overwrite-conf osd --zap-disk create r-cephosd302:/dev/sdc
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks r-cephosd302:/dev/sdc:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302 
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to r-cephosd302
[r-cephosd302][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[r-cephosd302][INFO  ] Running command: udevadm trigger --subsystem-match=block --action=add
[ceph_deploy.osd][DEBUG ] Preparing host r-cephosd302 disk /dev/sdc journal None activate True
[r-cephosd302][INFO  ] Running command: ceph-disk-prepare --zap-disk --fs-type xfs --cluster ceph -- /dev/sdc
[r-cephosd302][WARNIN] Caution: invalid backup GPT header, but valid main header; regenerating
[r-cephosd302][WARNIN] backup header from main header.
[r-cephosd302][WARNIN] 
[r-cephosd302][WARNIN] Warning! Main and backup partition tables differ! Use the 'c' and 'e' options
[r-cephosd302][WARNIN] on the recovery & transformation menu to examine the two tables.
[r-cephosd302][WARNIN] 
[r-cephosd302][WARNIN] Warning! One or more CRCs don't match. You should repair the disk!
[r-cephosd302][WARNIN] 
[r-cephosd302][WARNIN] INFO:ceph-disk:Will colocate journal with data on /dev/sdc
[r-cephosd302][DEBUG ] ****************************************************************************
[r-cephosd302][DEBUG ] Caution: Found protective or hybrid MBR and corrupt GPT. Using GPT, but disk
[r-cephosd302][DEBUG ] verification and recovery are STRONGLY recommended.
[r-cephosd302][DEBUG ] ****************************************************************************
[r-cephosd302][DEBUG ] GPT data structures destroyed! You may now partition the disk using fdisk or
[r-cephosd302][DEBUG ] other utilities.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] Information: Moved requested sector from 34 to 2048 in
[r-cephosd302][DEBUG ] order to align on 2048-sector boundaries.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] Information: Moved requested sector from 38912001 to 38914048 in
[r-cephosd302][DEBUG ] order to align on 2048-sector boundaries.
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][DEBUG ] meta-data=/dev/sdc1              isize=2048   agcount=4, agsize=181925597 blks
[r-cephosd302][DEBUG ]          =                       sectsz=512   attr=2, projid32bit=0
[r-cephosd302][DEBUG ] data     =                       bsize=4096   blocks=727702385, imaxpct=5
[r-cephosd302][DEBUG ]          =                       sunit=0      swidth=0 blks
[r-cephosd302][DEBUG ] naming   =version 2              bsize=4096   ascii-ci=0
[r-cephosd302][DEBUG ] log      =internal log           bsize=4096   blocks=355323, version=2
[r-cephosd302][DEBUG ]          =                       sectsz=512   sunit=0 blks, lazy-count=1
[r-cephosd302][DEBUG ] realtime =none                   extsz=4096   blocks=0, rtextents=0
[r-cephosd302][DEBUG ] The operation has completed successfully.
[r-cephosd302][INFO  ] Running command: udevadm trigger --subsystem-match=block --action=add
[ceph_deploy.osd][DEBUG ] Host r-cephosd302 is now ready for osd use.

the process seems to finish normally, but...

root@r-cephrgw01:/etc/ceph# ceph osd tree
# id    weight  type name       up/down reweight
-1      4.06    root default
-2      0.45            host r-cephosd101
0       0.45                    osd.0   up      1
-3      0.45            host r-cephosd102
1       0.45                    osd.1   up      1
-4      0.45            host r-cephosd103
2       0.45                    osd.2   up      1
-5      2.71            host r-cephosd301
3       2.71                    osd.3   up      1

The OSD is not in the cluster and it seems that Ceph tried to create a new osd.0 according to the log file found on the remote server.
root@r-cephosd302:/var/lib/ceph/osd/ceph-4# ll /var/log/ceph
total 12
drwxr-xr-x  2 root root 4096 Jan 24 14:46 ./
drwxr-xr-x 11 root root 4096 Jan 24 13:27 ../
-rw-r--r--  1 root root 2634 Jan 24 14:47 ceph-osd.0.log
-rw-r--r--  1 root root    0 Jan 24 14:46 ceph-osd..log

So, we did the following actions:

root@r-cephosd302:/var/lib/ceph/osd# mkdir ceph-4
root@r-cephosd302:/var/lib/ceph/osd# mount /dev/sdc1 ceph-4/
root@r-cephosd302:/var/lib/ceph/osd# cd ceph-4
root@r-cephosd302:/var/lib/ceph/osd/ceph-4# ll
total 20
drwxr-xr-x 2 root root   78 Jan 24 14:47 ./
drwxr-xr-x 3 root root 4096 Jan 24 14:49 ../
-rw-r--r-- 1 root root   37 Jan 24 14:47 ceph_fsid
-rw-r--r-- 1 root root   37 Jan 24 14:47 fsid
lrwxrwxrwx 1 root root   58 Jan 24 14:47 journal -> /dev/disk/by-partuuid/7a6924
63-9837-4297-a5e3-98dac12aaf70
-rw-r--r-- 1 root root   37 Jan 24 14:47 journal_uuid
-rw-r--r-- 1 root root   21 Jan 24 14:47 magic

Some files are missing...

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd prepare r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO  ] Invoked (1.3.4): /usr/bin/ceph-deploy --overwrite-conf osd prepare r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks r-cephosd302:/var/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302 
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to r-cephosd302
[r-cephosd302][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[r-cephosd302][INFO  ] Running command: udevadm trigger --subsystem-match=block --action=add
[ceph_deploy.osd][DEBUG ] Preparing host r-cephosd302 disk /var/lib/ceph/osd/ceph-4 journal None activate False
[r-cephosd302][INFO  ] Running command: ceph-disk-prepare --fs-type xfs --cluster ceph -- /var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Host r-cephosd302 is now ready for osd use.

the new osd is prepared but trying to active it....

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO  ] Invoked (1.3.4): /usr/bin/ceph-deploy --overwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Activating cluster ceph disks r-cephosd302:/var/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302 
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] activating host r-cephosd302 disk /var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] will use init type: upstart
[r-cephosd302][INFO  ] Running command: ceph-disk-activate --mark-init upstart --mount /var/lib/ceph/osd/ceph-4
[r-cephosd302][WARNIN] 2014-01-24 14:54:01.890234 7fe795693700  0 librados: client.bootstrap-osd authentication error (1) Operation not permitted
[r-cephosd302][WARNIN] Error connecting to cluster: PermissionError

The bootstrap-osd/ceph.keyring is not correct...
So, I update it with the key created before.

root@r-cephosd302:/var/lib/ceph/osd/ceph-4# more ../../bootstrap-osd/ceph.keyring 
[client.bootstrap-osd]
        key = AQB0gN5SMIojBBAAGQwbLM1a+5ZdzfuYu91ZDg==

		root@r-cephosd302:/var/lib/ceph/osd/ceph-4# vi ../../bootstrap-osd/ceph.keyring  
[client.bootstrap-osd]
        key = AQCrid5S6BSwORAAO4ch+GGGKhXW1BEVBHA2Bw==

root@r-cephrgw01:/etc/ceph# ceph-deploy --overwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.cli][INFO  ] Invoked (1.3.4): /usr/bin/ceph-deploy --overwrite-conf osd activate r-cephosd302:/var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] Activating cluster ceph disks r-cephosd302:/var/lib/ceph/osd/ceph-4:
[r-cephosd302][DEBUG ] connected to host: r-cephosd302 
[r-cephosd302][DEBUG ] detect platform information from remote host
[r-cephosd302][DEBUG ] detect machine type
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] activating host r-cephosd302 disk /var/lib/ceph/osd/ceph-4
[ceph_deploy.osd][DEBUG ] will use init type: upstart
[r-cephosd302][INFO  ] Running command: ceph-disk-activate --mark-init upstart --mount /var/lib/ceph/osd/ceph-4
[r-cephosd302][WARNIN] got latest monmap
[r-cephosd302][WARNIN] 2014-01-24 14:59:12.889327 7f4f47f49780 -1 journal read_header error decoding journal header
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.051076 7f4f47f49780 -1 filestore(/var/lib/ceph/osd/ceph-4) could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220053 7f4f47f49780 -1 created object store /var/lib/ceph/osd/ceph-4 journal /var/lib/ceph/osd/ceph-4/journal for osd.4 fsid 632d789a-8560-469b-bf6a-8478e12d2cb6
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220135 7f4f47f49780 -1 auth: error reading file: /var/lib/ceph/osd/ceph-4/keyring: can't open /var/lib/ceph/osd/ceph-4/keyring: (2) No such file or directory
[r-cephosd302][WARNIN] 2014-01-24 14:59:13.220572 7f4f47f49780 -1 created new key in keyring /var/lib/ceph/osd/ceph-4/keyring
[r-cephosd302][WARNIN] added key for osd.4
root@r-cephrgw01:/etc/ceph# ceph -s
    cluster 632d789a-8560-469b-bf6a-8478e12d2cb6
     health HEALTH_OK
     monmap e3: 3 mons at {r-cephosd101=10.194.182.41:6789/0,r-cephosd102=10.194.182.42:6789/0,r-cephosd103=10.194.182.43:6789/0}, election epoch 6, quorum 0,1,2 r-cephosd101,r-cephosd102,r-cephosd103
     osdmap e37: 5 osds: 5 up, 5 in
      pgmap v240: 192 pgs, 3 pools, 0 bytes data, 0 objects
            139 MB used, 4146 GB / 4146 GB avail
                 192 active+clean

root@r-cephrgw01:/etc/ceph# ceph osd tree
# id    weight  type name       up/down reweight
-1      6.77    root default
-2      0.45            host r-cephosd101
0       0.45                    osd.0   up      1
-3      0.45            host r-cephosd102
1       0.45                    osd.1   up      1
-4      0.45            host r-cephosd103
2       0.45                    osd.2   up      1
-5      2.71            host r-cephosd301
3       2.71                    osd.3   up      1
-6      2.71            host r-cephosd302
4       2.71                    osd.4   up      1
		
Now, the new osd is up....

I didn't understand where the problem is...

Why isn't the "osd journal size" in the osd.# section taken into account?
Why does ceph try to recreate osd.0?
Why does ceph-deploy indicate that the osd is ready for use?
Why doesn't ceph-deploy create all the files?
Why is the bootstrap-osd not correct?

Thanks


- - - - - - - - - - - - - - - - - 
Ghislain Chevalier
ORANGE LABS FRANCE
Storage Service Architect
 +33299124432
ghislain.chevalier@orange.com 


_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.

This message and its attachments may contain confidential or privileged information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
Thank you.

