From: =?UTF-8?Q?Marcin_Gibu=c5=82a?= <m.gibula@beyond.pl>
Subject: OSD memory usage during startup - advice needed
Date: Thu, 19 Nov 2015 19:16:13 +0100
Message-ID: <564E11ED.7080001@beyond.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ip-92-43-119-196.beyond.pl ([92.43.119.196]:53032 "EHLO
	mx.beyond.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756659AbbKSSZF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Nov 2015 13:25:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.beyond.pl (Postfix) with ESMTP id 7CC51BEF
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 19:16:22 +0100 (CET)
Received: from mx.beyond.pl ([127.0.0.1])
	by localhost (mw.beyond.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0B-RvV9zSM4 for <ceph-devel@vger.kernel.org>;
	Thu, 19 Nov 2015 19:16:22 +0100 (CET)
Received: from [192.168.1.120] (src75-20.unii.maverick.com.pl [194.187.75.20])
	(Authenticated sender: m.gibula@beyond.pl)
	by mx.beyond.pl (Postfix) with ESMTPSA id 322CE615
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 19:16:22 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph devs!

I'm trying to track down and fix huge memory usage when OSD is starting 
after unclean shutdown. Recently, after editing crush map, when 
backfills started, one of our OSDs died (it hit suicide timeout). It was 
also refusing to start again, crashing due to memory allocation failure 
(over 15G used) shortly after start.

Judging from debug output, the problem is in journal recovery, when it 
tries to delete object with huge (several milion keys - it is radosgw 
index* for bucket with over 50mln objects) amount of keys, using 
leveldb's rmkeys_by_prefix() method.

Looking at the source code, rmkeys_by_prefix() batches all operations 
into one list and then submit_transaction() executes them all atomically.

I'd love to write a patch for this issue, but it seems unfixable (or is 
it?) with current API and method behaviour. Could you offer any advice 
on how to proceed?

Backtrace below:

  1: /usr/bin/ceph-osd() [0xacd7ba]
  2: (()+0x10340) [0x7f9713500340]
  3: (gsignal()+0x39) [0x7f971199fcc9]
  4: (abort()+0x148) [0x7f97119a30d8]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f97122aa535]
  6: (()+0x5e6d6) [0x7f97122a86d6]
  7: (()+0x5e703) [0x7f97122a8703]
  8: (()+0x5e922) [0x7f97122a8922]
  9: (()+0x12b1e) [0x7f9713720b1e]
  10: (tc_new()+0x1e0) [0x7f9713740a00]
  11: (std::string::_Rep::_S_create(unsigned long, unsigned long, 
std::allocator<char> const&)+0x59) [0x7f9712304209]
  12: (std::string::_Rep::_M_clone(std::allocator<char> const&, unsigned 
long)+0x1b) [0x7f9712304dcb]
  13: (std::string::reserve(unsigned long)+0x34) [0x7f9712304e64]
  14: (std::string::append(char const*, unsigned long)+0x4f) 
[0x7f97123050af]
  15: 
(LevelDBStore::LevelDBTransactionImpl::rmkeys_by_prefix(std::string 
const&)+0xcf) [0x97c44f]
  16: 
(DBObjectMap::clear_header(std::tr1::shared_ptr<DBObjectMap::_Header>, 
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0xc1) [0xa63171]
  17: (DBObjectMap::_clear(std::tr1::shared_ptr<DBObjectMap::_Header>, 
std::tr1::shared_ptr<KeyValueDB::TransactionImpl>)+0x91) [0xa682b1]
  18: (DBObjectMap::clear(ghobject_t const&, SequencerPosition 
const*)+0x202) [0xa6b292]
  19: (FileStore::lfn_unlink(coll_t, ghobject_t const&, 
SequencerPosition const&, bool)+0x16b) [0x9154fb]
  20: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition 
const&)+0x8b) [0x915f6b]
  21: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned 
long, int, ThreadPool::TPHandle*)+0x3174) [0x926434]
  22: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*, 
std::allocator<ObjectStore::Transaction*> >&, unsigned long, 
ThreadPool::TPHandle*)+0x64) [0x92a3a4]
  23: (JournalingObjectStore::journal_replay(unsigned long)+0x5cb) 
[0x94355b]
  24: (FileStore::mount()+0x3bb6) [0x9139f6]
  25: (OSD::init()+0x259) [0x6c59b9]
  26: (main()+0x2860) [0x6527e0]
  27: (__libc_start_main()+0xf5) [0x7f971198aec5]
  28: /usr/bin/ceph-osd() [0x66b887]


I also suspect that deleting this object was also somehow responsible 
for initial crash, when OSD hit suicide timeout. Any advices on how to 
debug it further?


* - yes, I am aware of shared indexes, but that bucket was created 
pre-hammer and I can't move migrate it

-- 
mg

P.S. Please CC me, as I'm not subscribed.
