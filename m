From: Ian Pye <ianpye@gmail.com>
Subject: Re: OSD crash, ceph version 0.56.1
Date: Wed, 9 Jan 2013 18:23:02 -0800
Message-ID: <CAEVWPAWNfhM_NUd0-9v3oqb+ZUVpi2bC30Vq4S93DPisX9KaWw@mail.gmail.com>
References: <CAEVWPAW+DmYW1dvTaOkjK7UZwzP2hZsjBC6kC1gV9fwyb3QJPQ@mail.gmail.com>
	<alpine.DEB.2.00.1301091637220.8832@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61522 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961Ab3AJCXE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 21:23:04 -0500
Received: by mail-lb0-f179.google.com with SMTP id gm13so112383lbb.38
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 18:23:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301091637220.8832@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 9, 2013 at 4:38 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 9 Jan 2013, Ian Pye wrote:
>> Hi,
>>
>> Every time I try an bring up an OSD, it crashes and I get the
>> following: "error (121) Remote I/O error not handled on operation 20"
>
> This error code (EREMOTEIO) is not used by Ceph.  What fs are you using?
> Which kernel version?  Anything else unusual happen with your hardware
> recently that might have wreaked havoc on your underlying fs?

3.7.1 kernel with XFS. Its a demo-box from a vendor, so should be brand new.

I'm going to say its a disk error, given the following:

mkfs.xfs: read failed: Input/output error

Interestingly, running an osd and btrfs worked fine on the same disk.

Thanks for the help,

Ian

