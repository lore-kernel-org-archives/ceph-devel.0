From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Sat, 16 Feb 2013 12:51:46 +0100
Message-ID: <511F72D2.5020104@mermaidconsulting.dk>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net> <511D3A35.7090702@mermaidconsulting.dk> <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:39183 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033Ab3BPLvv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Feb 2013 06:51:51 -0500
In-Reply-To: <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

Hi Sage,

> 1) Decide what output format to use.  We want to use something that i=
s=20

I have given it some thought, and my initial suggestion to keep things=20
simple is to use the QCOW2 image format.

The birds eye view of the process would be as follows:

* Initial backup

User supplied information: pool, image name

Create rbd snapshot of the image named "backup_1", where 1 could be a=20
timestamp or an integer count.

Save the snapshot to a standard qcow2 image. Similar to:

qemu-img convert rbd:data/myimage@backup_1 -O qcow2=20
data_myimage_backup_1.qcow2

Note: I don't know if qemu-img actually supports reading from snapshots=
=20
currently.


* Incremental backup

User supplied information: pool, image name, path to initial backup or=20
previous incremental file

Create rbd snapshot of the image named "backup_2", where 2 could be a=20
timestamp or an integer count.

Determine previous snapshot identifier from given file name.

Determine objects changed from the snapshot given by that identifier an=
d=20
the newly created snapshot.

Construct QCOW2 L1- and L2-tables in memory from that changeset.

Create new qcow2 image with the previous backup file as the backing=20
image, and write out the tables and changed blocks.

Delete previous rbd snapshot.


* Restoring and mounting


The use of the QCOW2 format means that we can use existing tools for=20
restoring and mounting the backups.

To restore a backup the user can simply choose either the initial backu=
p=20
file or an incremental, and use qemu-img to copy that to a new rbd imag=
e.

To mount the initial backup or an incremental, the user can use qemu-nb=
d=20
to mount and explore the backup to determine which one to restore.

The performance of restores and mounts would ofcourse be weakened if th=
e=20
backup consists of a large number of incrementals. In that case the=20
existing qemu-img tool could be used to flatten the backup.


* Pros/cons

The QCOW2 format support compression, so we could implement compressed=20
backups without much effort.

The disadvantages to using QCOW2 like this is that we do not have any=20
checksumming or safe guards against potential errors such as users=20
mixing up images.

Another disadvantage to this approach is that vital information is=20
stored in the actual filename of the backup file. I don't see any place=
=20
in the QCOW2 file format for storing this information inside the file,=20
sadly.

We could opt for storing it inside a plain text file that accompanies=20
the QCOW2 file, or tarballing the qcow2 file and that plain text file.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
