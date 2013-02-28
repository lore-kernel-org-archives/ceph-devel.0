From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Thu, 28 Feb 2013 15:33:43 -0800
Message-ID: <512FE957.9040703@inktank.com>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net> <511D3A35.7090702@mermaidconsulting.dk> <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net> <511F72D2.5020104@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57731 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab3B1XeK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 18:34:10 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so1428700pad.20
        for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 15:34:09 -0800 (PST)
In-Reply-To: <511F72D2.5020104@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Sage Weil <sage@inktank.com>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 02/16/2013 03:51 AM, Jens Kristian S=F8gaard wrote:
> Hi Sage,
>
>> 1) Decide what output format to use.  We want to use something that =
is
>
> I have given it some thought, and my initial suggestion to keep thing=
s
> simple is to use the QCOW2 image format.
>
> The birds eye view of the process would be as follows:
>
> * Initial backup
>
> User supplied information: pool, image name
>
> Create rbd snapshot of the image named "backup_1", where 1 could be a
> timestamp or an integer count.
>
> Save the snapshot to a standard qcow2 image. Similar to:
>
> qemu-img convert rbd:data/myimage@backup_1 -O qcow2
> data_myimage_backup_1.qcow2
>
> Note: I don't know if qemu-img actually supports reading from snapsho=
ts
> currently.

It does.

> * Incremental backup
>
> User supplied information: pool, image name, path to initial backup o=
r
> previous incremental file
>
> Create rbd snapshot of the image named "backup_2", where 2 could be a
> timestamp or an integer count.
>
> Determine previous snapshot identifier from given file name.
>
> Determine objects changed from the snapshot given by that identifier =
and
> the newly created snapshot.
>
> Construct QCOW2 L1- and L2-tables in memory from that changeset.
>
> Create new qcow2 image with the previous backup file as the backing
> image, and write out the tables and changed blocks.
>
> Delete previous rbd snapshot.
>
>
> * Restoring and mounting
>
>
> The use of the QCOW2 format means that we can use existing tools for
> restoring and mounting the backups.
>
> To restore a backup the user can simply choose either the initial bac=
kup
> file or an incremental, and use qemu-img to copy that to a new rbd im=
age.
>
> To mount the initial backup or an incremental, the user can use qemu-=
nbd
> to mount and explore the backup to determine which one to restore.
>
> The performance of restores and mounts would ofcourse be weakened if =
the
> backup consists of a large number of incrementals. In that case the
> existing qemu-img tool could be used to flatten the backup.
>
>
> * Pros/cons
>
> The QCOW2 format support compression, so we could implement compresse=
d
> backups without much effort.
>
> The disadvantages to using QCOW2 like this is that we do not have any
> checksumming or safe guards against potential errors such as users
> mixing up images.
>
> Another disadvantage to this approach is that vital information is
> stored in the actual filename of the backup file. I don't see any pla=
ce
> in the QCOW2 file format for storing this information inside the file=
,
> sadly.
>
> We could opt for storing it inside a plain text file that accompanies
> the QCOW2 file, or tarballing the qcow2 file and that plain text file=
=2E

qcow2 seems like a good initial format given the existing tools. We
could always add another format later, or wrap it with extra
information like you suggest.

Have you had a chance to start implementing this yet? It'd be great to
get it working in the next month.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
