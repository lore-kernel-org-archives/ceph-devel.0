From: Robert LeBlanc <robert@leblancnet.us>
Subject: Request for Comments: Weighted Round Robin OP Queue
Date: Wed, 4 Nov 2015 09:54:59 -0700
Message-ID: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33008 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030715AbbKDQzA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 11:55:00 -0500
Received: by ykft191 with SMTP id t191so82479229ykf.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2015 08:54:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've got some rough code that changes out the token bucket queue in
PrioritizedQueue.h with a weighted round robin queue located at [1].
Even though there is some more optimizations that can be done, running
the fio job [2], I've seen about a ~20% performance increase on
spindles and ~6% performance increase on SSDs (my hosts are CPU bound
on SSD).

The idea of this queue is to try to be fair to all OPs relative to
their priority while at the same time reducing the overhead for each
OP (queue and dequeue) from O(n) to closer to O(1).

One issue that I'm having is that under certain workloads and usually
during recovery I get these asserts and need help pinpointing how to
resolve it.

 osd/PG.cc: In function 'void PG::add_log_entry(const pg_log_entry_t&,
ceph::bufferlist&)' thread 7f55d61fd700 time 2015-11-03
14:44:28.638112
osd/PG.cc: 2923: FAILED assert(e.version > info.last_update)
osd/PG.cc: In function 'void PG::add_log_entry(const pg_log_entry_t&,
ceph::bufferlist&)' thread 7f55d7a00700 time 2015-11-03
14:44:28.637053
osd/PG.cc: 2923: FAILED assert(e.version > info.last_update)
 ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x76) [0xc1e3a6]
 2: ceph-osd() [0x7d5a7c]
 3: (PG::append_log(std::vector > const&, eversion_t, eversion_t,
ObjectStore::Transaction&, bool)+0x111) [0x7f7181]
 4: (ReplicatedPG::log_operation(std::vector > const&,
boost::optional&, eversion_t const&, eversion_t const&, bool,
ObjectStore::Transaction*)+0xad) [0x8bfc7d]
 5: (void ReplicatedBackend::sub_op_modify_impl(std::tr1::shared_ptr)+0x7b9)
[0xa5e119]
 6: (ReplicatedBackend::sub_op_modify(std::tr1::shared_ptr)+0x4a) [0xa4950a]
 7: (ReplicatedBackend::handle_message(std::tr1::shared_ptr)+0x363) [0xa49923]
 8: (ReplicatedPG::do_request(std::tr1::shared_ptr&,
ThreadPool::TPHandle&)+0x159) [0x847ae9]
 9: (OSD::dequeue_op(boost::intrusive_ptr, std::tr1::shared_ptr,
ThreadPool::TPHandle&)+0x3cf) [0x690cef]
 10: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x469) [0x691359]
 11: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x89e)
[0xc0d8ae]
 12: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xc0fa00]
 13: (()+0x80a4) [0x7f55f9edd0a4]
 14: (clone()+0x6d) [0x7f55f843904d]
 NOTE: a copy of the executable, or `objdump -rdS ` is needed to interpret this.

I think this means that the PG log to be appended is newer than what
is expected, but I'm not sure how to rectify it. Any pushes in the
right direction would be helpful.

It seems that this queue is helping with recover ops even when
osd_max_backfills=20 with max client ops, but I don't have good long
term data due to this issue. I think this has also impacted my SSD
testing as I lose one OSD during the test, reducing the performance
temporarily.

When looking through my code, please remember.
1. This may be the first time I wrote C++ code, or it has been long
enough it seems like it.
2. There is still some optimizations that I know can be done. But I'm
happy to have people share any optimization opportunities they see.
3. I'm trying to understand the reason for the assert and pointers how
to resolve it.
4. It seems like there are multiple threads of the queue keeping the
queues pretty small. How can I limit the queue to one thread so all
OPs have to be queued in one queue? I'd like to see the differences
with changing this.
5. I'd like any pointers to improving this code.

Thank you,
Robert LeBlanc

[1] https://github.com/ceph/ceph/compare/hammer...rldleblanc:wrr-queue
[2] [rbd-test]
#readwrite=write
#blocksize=4M
runtime=600
name=rbd-test
readwrite=randrw
bssplit=4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
rwmixread=72
norandommap
#size=1T
#blocksize=4k
ioengine=rbd
rbdname=test5
pool=ssd-pool
clientname=admin
iodepth=8
numjobs=4
thread
group_reporting
time_based
#direct=1
ramp_time=60

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWOjheCRDmVDuy+mK58QAAfxkQAJjgP4cjtHiFdtZgR2Zo
yMPeV1b+ZYoQr4XbyCqWAsRdgigdcesCnjxyTOWnK+nHZgxMOgtHn8rylltV
17NzleGKfQUDRe7jLHLOaLDMphODvW0BjJHV8uk5DzYVJhVOhT5oHtJTtRXY
JtMCIaGcwEPSP9IE+bkzX22fPEeNnkCHFAosmratD2WIeaNrOfV0DNOfAotO
FX2/w0NtiuNqr+KEH3MrPdHkENXLhG2A8wiLqJ7sN0LvclwGbO9eZ01sv5nV
bqqS8dQjd4oh31799vBroX73uMOb+ljeXNguz/4l4Tekn+F3m5puFHEX2o23
NroU1YHNcKFAOwppZ7pDrAn3ATzvOEsZ7574dJw5vPxquCgsF0T8/phsk71D
E1IOQC/EIqCw4wUnujwlEZXwlSXRLyqT5xUrSXo/qtM4HUz4PmWukxZxOmk/
Afewcbq/5ElSZQus1xmMdmtGocSGAvMmYthIbXP+3l2127bMK2ptacL6VMSf
uO+wYCLQZDnpjlx9DYt4CAEbEeuS4vCSzIkGishcuFNHGmM/gXXqYFybAATt
IbLRWZBrq4TyfJe9sIp6aNPbi/IHxSV4NVVX3q1P2j91UDKKVL6hu9Ln0HTY
UrFuDnH0yjvwBm4vJ0ksoWLIWTciLTTz68ZyOnOnr+uXGbkQEz1LzMQWZ+Cl
saYj
=R1Lm
-----END PGP SIGNATURE-----
