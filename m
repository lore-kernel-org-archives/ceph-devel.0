From: effie mouzeli <emouzeli@cern.ch>
Subject: Re: Ceph and SL5.5
Date: Mon, 19 Jul 2010 04:28:53 +0100
Message-ID: <4C886908-67E2-44D0-9EAB-8EA275A63838@cern.ch>
References: <EE7C26DD-410B-4169-9EFD-98B6D682B216@cern.ch> <i1sebn$mh$1@dough.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx31.cern.ch ([137.138.144.179]:7063 "EHLO CERNMX31.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758337Ab0GSD24 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jul 2010 23:28:56 -0400
In-Reply-To: <i1sebn$mh$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Jul 17, 2010, at 3:22 pm, Thomas Mueller wrote:

> Am Sat, 17 Jul 2010 05:12:38 +0100 schrieb effie mouzeli:
> 
>> Hello all,
>> 
>> I am trying to check out how Ceph is doing under Scientific Linux 5.5
>> (unfortunately, academia loves SL).
>> 
>> Currently I am running a cluster of 2 VMs, VM 1 is mon, mds and osd,  VM
>> 2 is running osd only, and VM 3 is where I mount ceph.  All VMs  are
>> running  SL5.5 x86_64 with the latest updates  and are on a gbit
>> network. Additionally  I compiled ceph from source, (checked out 
>> yesterday), with fuse support, since SL5.5 has a 2.6.18 kernel.
> 
> IMHO SL is RHEL based (like CentOS).

Yeap, it is...

> 
> try to use the git version branch unstable. many problems are fixed since 
> last release. also your xlist error.

Thank you very much! I tried the unstable version on Saturday, which  looks a lot better, but I am still facing similar issues:

- The first one is when writing files, I usually get the message from cfuse,

10.07.17_23:13:12.117289 42f16940 client4213.objecter  pg 0.90ea on [1,0] is laggy: 51723
10.07.17_23:13:12.117302 42f16940 client4213.objecter  pg 0.4194 on [1,0] is laggy: 51722

- In some cases, cfuse (I turned off daemonizing) crushes, again when writing on the filesystem, but not due to xlist:

osdc/ObjectCacher.cc: In function 'void ObjectCacher::bh_write_ack(sobject_t, loff_t, uint64_t, tid_t)':
osdc/ObjectCacher.cc:670: FAILED assert(ob->last_ack_tid < tid)
 1: (ObjectCacher::bh_write_ack(sobject_t, long, unsigned long, unsigned long)+0x6a8) [0x6b2bc2]
 2: (ObjectCacher::C_WriteAck::finish(int)+0x57) [0x6c955b]
 3: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xbd1) [0x688f07]
 4: (Client::ms_dispatch(Message*)+0xd8) [0x61f4ca]
 5: (Messenger::ms_deliver_dispatch(Message*)+0x55) [0x5ff0b7]
 6: (SimpleMessenger::dispatch_entry()+0x50f) [0x5ea2e7]
 7: (SimpleMessenger::DispatchThread::entry()+0x29) [0x5e8a1f]
 8: (Thread::_entry_func(void*)+0x20) [0x5f8c0a]
 9: /lib64/libpthread.so.0 [0x3d7420673d]
 10: (clone()+0x6d) [0x3d736d3d1d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
osdc/ObjectCacher.cc: In function 'void ObjectCacher::bh_write_ack(sobject_t, loff_t, uint64_t, tid_t)':
osdc/ObjectCacher.cc:670: FAILED assert(ob->last_ack_tid < tid)
 1: (ObjectCacher::bh_write_ack(sobject_t, long, unsigned long, unsigned long)+0x6a8) [0x6b2bc2]
 2: (ObjectCacher::C_WriteAck::finish(int)+0x57) [0x6c955b]
 3: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xbd1) [0x688f07]
 4: (Client::ms_dispatch(Message*)+0xd8) [0x61f4ca]
 5: (Messenger::ms_deliver_dispatch(Message*)+0x55) [0x5ff0b7]
 6: (SimpleMessenger::dispatch_entry()+0x50f) [0x5ea2e7]
 7: (SimpleMessenger::DispatchThread::entry()+0x29) [0x5e8a1f]
 8: (Thread::_entry_func(void*)+0x20) [0x5f8c0a]
 9: /lib64/libpthread.so.0 [0x3d7420673d]
 10: (clone()+0x6d) [0x3d736d3d1d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
Aborted

- Finally, I don't get what's wrong with deleting. Especially when then client crashes, but even when using rm, I don't see the filesystem freeing any space :(

Thanx!

-effie






