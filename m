From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Fri, 2 Jul 2010 01:42:14 +0200
Message-ID: <AANLkTikg5bx9nYZAz2qZJ6gjOm66EtI49VTieQBaFQ_K@mail.gmail.com>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
	<Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
	<AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
	<Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
	<AANLkTikG7OsUyBtXXfO2tI-T2LzwVOlIb32UFtPFs41z@mail.gmail.com>
	<Pine.LNX.4.64.1006301424200.29167@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43325 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab0GAXmQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 19:42:16 -0400
Received: by ewy23 with SMTP id 23so928218ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jul 2010 16:42:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1006301424200.29167@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2010/7/1 Sage Weil <sage@newdream.net>:
> Can you do the same, but with
>
> =A0 =A0 =A0 =A0debug filestore =3D 20
> =A0 =A0 =A0 =A0debug journal =3D 20
> =A0 =A0 =A0 =A0debug osd =3D 20
>
> I'm not sure where that length 5120 write is coming from.
>
Neither do I ;)

Sorry for not taking much more time to trace myself, here is however a
more detailed log output:

10.07.02_01:11:40.764748 --- opened log /var/log/ceph/debian-vm1.2181 -=
--
ceph version 0.21~rc (3235abe91863b3bffe5638b2169603f7d89ea375)
10.07.02_01:11:40.764859 7f17ea49a720 ---- renamed symlink
/var/log/ceph/osd0 -> /var/log/ceph/osd0.0 ----
10.07.02_01:11:40.764904 7f17ea49a720 ---- created symlink
/var/log/ceph/osd0 -> debian-vm1.2181 ----
10.07.02_01:11:40.764981 7f17ea49a720 -- :/0 register_entity client?
10.07.02_01:11:40.765015 7f17ea49a720 -- :/0 register_entity client? at=
 :/0
10.07.02_01:11:40.765038 7f17ea49a720 -- :/0 ready :/0
10.07.02_01:11:40.765152 7f17ea49a720 -- :/2181 messenger.start
10.07.02_01:11:40.765276 7f17ea49a720 -- :/2181 shutdown :/2181
10.07.02_01:11:40.765304 7f17ea49a720 -- :/2181 shutdown i am not
dispatch, setting stop flag and joining thread.
10.07.02_01:11:40.765361 7f17ea49a720 -- :/2181 wait: still active
10.07.02_01:11:40.765564 7f17ea49a720 -- :/2181 wait: woke up
10.07.02_01:11:40.765596 7f17ea49a720 -- :/2181 wait: everything stoppe=
d
10.07.02_01:11:40.765608 7f17ea49a720 -- :/2181 wait: closing pipes
10.07.02_01:11:40.765620 7f17ea49a720 -- :/2181 reaper
10.07.02_01:11:40.765629 7f17ea49a720 -- :/2181 reaper done
10.07.02_01:11:40.765638 7f17ea49a720 -- :/2181 wait: waiting for
pipes  to close
10.07.02_01:11:40.765647 7f17ea49a720 -- :/2181 wait: done.
10.07.02_01:11:40.765656 7f17ea49a720 -- :/2181 shutdown complete.
10.07.02_01:11:40.765730 7f17ea49a720 filestore(/data/osd0) mkfs in /da=
ta/osd0
10.07.02_01:11:40.765795 7f17ea49a720 filestore(/data/osd0) mkfs
removing old file fsid
10.07.02_01:11:40.765845 7f17ea49a720 filestore(/data/osd0) mkfs fsid
is 29089128
10.07.02_01:11:40.765866 7f17ea49a720 filestore(/data/osd0)
BTRFS_IOC_SUBVOL_CREATE ioctl failed, trying mkdir /data/osd0/current
10.07.02_01:11:40.765901 7f17ea49a720 filestore(/data/osd0)
open_journal at /ceph-journal/osd0
10.07.02_01:11:40.765920 7f17ea49a720 journal create /ceph-journal/osd0
10.07.02_01:11:40.765953 7f17ea49a720 journal _open extending to 268435=
456 bytes
10.07.02_01:11:40.765973 7f17ea49a720 journal _open journal is not a
block device, NOT checking disk write cache on /ceph-journal/osd0
10.07.02_01:11:40.765984 7f17ea49a720 journal _open /ceph-journal/osd0
fd 5: 268435456 bytes, block size 1024 bytes, directio =3D 1
10.07.02_01:11:40.765995 7f17ea49a720 journal header: block_size 1024
alignment 1024 max_size 268435456
10.07.02_01:11:40.766003 7f17ea49a720 journal header: start 1024
10.07.02_01:11:40.766010 7f17ea49a720 journal  write_pos 0
10.07.02_01:11:40.771483 7f17ea49a720 journal create done
10.07.02_01:11:40.771511 7f17ea49a720 filestore(/data/osd0) mkjournal
created journal on /ceph-journal/osd0
10.07.02_01:11:40.771531 7f17ea49a720 filestore(/data/osd0) mkfs done
in /data/osd0
10.07.02_01:11:40.771543 7f17ea49a720 filestore(/data/osd0) basedir
/data/osd0 journal /ceph-journal/osd0
10.07.02_01:11:40.771580 7f17ea49a720 filestore(/data/osd0) mount did
NOT detect btrfs
10.07.02_01:11:40.771601 7f17ea49a720 filestore(/data/osd0) mount fsid
is 29089128
10.07.02_01:11:40.771623 7f17ea49a720 filestore(/data/osd0) mount found=
 snaps <>
