From: Nathan Regola <nregola@nd.edu>
Subject: cephx questions
Date: Fri, 30 Jul 2010 17:55:42 -0400
Message-ID: <7083006A98B5314F86152D05FFB1B99814AAEF06FF@ICE-MBX-2.ice.nd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-p1.cc.nd.edu ([129.74.250.57]:48303 "EHLO mx-p1.cc.nd.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab0G3Vzr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 17:55:47 -0400
Received: from ICE-Hub-p1.ice.nd.edu (ice-hub-p1.ice.nd.edu [172.21.126.20])
	by mx-p1.cc.nd.edu (Switch-3.3.0/Switch-3.3.0) with ESMTP id o6ULrVcX019225
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 17:53:32 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Thank you for this excellent project.=A0 Are you still planning on inco=
rporating the code from the Maat paper at some time in the future? As I=
'm sure you already know, access control lists on the storage objects w=
ould be quite useful to store research data.=A0=20

We are experimenting with a small ceph cluster (3 older Sun V20z server=
s with 2 SCSI drives each). To give you a brief overview of our setup, =
we have one MDS/monitoring node and 2 OSDs.=A0 The OSDs have 16GB of RA=
M and the MDS/monitoring node has 12GB.=A0 We are using btrfs on a dedi=
cated drive, mounted as /btrfs (each node has this mount). On the OSDs,=
 we also use a partition on the boot disk as /btrfs_journal for the jou=
rnal and the data is on the second drive, mounted as /btrfs.=A0 We only=
 have toy data on the file system, so we can reformat the ceph file sys=
tem as needed.
=A0
We attempted an in place upgrade to 0.21 yesterday.=A0 =A0Upon restarti=
ng the ceph processes on the MDS/monitoring node, we could no longer lo=
gin to ceph due to cephx authentication failure.=A0 We did not change t=
he configuration in /etc/ceph/ceph.conf. I was able to disable cephx, a=
nd eventually imported some keys and put the admin_keyring.bin file in =
/etc/ceph/keyring.bin and I can login now.=A0 Was the code changed to e=
nforce cephx or stop looking in certain locations for keys?=A0 I believ=
e it was enabled before, but it never complained.=20

Also, what causes an MDS to be blacklisted?=A0 Until I fixed the authen=
tication issues, "ceph mds stat" returned "3 blacklisted MDS".=A0 We on=
ly have 1 MDS, so I was curious what this error message meant.=A0 If I =
disabled cephx and restarted the MDS/monitoring services, it didn't sho=
w any blacklisted MDS.=A0 I assume blacklisting is related to an unauth=
enticated MDS in the cluster?? If this documentation exists, I apologiz=
e for these questions.=A0 I was interested in more detailed information=
 on cephx (where is the auth database stored) and what the various keyr=
ing lines in the ceph.conf file control.=A0 Also, is there a baseline s=
ample of what your "ceph auth list" output should look like and the min=
imum capabilities various entities need to function? I pasted a redacte=
d version of our "auth list" output below. Perhaps we have an error in =
our authorization list that caused the errors we experienced after the =
upgrade (and before I changed some things).=A0 I can send a ceph.conf f=
ile as well if you need it.=A0=20

We can provide feedback on cephx code if you need it, as we were planni=
ng on keeping our cluster "cephx enabled".=A0=20

Thanks,

Nathan Regola
Grid and Cloud Computing Analyst
University of Notre Dame
Center for Research Computing
P.O. Box 539
Room 110 Information Technology Center
Notre Dame, IN=A0 46556

Phone: 574-631-5287


10.07.30_13:07:08.584179 mon <- [auth,list]
10.07.30_13:07:08.584825 mon0 -> 'installed auth entries:=20
mon.0
=A0=A0=A0=A0=A0=A0=A0 key: T
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
mds.opteron03
=A0=A0=A0=A0=A0=A0=A0 key: U
=A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
osd.0
=A0=A0=A0=A0=A0=A0=A0 key: V
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
osd.1
=A0=A0=A0=A0=A0=A0=A0 key: W
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
client.admin
=A0=A0=A0=A0=A0=A0=A0 key: X
=A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
' (0)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
