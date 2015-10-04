From: David Casier <david.casier@aevoo.fr>
Subject: [newstore] OSD crashed and don't restart
Date: Sun, 04 Oct 2015 19:55:50 +0200
Message-ID: <56116826.8070208@aevoo.fr>
References: <560F9781.8060004@dachary.org>	<CAP3mxSxDmCYGPxxs5JDAx48Sugi3msmaB7ZmmYG26yjiwdmCFQ@mail.gmail.com>	<56113BC9.30500@dachary.org> <CAP3mxSwYTQOZ5UJv9TbB_F2HnsNaGVqJkyTEesq5Og3MTHXHkA@mail.gmail.com> <56116354.5000601@aevoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:42417 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbJDR5I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 4 Oct 2015 13:57:08 -0400
Received: from [192.168.1.97] (84.197.151.77.rev.sfr.net [77.151.197.84])
	by aevoo.fr (Postfix) with ESMTPSA id 2DF2E40246
	for <ceph-devel@vger.kernel.org>; Sun,  4 Oct 2015 19:57:05 +0200 (CEST)
In-Reply-To: <56116354.5000601@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

> Hello everybody,
> With newstore (+rocksdb) OSD crashed when i tried to format a device rbd
>
> And when i want to restart :
>
> 2015-10-04 17:58:48.445653 7f8f96d43980  0 *ceph version 
> 9.0.3-2146-gd1e6976* (d1e697628931775e7fcdbb79a76ddd8e7dedffd5), 
> process ceph-osd, pid 18359
> 2015-10-04 17:58:48.445662 7f8f96d43980 -1 WARNING: experimental 
> feature 'newstore' is enabled
> Please be aware that this feature is experimental, untested,
> unsupported, and may result in data corruption, data loss,
> and/or irreparable damage to your cluster.  Do not use
> feature with important data.
>
> 2015-10-04 17:58:48.447938 7f8f96d43980 -1 WARNING: the following 
> dangerous and experimental features are enabled: newstore,rocksdb
> 2015-10-04 17:58:48.453264 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) _open_path using fs driver 'generic'
> 2015-10-04 17:58:48.453390 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) mount path /var/lib/ceph/osd/ceph-0
> 2015-10-04 17:58:48.453394 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) _open_path using fs driver 'generic'
> 2015-10-04 17:58:48.453406 7f8f96d43980 -1 WARNING: experimental 
> feature 'rocksdb' is enabled
> Please be aware that this feature is experimental, untested,
> unsupported, and may result in data corruption, data loss,
> and/or irreparable damage to your cluster.  Do not use
> feature with important data.
>
> 2015-10-04 17:58:48.460232 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) _open_db opened rocksdb path 
> /var/lib/ceph/osd/ceph-0 options
> 2015-10-04 17:58:48.460483 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) _recover_next_fid old fid_max 1/1024
> 2015-10-04 17:58:48.460518 7f8f96d43980  1 
> newstore(/var/lib/ceph/osd/ceph-0) _recover_next_nid old nid_max 4096
> 2015-10-04 17:58:48.469128 7f8f96d43980 -1 
> newstore(/var/lib/ceph/osd/ceph-0) _do_wal_transaction zero on 21 got: 
> (95) Operation not supported
> 2015-10-04 17:58:48.773657 7f8f96d43980 -1 osd.0 0 OSD:init: unable to 
> mount object store
> 2015-10-04 17:58:48.773673 7f8f96d43980 -1 ^[[0;31m ** ERROR: osd init 
> failed: (95) Operation not supported
>
>
> And with newstore debug
> (...)
> 2015-10-04 18:16:59.243196 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _open_collections opened 1.fc_head
> 2015-10-04 18:16:59.243206 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _open_collections opened 1.fd_head
> 2015-10-04 18:16:59.243219 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _open_collections opened 1.fe_head
> 2015-10-04 18:16:59.243229 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _open_collections opened 1.ff_head
> 2015-10-04 18:16:59.243238 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _open_collections opened meta
> 2015-10-04 18:16:59.243242 7f8b53f8d980 10 
> newstore(/var/lib/ceph/osd/ceph-0) _aio_start
> 2015-10-04 18:16:59.243318 7f8b53f8d980 10 
> newstore(/var/lib/ceph/osd/ceph-0) _wal_replay start
> 2015-10-04 18:16:59.243331 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _wal_replay replay 000000000000003c
> 2015-10-04 18:16:59.243326 7f8b46495700 10 
> newstore(/var/lib/ceph/osd/ceph-0) _aio_thread start
> 2015-10-04 18:16:59.243334 7f8b53f8d980 20 
> newstore(/var/lib/ceph/osd/ceph-0) _do_wal_transaction zero 1/4~ 0~1048576
> 2015-10-04 18:16:59.243336 7f8b46495700 40 
> newstore(/var/lib/ceph/osd/ceph-0) _aio_thread polling
> 2015-10-04 18:16:59.243342 7f8b53f8d980 30 
> newstore(/var/lib/ceph/osd/ceph-0) _open_fid 1/4~ = 21 (open by handle)
> 2015-10-04 18:16:59.243967 7f8b53f8d980 -1 
> newstore(/var/lib/ceph/osd/ceph-0) _do_wal_transaction zero on 21 got: 
> (95) Operation not supported
> 2015-10-04 18:16:59.243979 7f8b53f8d980 10 
> newstore(/var/lib/ceph/osd/ceph-0) _aio_stop
> 2015-10-04 18:16:59.493405 7f8b46495700 10 
> newstore(/var/lib/ceph/osd/ceph-0) _aio_thread end
> 2015-10-04 18:16:59.583752 7f8b53f8d980 -1 osd.0 0 OSD:init: unable to 
> mount object store
> 2015-10-04 18:16:59.583768 7f8b53f8d980 -1  ** ERROR: osd init failed: 
> (95) Operation not supported
>
>
> That sounds like an OP_ZERO transaction (file descriptor 21)
>
> strace :
> [pid 21569] fallocate(21, 02, 0, 1048576) = -1 EOPNOTSUPP (Operation 
> not supported)
>
>
> I have the same error ext4 and xfs
>
> Kernel : 3.18.16-gentoo
>
> EXT4 :
>  - mount option user_xattr
>  - tune2fs -l
> tune2fs 1.42.13 (17-May-2015)
> Filesystem volume name:   <none>
> Last mounted on:          /var/lib/ceph/osd/ceph-0
> Filesystem UUID: 6027ad59-ed92-4975-b505-771ef9604fe4
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      ext_attr dir_index sparse_super2 filetype 
> extent flex_bg large_file huge_file
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         not clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              7640576
> Block count:              977974998
> Reserved block count:     48898749
> Free blocks:              977675828
> Free inodes:              7640565
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         256
> Inode blocks per group:   8
> Flex block group size:    32768
> Filesystem created:       Sun Oct  4 12:07:15 2015
> Last mount time:          Sun Oct  4 12:07:22 2015
> Last write time:          Sun Oct  4 12:07:22 2015
> Mount count:              1
> Maximum mount count:      -1
> Last checked:             Sun Oct  4 12:07:15 2015
> Check interval:           0 (<none>)
> Lifetime writes:          1166 MB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               128
> Default directory hash:   half_md4
> Directory Hash Seed: 42eb03b4-82f8-48c1-9793-0015490c4c4a
> Backup block groups:      1 29845
>

