From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: [ceph-osd] sloppy crc check fail and osd down
Date: Thu, 1 Jun 2017 20:28:54 +0800
Message-ID: <CAE5T3NynLEkWfg1cJqRDKibDUyiDJmvN+o3VuEGLo=pvKQxLSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32980 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdFAM24 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 08:28:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so10968819wmh.0
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 05:28:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers,

 I encounter an osd dump problem, log shows as below,

2017-04-21 05:46:53.764912 7f8e3134a700 0 filestore(/data/osd/osd.243)
FileStore::read
1.af36_head/a9c4af36/zone-wzr11.3412686.21__multipart_vod-99513923_2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5/head//1
0~4194304 ... BAD CRC:
offset 3407872 len 65536 has crc 3699171359 expected 3081294859

2017-04-21 05:46:53.840907 7f8e3134a700 -1 os/FileStore.cc: In
function 'virtual int FileStore::read(coll_t, const ghobject_t&,
uint64_t, size_t, ceph::bufferlist&, uint32_t, bool)' thread
7f8e3134a700 time 2017-04-21 05:46:53.765286
os/FileStore.cc: 2892: FAILED assert(0 == "bad crc on read")

ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0xc250a5]
 2: (FileStore::read(coll_t, ghobject_t const&, unsigned long,
unsigned long, ceph::buffer::list&, unsigned int, bool)+0x5db)
[0x8a752b]
 3: (ReplicatedBackend::objects_read_sync(hobject_t const&, unsigned
long, unsigned long, unsigned int, ceph::buffer::list*)+0x96)
[0xae5936]
 4: (ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*,
std::vector&lt;OSDOp, std::allocator&lt;OSDOp&gt; >&)+0x2876)
[0x9fdc16]
 5: (ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*)+0xcf)
[0xa08fcf]
 6: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0x893) [0xa09993]
 7: (ReplicatedPG::do_op(std::tr1::shared_ptr&lt;OpRequest&gt;&)+0x2548)
[0xa0cf18]
 8: (ReplicatedPG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;&,
ThreadPool::TPHandle&)+0x463) [0x9a77c3]

Disks are healthy and there is no error log in sys message. I can't
find the culprit.

The cluster ceph version is : 0.94.1

When I start the down osd up, and read the file
vod-99513923_2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv,
the osd went down again.

After deep check the problem file
"zone-wzr11.3412686.21__multipart_vod-99513923_2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5"
 in osds, I find md5sum differs between the replica set osds.

PRIMARY
[root@wzR11-132 DIR_C]# ls -l
zone-wzr11.3412686.21\\u\\umultipart\\uvod-99513923\\u2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5__head_A9C4AF36__1
-rw-r--r-- 1 root root 4194304 Apr 12 04:14
zone-wzr11.3412686.21\u\umultipart\uvod-99513923\u2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5__head_A9C4AF36__1

mds5sum :  f3f910623270d18c6897bd5bed44b89f


SECONDARY1
[root@wzR11-120 DIR_C]# ls -l zone-wzr11.3412686.21\\u\\umultipart\\uvod-995*
-rw-r--r-- 1 root root 4194304 Apr 12 04:14
zone-wzr11.3412686.21\u\umultipart\uvod-99513923\u2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5__head_A9C4AF36__1

md5sum:  94497a2f9c62c84628eb70c6bb8844fd

SECONDARY2

[root@wzR11-139 DIR_C]# ls -l
zone-wzr11.3412686.21\\u\\umultipart\\uvod-99513923\\u2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5__head_A9C4AF36__1
-rw-r--r-- 1 root root 4194304 Apr 12 04:14
zone-wzr11.3412686.21\u\umultipart\uvod-99513923\u2ce07d31-66e1-4d4e-ae75-fd86850a758e--20170412030045.flv.2~ukC7CODkZERVp9ffUqlmVRpeScHJYeO.5__head_A9C4AF36__1

md5sum:  94497a2f9c62c84628eb70c6bb8844fd


I have an idea to rename the file from the primary osd, and copy it
from secondary osd  and set attrs as it is before. But I think this
methord is too rigid and complicated if there are lots of xattrs.

Are there some quick methords to deal with the problem?

cheeks,

brandy
