From: =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0JQu?= <ineu.main@gmail.com>
Subject: Ceph OSD dies trying to replay journal
Date: Sun, 6 Sep 2015 13:27:30 +0300
Message-ID: <CADX_dn5TgvDdF34Ke2qyGdd4utLiMeQOhWCpMfTO5jt=+Bj7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38705 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbIFK1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Sep 2015 06:27:31 -0400
Received: by igbut12 with SMTP id ut12so41106177igb.1
        for <ceph-devel@vger.kernel.org>; Sun, 06 Sep 2015 03:27:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a small cluster of 3 machines/9 OSDs, one OSD per 4TB HDD.
Running Ceph 0.94.2 on CentOS 7. Just upgraded to 0.94.3 on one
machine, didn't help the problem.

My problem is: sometimes OSDs start consuming huge amount of memory
and dies afterwards. `/etc/init.d/ceph start osd.X` starts the OSD
process, but soon it dies again. OSD tries to allocate all available
memory and is sometimes being killed by OOM killer, and sometimes dies
when there is no more memory to allocate. In my case machines have
16GB memory each, normally OSD uses up to 1GB, but faulty OSD's usage
grows to 12-13GB.

I've tried to run `--flush-journal`, didn't work either. Here's the output:

[root@assets-3 ceph]# ceph-osd -i 6 --flush-journal
SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0d 00 00 00
00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
tcmalloc: large alloc 1073741824 bytes == 0x671c8000 @  0x7f220f6b2e6a
0x7f220f6d2d64 0x7f220e2a7c29 0x7f220e2a886b 0x7f220e2a8914
0x7f220e2a8b7f 0x968ddf 0xa57ad3 0xa5ced1 0xa5ff82 0x90255a 0x90302e
0x9127cc 0x915d04 0x92df5b 0x900530 0x6425a9 0x7f220d932af5 0x65d139
(nil)
tcmalloc: large alloc 2147483648 bytes == 0xbfb00000 @  0x7f220f6b2e6a
0x7f220f6d2d64 0x7f220e2a7c29 0x7f220e2a886b 0x7f220e2a8914
0x7f220e2a8b7f 0x968ddf 0xa57ad3 0xa5ced1 0xa5ff82 0x90255a 0x90302e
0x9127cc 0x915d04 0x92df5b 0x900530 0x6425a9 0x7f220d932af5 0x65d139
(nil)
tcmalloc: large alloc 4294967296 bytes == 0x16e068000 @
0x7f220f6b2e6a 0x7f220f6d2d64 0x7f220e2a7c29 0x7f220e2a886b
0x7f220e2a8914 0x7f220e2a8b7f 0x968ddf 0xa57ad3 0xa5ced1 0xa5ff82
0x90255a 0x90302e 0x9127cc 0x915d04 0x92df5b 0x900530 0x6425a9
0x7f220d932af5 0x65d139 (nil)
tcmalloc: large alloc 8589934592 bytes == (nil) @  0x7f220f6b2e6a
0x7f220f6d2d64 0x7f220e2a7c29 0x7f220e2a886b 0x7f220e2a8914
0x7f220e2a8b7f 0x968ddf 0xa57ad3 0xa5ced1 0xa5ff82 0x90255a 0x90302e
0x9127cc 0x915d04 0x92df5b 0x900530 0x6425a9 0x7f220d932af5 0x65d139
(nil)
terminate called after throwing an instance of 'std::bad_alloc'
  what():  std::bad_alloc
