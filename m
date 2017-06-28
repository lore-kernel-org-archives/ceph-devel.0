From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Are we ready for 10.2.8 - core
Date: Thu, 29 Jun 2017 09:33:18 +1000
Message-ID: <CAF-wwdHwt8vZ9XM=JnzqVTu_wcJYL-wnkTtGCgS_XRA+RPiw8g@mail.gmail.com>
References: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz> <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
 <6663b229-6570-1d2c-1c2f-2ebf5105173f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35679 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdF1XdU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 19:33:20 -0400
Received: by mail-io0-f181.google.com with SMTP id h134so44747500iof.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 16:33:19 -0700 (PDT)
In-Reply-To: <6663b229-6570-1d2c-1c2f-2ebf5105173f@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The scub failure, 1333073, is because of ENOSPC and likely not related
to PR 15529.

2017-06-28T04:33:13.822
INFO:tasks.ceph.osd.3.smithi021.stderr:2017-06-28 04:33:13.821159
7f8b79a48700 -1 filestore(/var/lib/ceph/osd/ceph-3) error creating
#0:b8d9db9e:::obj-i5cXoRqJT52PTET:head#
(/var/lib/ceph/osd/ceph-3/current/0.d_head/DIR_D/DIR_1/DIR_B/obj-i5cXoRqJT52PTET__head_79DB9B1D__0)
in index: (28) No space left on device

