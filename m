From: Leander Yu <leander.yu@gmail.com>
Subject: Re: OSD assert fail
Date: Tue, 7 Sep 2010 10:28:15 +0800
Message-ID: <AANLkTinu=DYUreK8rt8QH4Gn=1NULi_mr1teUsESkRC+@mail.gmail.com>
References: <AANLkTi=MH3b8ar-tikkMw0v+PUYrCQ1VBsBbC37OaT-G@mail.gmail.com>
	<Pine.LNX.4.64.1009061138000.13506@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60414 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0IGC2R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Sep 2010 22:28:17 -0400
Received: by wwj40 with SMTP id 40so7399253wwj.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Sep 2010 19:28:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009061138000.13506@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
We have 3 osd failed first, two of them have the same log as osd3 ,
the other one is osd 7.
We just use it as a file system, I wrote a script to repeatedly write
a 10G file and delete it.
The only unusual thing I saw in the log was the journal file was
fulled before the code trace log.

The other thing is that when I try to restart the failed osd, more osd
crashed on other node. However we didn't get the core dump :(
Thanks.

Regards,
Leander Yu.


On Tue, Sep 7, 2010 at 2:42 AM, Sage Weil <sage@newdream.net> wrote:
> Hi,
>
> This is one we've seen before, issue #326
>
> =A0 =A0 =A0 =A0http://tracker.newdream.net/issues/326
>
> Was that the first (and only?) osd to fail?
>
> What kind of workload were you subjecting the cluster to? =A0Just the=
 file
> system? =A0RBD? =A0Anything unusual?
>
> Also, can you confirm what version of the code you were running? =A0T=
he osd
> log at /var/log/ceph/osd.*.log should have a version number and sha1 =
id,
> something like
>
> ceph version 0.22~rc (3cd9d853cd58c79dc12427be8488e57970abda04)
>
> Thanks!
> sage
>
>
> On Mon, 6 Sep 2010, Leander Yu wrote:
>
>> Hi all,
>> I have setup a 10 osd + 2 mds + 3 mon ceph cluster. it runs ok at
>> beginning. However after one day, some of the osd =A0crashed with
>> following assert fail
>> I am using the unstable trunk. ceph.conf is attached.
>>
>> -------------- osd 3 -----------------
>> osd/PG.h: In function 'void PG::IndexedLog::index(PG::Log::Entry&)':
>> osd/PG.h:429: FAILED assert(caller_ops.count(e.reqid) =3D=3D 0)
>> =A01: (OSD::_process_pg_info(unsigned int, int, PG::Info&, PG::Log&,
>> PG::Missing&, std::map<int, MOSDPGInfo*, std::less<int>,
>> std::allocator<std::pair<int const, MOSDPGInfo*> > >*, int&)+0xb06)
>> [0x4cf426]
>> =A02: (OSD::handle_pg_log(MOSDPGLog*)+0xa9) [0x4cf999]
>> =A03: (OSD::_dispatch(Message*)+0x3ed) [0x4e7dfd]
>> =A04: (OSD::ms_dispatch(Message*)+0x39) [0x4e86c9]
>> =A05: (SimpleMessenger::dispatch_entry()+0x789) [0x46b5f9]
>> =A06: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x45849c]
>> =A07: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
>> =A08: (()+0x6a3a) [0x7f69fd39ea3a]
>> =A09: (clone()+0x6d) [0x7f69fc5bc77d]
>>
>> -------------- osd 7 --------------------
>> osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_pull(MOS=
DSubOp*)':
>> osd/ReplicatedPG.cc:3021: FAILED assert(r =3D=3D 0)
>> =A01: (OSD::dequeue_op(PG*)+0x344) [0x4e6fd4]
>> =A02: (ThreadPool::worker()+0x28f) [0x5b5a9f]
>> =A03: (ThreadPool::WorkThread::entry()+0xd) [0x4f0acd]
>> =A04: (Thread::_entry_func(void*)+0xa) [0x46c0ca]
>> =A05: (()+0x6a3a) [0x7efff4f12a3a]
>> =A06: (clone()+0x6d) [0x7efff413077d]
>>
>> Please let me if you need more information. I still keep the
>> environment for collecting more data for debug.
>>
>> Thanks.
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