*** Caught signal (Aborted) **
 in thread 7f2210598880
 ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
 1: ceph-osd() [0xac5c32]
 2: (()+0xf130) [0x7f220ef2c130]
 3: (gsignal()+0x37) [0x7f220d9465d7]
 4: (abort()+0x148) [0x7f220d947cc8]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f220e24a9b5]
 6: (()+0x5e926) [0x7f220e248926]
 7: (()+0x5e953) [0x7f220e248953]
 8: (()+0x5eb73) [0x7f220e248b73]
 9: (()+0x15d3e) [0x7f220f6b2d3e]
 10: (tc_new()+0x1e0) [0x7f220f6d2de0]
 11: (std::string::_Rep::_S_create(unsigned long, unsigned long,
std::allocator<char> const&)+0x59) [0x7f220e2a7c29]
 12: (std::string::_Rep::_M_clone(std::allocator<char> const&,
unsigned long)+0x1b) [0x7f220e2a886b]
 13: (std::string::reserve(unsigned long)+0x44) [0x7f220e2a8914]
 14: (std::string::append(char const*, unsigned long)+0x4f) [0x7f220e2a8b7f]
 15: (LevelDBStore::LevelDBTransactionImpl::rmkeys_by_prefix(std::string
const&)+0xdf) [0x968ddf]
 16: (DBObjectMap::clear_header(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xd3) [0xa57ad3]
 17: (DBObjectMap::_clear(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xa1) [0xa5ced1]
 18: (DBObjectMap::clear(ghobject_t const&, SequencerPosition
const*)+0x202) [0xa5ff82]
 19: (FileStore::lfn_unlink(coll_t, ghobject_t const&,
SequencerPosition const&, bool)+0x16a) [0x90255a]
 20: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition
const&)+0x9e) [0x90302e]
 21: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
long, int, ThreadPool::TPHandle*)+0x252c) [0x9127cc]
 22: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long,
ThreadPool::TPHandle*)+0x64) [0x915d04]
 23: (JournalingObjectStore::journal_replay(unsigned long)+0x5db) [0x92df5b]
 24: (FileStore::mount()+0x3730) [0x900530]
 25: (main()+0xec9) [0x6425a9]
 26: (__libc_start_main()+0xf5) [0x7f220d932af5]
 27: ceph-osd() [0x65d139]
2015-09-06 09:53:20.349046 7f2210598880 -1 *** Caught signal (Aborted) **
 in thread 7f2210598880

 ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
 1: ceph-osd() [0xac5c32]
 2: (()+0xf130) [0x7f220ef2c130]
 3: (gsignal()+0x37) [0x7f220d9465d7]
 4: (abort()+0x148) [0x7f220d947cc8]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f220e24a9b5]
 6: (()+0x5e926) [0x7f220e248926]
 7: (()+0x5e953) [0x7f220e248953]
 8: (()+0x5eb73) [0x7f220e248b73]
 9: (()+0x15d3e) [0x7f220f6b2d3e]
 10: (tc_new()+0x1e0) [0x7f220f6d2de0]
 11: (std::string::_Rep::_S_create(unsigned long, unsigned long,
std::allocator<char> const&)+0x59) [0x7f220e2a7c29]
 12: (std::string::_Rep::_M_clone(std::allocator<char> const&,
unsigned long)+0x1b) [0x7f220e2a886b]
 13: (std::string::reserve(unsigned long)+0x44) [0x7f220e2a8914]
 14: (std::string::append(char const*, unsigned long)+0x4f) [0x7f220e2a8b7f]
 15: (LevelDBStore::LevelDBTransactionImpl::rmkeys_by_prefix(std::string
const&)+0xdf) [0x968ddf]
 16: (DBObjectMap::clear_header(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xd3) [0xa57ad3]
 17: (DBObjectMap::_clear(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xa1) [0xa5ced1]
 18: (DBObjectMap::clear(ghobject_t const&, SequencerPosition
const*)+0x202) [0xa5ff82]
 19: (FileStore::lfn_unlink(coll_t, ghobject_t const&,
SequencerPosition const&, bool)+0x16a) [0x90255a]
 20: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition
const&)+0x9e) [0x90302e]
 21: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
long, int, ThreadPool::TPHandle*)+0x252c) [0x9127cc]
 22: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long,
ThreadPool::TPHandle*)+0x64) [0x915d04]
 23: (JournalingObjectStore::journal_replay(unsigned long)+0x5db) [0x92df5b]
 24: (FileStore::mount()+0x3730) [0x900530]
 25: (main()+0xec9) [0x6425a9]
 26: (__libc_start_main()+0xf5) [0x7f220d932af5]
 27: ceph-osd() [0x65d139]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

     0> 2015-09-06 09:53:20.349046 7f2210598880 -1 *** Caught signal