10.07.02_01:11:40.771648 7f17ea49a720 filestore(/data/osd0) mount op_se=
q is 0
10.07.02_01:11:40.771658 7f17ea49a720 filestore(/data/osd0)
open_journal at /ceph-journal/osd0
10.07.02_01:11:40.771668 7f17ea49a720 journal journal_replay fs op_seq =
0
10.07.02_01:11:40.771677 7f17ea49a720 journal open /ceph-journal/osd0 n=
ext_seq 1
10.07.02_01:11:40.771687 7f17ea49a720 journal _open journal is not a
block device, NOT checking disk write cache on /ceph-journal/osd0
10.07.02_01:11:40.771696 7f17ea49a720 journal _open /ceph-journal/osd0
fd 9: 268435456 bytes, block size 1024 bytes, directio =3D 1
10.07.02_01:11:40.771703 7f17ea49a720 journal read_header
10.07.02_01:11:40.782354 7f17ea49a720 journal header: block_size 1024
alignment 1024 max_size 268435456
10.07.02_01:11:40.782443 7f17ea49a720 journal header: start 1024
10.07.02_01:11:40.782485 7f17ea49a720 journal  write_pos 1024
10.07.02_01:11:40.782640 7f17ea49a720 journal open header.fsid =3D 2908=
9128
10.07.02_01:11:40.782721 7f17ea49a720 journal read_entry 1024 : bad
header magic, end of journal
10.07.02_01:11:40.782751 7f17ea49a720 journal open reached end of journ=
al.
10.07.02_01:11:40.782805 7f17ea49a720 journal read_entry 1024 : bad
header magic, end of journal
10.07.02_01:11:40.782853 7f17ea49a720 journal journal_replay: end of
journal, done.
10.07.02_01:11:40.782924 7f17ea49a720 journal _open journal is not a
block device, NOT checking disk write cache on /ceph-journal/osd0

0.07.02_01:11:40.782978 7f17ea49a720 journal _open /ceph-journal/osd0
fd 9: 268435456 bytes, block size 1024 bytes, directio =3D 1
10.07.02_01:11:40.783121 7f17ea49a720 journal journal_start
10.07.02_01:11:40.784591 7f17ea49a720 filestore(/data/osd0) apply queue=
d
10.07.02_01:11:40.784652 7f17ea49a720 filestore(/data/osd0)
queue_transactions (writeahead) 1 0x7fff1d91ce40
10.07.02_01:11:40.784721 7f17ea49a720 journal journal_transactions 1
10.07.02_01:11:40.784785 7f17ea49a720 journal submit_entry seq 1 len
206 (0x18e4610)
10.07.02_01:11:40.785023 7f17e7dae710 filestore(/data/osd0) sync_entry
waiting for max_interval 5.000000
10.07.02_01:11:40.785153 7f17e8db0710 journal write_thread_entry start
10.07.02_01:11:40.785228 7f17e8db0710 journal room 268434431 max_size
268435456 pos 1024 header.start 1024 top 1024
10.07.02_01:11:40.785277 7f17e8db0710 journal check_for_full at 1024 :
5120 < 268434431
10.07.02_01:11:40.785323 7f17e8db0710 journal prepare_single_write 1
will write 1024 : seq 1 len 206 -> 5120 (head 40 pre_pad 4056 ebl 206
post_pad 778 tail 40) (ebl alignment 0)
10.07.02_01:11:40.785401 7f17e8db0710 journal prepare_multi_write
queue_pos now 6144
10.07.02_01:11:40.785474 7f17e8db0710 journal do_write writing
1024~5120 + header
10.07.02_01:11:40.786492 7f17e65ab710 filestore(/data/osd0) flusher_ent=
ry start
10.07.02_01:11:40.786653 7f17e65ab710 filestore(/data/osd0)
flusher_entry sleeping
10.07.02_01:11:40.787092 7f17e8db0710 journal rebuild_page_aligned
failed, buffer::list(len=3D5120,
        buffer::ptr(0~5120 0x18ed410 in raw 0x18ed410 len 5120 nref 1)
)
os/FileJournal.cc: In function 'void FileJournal::write_bl(off64_t&,
ceph::bufferlist&)':
os/FileJournal.cc:508: FAILED assert((bl.length() & ~ceph::_page_mask) =
=3D=3D 0)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x2a2) [0x55b362]
 2: (FileJournal::write_thread_entry()+0x1fa) [0x55da6a]
 3: (FileJournal::Writer::entry()+0xd) [0x54f04d]
 4: (Thread::_entry_func(void*)+0x7) [0x46ca97]
 5: (()+0x68ba) [0x7f17e9e7c8ba]
 6: (clone()+0x6d) [0x7f17e909701d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Sebastien
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