2017-06-28T04:33:13.826
INFO:tasks.ceph.osd.3.smithi021.stderr:os/filestore/FileStore.cc: In
function 'void FileStore::_do_transaction(ObjectStore::Transaction&,
uint64_t, int, ThreadPool::TPHandle*)' thread 7f8b79a48700 time
2017-06-28 04:33:13.821210
2017-06-28T04:33:13.828
INFO:tasks.ceph.osd.3.smithi021.stderr:os/filestore/FileStore.cc:
2920: FAILED assert(0 == "unexpected error")
2017-06-28T04:33:13.838 INFO:tasks.ceph.osd.3.smithi021.stderr: ceph
version 10.2.7-428-gca7ab74 (ca7ab74ae7884f24983d94b729cc262108ff6aba)
2017-06-28T04:33:13.840 INFO:tasks.ceph.osd.3.smithi021.stderr: 1:
(ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f8b87517ac5]
2017-06-28T04:33:13.856 INFO:tasks.ceph.osd.3.smithi021.stderr: 2:
(FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long,
int, ThreadPool::TPHandle*)+0xf15) [0x7f8b871ee1a5]
2017-06-28T04:33:13.859 INFO:tasks.ceph.osd.3.smithi021.stderr: 3:
(FileStore::_do_transactions(std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&, unsigned long,
ThreadPool::TPHandle*)+0x3b) [0x7f8b871f3ecb]
2017-06-28T04:33:13.862 INFO:tasks.ceph.osd.3.smithi021.stderr: 4:
(FileStore::_do_op(FileStore::OpSequencer*,
ThreadPool::TPHandle&)+0x2cd) [0x7f8b871f41cd]
2017-06-28T04:33:13.865 INFO:tasks.ceph.osd.3.smithi021.stderr: 5:
(ThreadPool::worker(ThreadPool::WorkThread*)+0xa7e) [0x7f8b87508b0e]
2017-06-28T04:33:13.868 INFO:tasks.ceph.osd.3.smithi021.stderr: 6:
(ThreadPool::WorkThread::entry()+0x10) [0x7f8b875099f0]
2017-06-28T04:33:13.871 INFO:tasks.ceph.osd.3.smithi021.stderr: 7:
(()+0x7dc5) [0x7f8b85222dc5]
2017-06-28T04:33:13.875 INFO:tasks.ceph.osd.3.smithi021.stderr: 8:
(clone()+0x6d) [0x7f8b838ad73d]
2017-06-28T04:33:13.878 INFO:tasks.ceph.osd.3.smithi021.stderr: NOTE:
a copy of the executable, or `objdump -rdS <executable>` is needed to
interpret this.
2017-06-28T04:33:13.881
INFO:tasks.ceph.osd.3.smithi021.stderr:2017-06-28 04:33:13.823002
7f8b79a48700 -1 os/filestore/FileStore.cc: In function 'void
FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int,
ThreadPool::TPHandle*)' thread 7f8b79a48700 time 2017-06-28
04:33:13.821210
2017-06-28T04:33:13.884
INFO:tasks.ceph.osd.3.smithi021.stderr:os/filestore/FileStore.cc:
2920: FAILED assert(0 == "unexpected error")
2017-06-28T04:33:13.889 INFO:tasks.ceph.osd.3.smithi021.stderr:
2017-06-28T04:33:13.892 INFO:tasks.ceph.osd.3.smithi021.stderr: ceph
version 10.2.7-428-gca7ab74 (ca7ab74ae7884f24983d94b729cc262108ff6aba)
2017-06-28T04:33:13.896 INFO:tasks.ceph.osd.3.smithi021.stderr: 1:
(ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f8b87517ac5]
2017-06-28T04:33:13.899 INFO:tasks.ceph.osd.3.smithi021.stderr: 2:
(FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long,
int, ThreadPool::TPHandle*)+0xf15) [0x7f8b871ee1a5]
2017-06-28T04:33:13.902 INFO:tasks.ceph.osd.3.smithi021.stderr: 3:
(FileStore::_do_transactions(std::vector<ObjectStore::Transaction,
std::allocator<ObjectStore::Transaction> >&, unsigned long,
ThreadPool::TPHandle*)+0x3b) [0x7f8b871f3ecb]
2017-06-28T04:33:13.905 INFO:tasks.ceph.osd.3.smithi021.stderr: 4:
(FileStore::_do_op(FileStore::OpSequencer*,
ThreadPool::TPHandle&)+0x2cd) [0x7f8b871f41cd]
2017-06-28T04:33:13.908 INFO:tasks.ceph.osd.3.smithi021.stderr: 5:
(ThreadPool::worker(ThreadPool::WorkThread*)+0xa7e) [0x7f8b87508b0e]
2017-06-28T04:33:13.912 INFO:tasks.ceph.osd.3.smithi021.stderr: 6:
(ThreadPool::WorkThread::entry()+0x10) [0x7f8b875099f0]
2017-06-28T04:33:13.915 INFO:tasks.ceph.osd.3.smithi021.stderr: 7:
(()+0x7dc5) [0x7f8b85222dc5]
2017-06-28T04:33:13.918 INFO:tasks.ceph.osd.3.smithi021.stderr: 8:
(clone()+0x6d) [0x7f8b838ad73d]
2017-06-28T04:33:13.923 INFO:tasks.ceph.osd.3.smithi021.stderr: NOTE:
a copy of the executable, or `objdump -rdS <executable>` is needed to
interpret this.

On Wed, Jun 28, 2017 at 8:48 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Could we also include:
>>
>> https://github.com/ceph/ceph/pull/14392
>> https://github.com/ceph/ceph/pull/15529
>
>
> Hi Josh:
>
> All the outstanding PRs earmarked for 10.2.8 (including the two you
> mentioned) have been merged. I ran two final suites:
>
> rados
> http://pulpito.front.sepia.ceph.com:80/smithfarm-2017-06-27_19:13:42-rados-wip-jewel-backports-distro-basic-smithi/
> upgrade/hammer-x
> http://pulpito.front.sepia.ceph.com:80/smithfarm-2017-06-27_15:24:41-upgrade:hammer-x-wip-jewel-backports-distro-basic-vps/
>
> Both are looking pretty good, but these runs did identify two issues that
> might be significant:
>
> * the upgrade suite has what appears to be a regression:
> http://tracker.ceph.com/issues/13381
> * the rados suite has this bug (possibly RGW-related) that I haven't seen
> before: http://tracker.ceph.com/issues/20449
>
> The rados suite also had six "infrastructure noise" failures which might be
> hiding real bugs. I reran these, but Sepia is down ATM.
>
> Do you think 10.2.8 is ready for QE to start its testing?
>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