(Aborted) **
 in thread 7f2210598880

 ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
 1: ceph-osd() [0xac5c32]
 2: (()+0xf130) [0x7f220ef2c130]
 3: (gsignal()+0x37) [0x7f220d9465d7]
 4: (abort()+0x148) [0x7f220d947cc8]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f220e24a9b5]
 6: (()+0x5e926) [0x7f220e248926]
 7: (()+0x5e953) [0x7f220e248953]
 8: (()+0x5eb73) [0x7f220e248b73]
 9: (()+0x15d3e) [0x7f220f6b2d3e]
 10: (tc_new()+0x1e0) [0x7f220f6d2de0]
 11: (std::string::_Rep::_S_create(unsigned long, unsigned long,
std::allocator<char> const&)+0x59) [0x7f220e2a7c29]
 12: (std::string::_Rep::_M_clone(std::allocator<char> const&,
unsigned long)+0x1b) [0x7f220e2a886b]
 13: (std::string::reserve(unsigned long)+0x44) [0x7f220e2a8914]
 14: (std::string::append(char const*, unsigned long)+0x4f) [0x7f220e2a8b7f]
 15: (LevelDBStore::LevelDBTransactionImpl::rmkeys_by_prefix(std::string
const&)+0xdf) [0x968ddf]
 16: (DBObjectMap::clear_header(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xd3) [0xa57ad3]
 17: (DBObjectMap::_clear(std::tr1::shared_ptr<DBObjectMap::_Header>,
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xa1) [0xa5ced1]
 18: (DBObjectMap::clear(ghobject_t const&, SequencerPosition
const*)+0x202) [0xa5ff82]
 19: (FileStore::lfn_unlink(coll_t, ghobject_t const&,
SequencerPosition const&, bool)+0x16a) [0x90255a]
 20: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition
const&)+0x9e) [0x90302e]
 21: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
long, int, ThreadPool::TPHandle*)+0x252c) [0x9127cc]
 22: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*,
std::allocator<ObjectStore::Transaction*> >&, unsigned long,
ThreadPool::TPHandle*)+0x64) [0x915d04]
 23: (JournalingObjectStore::journal_replay(unsigned long)+0x5db) [0x92df5b]
 24: (FileStore::mount()+0x3730) [0x900530]
 25: (main()+0xec9) [0x6425a9]
 26: (__libc_start_main()+0xf5) [0x7f220d932af5]
 27: ceph-osd() [0x65d139]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Aborted




The only way to start faulty OSD is to recreate journal from scratch,
losing all journal's contents.
My Ceph config is very simple:

[global]
fsid = 0af99d4f-2677-4889-9985-456e28e91265
mon_initial_members = assets-1
mon_host = 192.168.0.51
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx
filestore_xattr_use_omap = true
public_network = 192.168.0.0/24

[client.admin]
keyring = /etc/ceph/ceph.client.admin.keyring

[client.radosgw.gateway]
host = assets-1
keyring = /etc/ceph/ceph.client.radosgw.keyring
rgw_socket_path = /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock
log_file = /var/log/radosgw/client.radosgw.gateway.log
rgw_print_continue = false

[osd]
osd_max_backfills = 1
osd_recovery_max_active = 1

[osd.0]
osd_journal = /dev/sda4

[osd.1]
osd_journal = /dev/sda5

[osd.2]
osd_journal = /dev/sda6

[osd.3]
osd_journal = /dev/sda4

[osd.4]
osd_journal = /dev/sda5

[osd.5]
osd_journal = /dev/sda6

[osd.6]
osd_journal = /dev/sda4

[osd.7]
osd_journal = /dev/sda5

[osd.8]
osd_journal = /dev/sda6



I haven't looked at the cluster for a week, and after the week only 4
of 9 OSDs survived, all other are dead now.
There's one MON per host (3 in total), no MDS, no block devices. Ceph
is used only with RGW.

Thank you.
