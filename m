From: Ian Colle <ian.colle@inktank.com>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Thu, 28 Feb 2013 17:43:45 -0700
Message-ID: <CD5546FE.68BD%ian.colle@inktank.com>
References: <512FE957.9040703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:46836 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab3CAAnz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 19:43:55 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so2176403iaf.28
        for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 16:43:55 -0800 (PST)
In-Reply-To: <512FE957.9040703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, Jens Kristian =?ISO-8859-1?B?U/hnYWFyZA==?= <jens@mermaidconsulting.dk>
Cc: Sage Weil <sage@inktank.com>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

Please see:
http://tracker.ceph.com/issues/4084 rbd: incremental backups

http://tracker.ceph.com/issues/3387 librbd: expose changed objects sinc=
e a
given snapshot

http://tracker.ceph.com/issues/3272 send/receive rbd snapshots


It would be great if we could track this discussion in those tickets.

Ian R. Colle
Ceph Program Manager
Inktank
Cell: +1.303.601.7713 <tel:%2B1.303.601.7713>
Email: ian@inktank.com


 <http://www.linkedin.com/in/ircolle>
 <http://www.twitter.com/ircolle>




On 2/28/13 4:33 PM, "Josh Durgin" <josh.durgin@inktank.com> wrote:

>On 02/16/2013 03:51 AM, Jens Kristian S=F8gaard wrote:
>> Hi Sage,
>>
>>> 1) Decide what output format to use.  We want to use something that=
 is
>>
>> I have given it some thought, and my initial suggestion to keep thin=
gs
>> simple is to use the QCOW2 image format.
>>
>> The birds eye view of the process would be as follows:
>>
>> * Initial backup
>>
>> User supplied information: pool, image name
>>
>> Create rbd snapshot of the image named "backup_1", where 1 could be =
a
>> timestamp or an integer count.
>>
>> Save the snapshot to a standard qcow2 image. Similar to:
>>
>> qemu-img convert rbd:data/myimage@backup_1 -O qcow2
>> data_myimage_backup_1.qcow2
>>
>> Note: I don't know if qemu-img actually supports reading from snapsh=
ots
>> currently.
>
>It does.
>
>> * Incremental backup
>>
>> User supplied information: pool, image name, path to initial backup =
or
>> previous incremental file
>>
>> Create rbd snapshot of the image named "backup_2", where 2 could be =
a
>> timestamp or an integer count.
>>
>> Determine previous snapshot identifier from given file name.
>>
>> Determine objects changed from the snapshot given by that identifier=
 and
>> the newly created snapshot.
>>
>> Construct QCOW2 L1- and L2-tables in memory from that changeset.
>>
>> Create new qcow2 image with the previous backup file as the backing
>> image, and write out the tables and changed blocks.
>>
>> Delete previous rbd snapshot.
>>
>>
>> * Restoring and mounting
>>
>>
>> The use of the QCOW2 format means that we can use existing tools for
>> restoring and mounting the backups.
>>
>> To restore a backup the user can simply choose either the initial ba=
ckup
>> file or an incremental, and use qemu-img to copy that to a new rbd
>>image.
>>
>> To mount the initial backup or an incremental, the user can use qemu=
-nbd
>> to mount and explore the backup to determine which one to restore.
>>
>> The performance of restores and mounts would ofcourse be weakened if=
 the
>> backup consists of a large number of incrementals. In that case the
>> existing qemu-img tool could be used to flatten the backup.
>>
>>
>> * Pros/cons
>>
>> The QCOW2 format support compression, so we could implement compress=
ed
>> backups without much effort.
>>
>> The disadvantages to using QCOW2 like this is that we do not have an=
y
>> checksumming or safe guards against potential errors such as users
>> mixing up images.
>>
>> Another disadvantage to this approach is that vital information is
>> stored in the actual filename of the backup file. I don't see any pl=
ace
>> in the QCOW2 file format for storing this information inside the fil=
e,
>> sadly.
>>
>> We could opt for storing it inside a plain text file that accompanie=
s
>> the QCOW2 file, or tarballing the qcow2 file and that plain text fil=
e.
>
>qcow2 seems like a good initial format given the existing tools. We
>could always add another format later, or wrap it with extra
>information like you suggest.
>
>Have you had a chance to start implementing this yet? It'd be great to
>get it working in the next month.
>
>Josh
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