>
> sage
>
>
>
>> The cluster is new and only has a little bit of data on it. Any ideas
>> what is going on? Does Remote I/O mean a network error? Full log
>> below:
>>
>>    -9> 2013-01-10 00:00:20.182237 7f2ddde8f910  0
>> filestore(/mnt/dist_j/ceph)  error (121) Remote I/O error not handled
>> on operation 20 (12.0.0, or op 0, counting from 0)
>>     -8> 2013-01-10 00:00:20.182275 7f2ddde8f910  0
>> filestore(/mnt/dist_j/ceph) unexpected error code
>>     -7> 2013-01-10 00:00:20.182285 7f2ddde8f910  0
>> filestore(/mnt/dist_j/ceph)  transaction dump:
>> { "ops": [
>>         { "op_num": 0,
>>           "op_name": "mkcoll",
>>           "collection": "0.2c0_head"},
>>         { "op_num": 1,
>>           "op_name": "collection_setattr",
>>           "collection": "0.2c0_head",
>>           "name": "info",
>>           "length": 5},
>>         { "op_num": 2,
>>           "op_name": "truncate",
>>           "collection": "meta",
>>           "oid": "a04c46e9\/pginfo_0.2c0\/0\/\/-1",
>>           "offset": 0},
>>         { "op_num": 3,
>>           "op_name": "write",
>>           "collection": "meta",
>>           "oid": "a04c46e9\/pginfo_0.2c0\/0\/\/-1",
>>           "length": 531,
>>           "offset": 0,
>>           "bufferlist length": 531},
>>         { "op_num": 4,
>>           "op_name": "remove",
>>           "collection": "meta",
>>           "oid": "1f9ede85\/pglog_0.2c0\/0\/\/-1"},
>>         { "op_num": 5,
>>           "op_name": "write",
>>           "collection": "meta",
>>           "oid": "1f9ede85\/pglog_0.2c0\/0\/\/-1",
>>           "length": 0,
>>           "offset": 0,
>>           "bufferlist length": 0},
>>         { "op_num": 6,
>>           "op_name": "collection_setattr",
>>           "collection": "0.2c0_head",
>>           "name": "ondisklog",
>>           "length": 34},
>>         { "op_num": 7,
>>           "op_name": "nop"}]}
>>     -6> 2013-01-10 00:00:20.183085 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -5> 2013-01-10 00:00:20.183108 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5b15600 con 0x34629a0
>>     -4> 2013-01-10 00:00:20.183772 7f2dd6680910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -3> 2013-01-10 00:00:20.183797 7f2dd6680910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5f75600 con 0x34629a0
>>     -2> 2013-01-10 00:00:20.184315 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -1> 2013-01-10 00:00:20.184338 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5b15400 con 0x34629a0
>>      0> 2013-01-10 00:00:20.184755 7f2ddde8f910 -1 os/FileStore.cc: In
>> function 'unsigned int
>> FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int)'
>> thread 7f2ddde8f910 time 2013-01-10 00:00:20.182422
>> os/FileStore.cc: 2681: FAILED assert(0 == "unexpected error")
>>
>>  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>>  1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>> long, int)+0x90a) [0x73e14a]
>>  2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>> [0x7455dc]
>>  3: (FileStore::_do_op(FileStore::OpSequencer*)+0xab) [0x72428b]
>>  4: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x894feb]
>>  5: (ThreadPool::WorkThread::entry()+0x10) [0x8977d0]
>>  6: /lib/libpthread.so.0 [0x7f2de6d087aa]
>>  7: (clone()+0x6d) [0x7f2de518159d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- logging levels ---
>>    0/ 5 none
>>    0/ 1 lockdep
>>    0/ 1 context
>>    1/ 1 crush
>>    1/ 5 mds
>>    1/ 5 mds_balancer
>>    1/ 5 mds_locker
>>    1/ 5 mds_log
>>    1/ 5 mds_log_expire
>>    1/ 5 mds_migrator
>>    0/ 1 buffer
>>    0/ 1 timer
>>    0/ 1 filer
>>    0/ 1 striper
>>    0/ 1 objecter
>>    0/ 5 rados
>>    0/ 5 rbd
>>    0/ 5 journaler
>>    0/ 5 objectcacher
>>    0/ 5 client
>>    0/ 5 osd
>>    0/ 5 optracker
>>    0/ 5 objclass
>>    1/ 3 filestore
>>    1/ 3 journal
>>    0/ 5 ms
>>    1/ 5 mon
>>    0/10 monc
>>    0/ 5 paxos
>>    0/ 5 tp
>>    1/ 5 auth
>>    1/ 5 crypto
>>    1/ 1 finisher
>>    1/ 5 heartbeatmap
>>    1/ 5 perfcounter
>>    1/ 5 rgw
>>    1/ 5 hadoop
>>    1/ 5 javaclient
>>    1/ 5 asok
>>    1/ 1 throttle
>>   -2/-2 (syslog threshold)
>>   -1/-1 (stderr threshold)
>>   max_recent    100000
>>   max_new         1000
>>   log_file /var/log/ceph/ceph-osd.9.log
>> --- end dump of recent events ---
>> 2013-01-10 00:00:20.227763 7f2ddde8f910 -1 *** Caught signal (Aborted) **
>>  in thread 7f2ddde8f910
>>
>>  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>>  1: /cf/ceph/bin/ceph-osd [0x7a5309]
>>  2: /lib/libpthread.so.0 [0x7f2de6d10a60]
>>  3: (gsignal()+0x35) [0x7f2de50e7f05]
>>  4: (abort()+0x180) [0x7f2de50ead10]
>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f2de596ed45]
>>  6: /usr/lib/libstdc++.so.6 [0x7f2de596d176]
>>  7: /usr/lib/libstdc++.so.6 [0x7f2de596d1a3]
>>  8: /usr/lib/libstdc++.so.6 [0x7f2de596d29e]
>>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x7c9) [0x898029]
>>  10: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>> long, int)+0x90a) [0x73e14a]
>>  11: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>> [0x7455dc]
>>  12: (FileStore::_do_op(FileStore::OpSequencer*)+0xab) [0x72428b]
>>  13: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x894feb]
>>  14: (ThreadPool::WorkThread::entry()+0x10) [0x8977d0]
>>  15: /lib/libpthread.so.0 [0x7f2de6d087aa]
>>  16: (clone()+0x6d) [0x7f2de518159d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- begin dump of recent events ---
>>    -17> 2013-01-10 00:00:20.184913 7f2dd6680910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>    -16> 2013-01-10 00:00:20.184936 7f2dd6680910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5f75400 con 0x34629a0
>>    -15> 2013-01-10 00:00:20.185444 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>    -14> 2013-01-10 00:00:20.185461 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5b15200 con 0x34629a0
>>    -13> 2013-01-10 00:00:20.186028 7f2dd6680910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>    -12> 2013-01-10 00:00:20.186049 7f2dd6680910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5f75200 con 0x34629a0
>>    -11> 2013-01-10 00:00:20.186585 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>    -10> 2013-01-10 00:00:20.186596 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5b15000 con 0x34629a0
>>     -9> 2013-01-10 00:00:20.186956 7f2dd6680910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -8> 2013-01-10 00:00:20.186973 7f2dd6680910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x5f75000 con 0x34629a0
>>     -7> 2013-01-10 00:00:20.187288 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -6> 2013-01-10 00:00:20.187298 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x387ce00 con 0x34629a0
>>     -5> 2013-01-10 00:00:20.187671 7f2dd6680910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -4> 2013-01-10 00:00:20.187688 7f2dd6680910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x393ae00 con 0x34629a0
>>     -3> 2013-01-10 00:00:20.187946 7f2dd5e7f910 10 monclient:
>> _send_mon_message to mon.a at 108.162.209.120:6789/0
>>     -2> 2013-01-10 00:00:20.187957 7f2dd5e7f910  1 --
>> 108.162.209.120:6834/6359 --> 108.162.209.120:6789/0 -- osd_pgtemp(e22
>> {0.110=[8,9],0.147=[3,9],0.155=[1,9],0.171=[0,9],0.194=[3,9],0.1ad=[10,9],0.1c2=[1,9],0.1cb=[7,9],0.1df=[6,9],0.1e8=[7,9],0.1e9=[11,9],0.1f1=[7,9]}
>> v22) v1 -- ?+0 0x387cc00 con 0x34629a0
>>     -1> 2013-01-10 00:00:20.200448 7f2dcfb4d910  1 --
>> 108.162.209.120:6836/6359 >> :/0 pipe(0x38616c0 sd=49 :6836 pgs=0 cs=0
>> l=0).accept sd=49 108.162.209.120:13844/0
>>      0> 2013-01-10 00:00:20.227763 7f2ddde8f910 -1 *** Caught signal
>> (Aborted) **
>>  in thread 7f2ddde8f910
>>
>>  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>>  1: /cf/ceph/bin/ceph-osd [0x7a5309]
>>  2: /lib/libpthread.so.0 [0x7f2de6d10a60]
>>  3: (gsignal()+0x35) [0x7f2de50e7f05]
>>  4: (abort()+0x180) [0x7f2de50ead10]
>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f2de596ed45]
>>  6: /usr/lib/libstdc++.so.6 [0x7f2de596d176]
>>  7: /usr/lib/libstdc++.so.6 [0x7f2de596d1a3]
>>  8: /usr/lib/libstdc++.so.6 [0x7f2de596d29e]
>>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x7c9) [0x898029]
>>  10: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>> long, int)+0x90a) [0x73e14a]
>>  11: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>> [0x7455dc]
>>  12: (FileStore::_do_op(FileStore::OpSequencer*)+0xab) [0x72428b]
>>  13: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x894feb]
>>  14: (ThreadPool::WorkThread::entry()+0x10) [0x8977d0]
>>  15: /lib/libpthread.so.0 [0x7f2de6d087aa]
>>  16: (clone()+0x6d) [0x7f2de518159d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- logging levels ---
>>    0/ 5 none
>>    0/ 1 lockdep
>>    0/ 1 context
>>    1/ 1 crush
>>    1/ 5 mds
>>    1/ 5 mds_balancer
>>    1/ 5 mds_locker
>>    1/ 5 mds_log
>>    1/ 5 mds_log_expire
>>    1/ 5 mds_migrator
>>    0/ 1 buffer
>>    0/ 1 timer
>>    0/ 1 filer
>>    0/ 1 striper
>>    0/ 1 objecter
>>    0/ 5 rados
>>    0/ 5 rbd
>>    0/ 5 journaler
>>    0/ 5 objectcacher
>>    0/ 5 client
>>    0/ 5 osd
>>    0/ 5 optracker
>>    0/ 5 objclass
>>    1/ 3 filestore
>>    1/ 3 journal
>>    0/ 5 ms
>>    1/ 5 mon
>>    0/10 monc
>>    0/ 5 paxos
>>    0/ 5 tp
>>    1/ 5 auth
>>    1/ 5 crypto
>>    1/ 1 finisher
>>    1/ 5 heartbeatmap
>>    1/ 5 perfcounter
>>    1/ 5 rgw
>>    1/ 5 hadoop
>>    1/ 5 javaclient
>>    1/ 5 asok
>>    1/ 1 throttle
>>   -2/-2 (syslog threshold)
>>   -1/-1 (stderr threshold)
>>   max_recent    100000
>>   max_new         1000
>>   log_file /var/log/ceph/ceph-osd.9.log
>> --- end dump of recent events ---
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
