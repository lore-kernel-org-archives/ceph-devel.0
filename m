From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph and SL5.5
Date: Mon, 19 Jul 2010 08:55:24 -0700
Message-ID: <AANLkTindmxl_fMYS0rHNVkWNhOHh8O3nZl3vH0AQRVVF@mail.gmail.com>
References: <EE7C26DD-410B-4169-9EFD-98B6D682B216@cern.ch>
	<i1sebn$mh$1@dough.gmane.org>
	<4C886908-67E2-44D0-9EAB-8EA275A63838@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54882 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936159Ab0GSPzf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jul 2010 11:55:35 -0400
Received: by pxi14 with SMTP id 14so1836354pxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 08:55:34 -0700 (PDT)
In-Reply-To: <4C886908-67E2-44D0-9EAB-8EA275A63838@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: effie mouzeli <emouzeli@cern.ch>
Cc: Thomas Mueller <thomas@chaschperli.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Thank you very much! I tried the unstable version on Saturday, which =
=A0looks a lot better, but I am still facing similar issues:
>
> - The first one is when writing files, I usually get the message from=
 cfuse,
>
> 10.07.17_23:13:12.117289 42f16940 client4213.objecter =A0pg 0.90ea on=
 [1,0] is laggy: 51723
> 10.07.17_23:13:12.117302 42f16940 client4213.objecter =A0pg 0.4194 on=
 [1,0] is laggy: 51722
This means the OSD is being slow to acknowledge some writes. It can
indicate that an OSD has crashed, but here it's probably just because
your drive is struggling to keep up with two VMs and all the write
streams (2x OSD journals, MDS journal via OSDs, client writes via
OSDs). Annoying but not important.


> - In some cases, cfuse (I turned off daemonizing) crushes, again when=
 writing on the filesystem, but not due to xlist:
>
> osdc/ObjectCacher.cc: In function 'void ObjectCacher::bh_write_ack(so=
bject_t, loff_t, uint64_t, tid_t)':
> osdc/ObjectCacher.cc:670: FAILED assert(ob->last_ack_tid < tid)
> =A01: (ObjectCacher::bh_write_ack(sobject_t, long, unsigned long, uns=
igned long)+0x6a8) [0x6b2bc2]
> =A02: (ObjectCacher::C_WriteAck::finish(int)+0x57) [0x6c955b]
> =A03: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xbd1) [0x688f07]
> =A04: (Client::ms_dispatch(Message*)+0xd8) [0x61f4ca]
> =A05: (Messenger::ms_deliver_dispatch(Message*)+0x55) [0x5ff0b7]
> =A06: (SimpleMessenger::dispatch_entry()+0x50f) [0x5ea2e7]
> =A07: (SimpleMessenger::DispatchThread::entry()+0x29) [0x5e8a1f]
> =A08: (Thread::_entry_func(void*)+0x20) [0x5f8c0a]
> =A09: /lib64/libpthread.so.0 [0x3d7420673d]
> =A010: (clone()+0x6d) [0x3d736d3d1d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> osdc/ObjectCacher.cc: In function 'void ObjectCacher::bh_write_ack(so=
bject_t, loff_t, uint64_t, tid_t)':
> osdc/ObjectCacher.cc:670: FAILED assert(ob->last_ack_tid < tid)
> =A01: (ObjectCacher::bh_write_ack(sobject_t, long, unsigned long, uns=
igned long)+0x6a8) [0x6b2bc2]
> =A02: (ObjectCacher::C_WriteAck::finish(int)+0x57) [0x6c955b]
> =A03: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xbd1) [0x688f07]
> =A04: (Client::ms_dispatch(Message*)+0xd8) [0x61f4ca]
> =A05: (Messenger::ms_deliver_dispatch(Message*)+0x55) [0x5ff0b7]
> =A06: (SimpleMessenger::dispatch_entry()+0x50f) [0x5ea2e7]
> =A07: (SimpleMessenger::DispatchThread::entry()+0x29) [0x5e8a1f]
> =A08: (Thread::_entry_func(void*)+0x20) [0x5f8c0a]
> =A09: /lib64/libpthread.so.0 [0x3d7420673d]
> =A010: (clone()+0x6d) [0x3d736d3d1d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion=
*'
> Aborted
Hmm, that's not an error I'm familiar with. What sort of workload is
producing this, and can you
1) Give us a copy of your executable and the core file?
2) Try and reproduce it with debugging on for the client: cfuse mnt
--debug_client 20 --debug_objecter 20 --log-file=3D"/dir/to/log"
and give us that log.


> - Finally, I don't get what's wrong with deleting. Especially when th=
en client crashes, but even when using rm, I don't see the filesystem f=
reeing any space :(
Well, that definitely shouldn't happen, are you getting error messages
anywhere? I think Sage may have dealt with a bug report on something
like this recently, but I don't recall...he'll have to weigh in
himself. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
