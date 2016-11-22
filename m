From: Marov Aleksey <Marov.A@raidix.com>
Subject: HA: ceph issue
Date: Tue, 22 Nov 2016 15:59:05 +0000
Message-ID: <FEC85B105C5F644CA51BDB90657EEA982DC9F1CC@DDSM-MBX2.digdes.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
 <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA98284250E8@ddsm-mbx01.digdes.com>
 <CACJqLyZRDpinsMZtDbM_zZHfi87FzC1HrCP0KRFEgAxgzGpjYQ@mail.gmail.com>
 <DB3PR05MB0793F7194A5C64F018E61012A9B20@DB3PR05MB0793.eurprd05.prod.outlook.com>,<CACJqLyaCJdK+G6V3_Cm36PRYrwQCoRZ02MyJCnDudSUmC=O4Tg@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9E133@DDSM-MBX2.digdes.com>,<DB3PR05MB0793FB50C98346C4983E3ABBA9B40@DB3PR05MB0793.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digdes.com ([85.114.5.13]:40847 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755827AbcKVQBR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 11:01:17 -0500
In-Reply-To: <DB3PR05MB0793FB50C98346C4983E3ABBA9B40@DB3PR05MB0793.eurprd05.prod.outlook.com>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>, Haomai Wang <haomai@xsky.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I didn't try this blocksize. But in my case fio crushed if I use more than one job. With one job everything works fine. Is it worth more deep investigating?

Alex
________________________________________
От: Avner Ben Hanoch [avnerb@mellanox.com]
Отправлено: 22 ноября 2016 г. 17:41
Кому: Marov Aleksey; Haomai Wang
Копия: Sage Weil; ceph-devel@vger.kernel.org
Тема: RE: ceph issue

Yup. same good status here.  Thanks for the fix.
I also recommend merging to master.

On a side note, executing "fio --blocksize=10M" bring my cluster to HEALTH_WARN with 8 requests are blocked > 32 sec.  The cluster recovers from this situation only after I kill the "bad fio process"

Avner

> -----Original Message-----
> From: Marov Aleksey [mailto:Marov.A@raidix.com]
> Sent: Monday, November 21, 2016 18:20
> To: Haomai Wang <haomai@xsky.com>; Avner Ben Hanoch
> <avnerb@mellanox.com>
> Cc: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: HA: ceph issue
>
> It seems for me that your last patch fixed the problem. It works  fine with fio
> 2.13 and fio 2.15.  I think it may be merged in master.
>
> Thanks a lot for your work. I'll do some performnace tests next.
>
> Best Regards
> Alex Marov
> ________________________________________
>
>
> @Avner plz try again, I submit a new patch to fix leaks.
>
> On Sun, Nov 20, 2016 at 10:29 PM, Avner Ben Hanoch
> <avnerb@mellanox.com> wrote:
> > Perhaps similar fix needed in additional places.
> > See my stack trace below (failed on same assert(sub < m_subsys.size()))
> >
> > --
> > #0  0x00007fffe55525f7 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> > #1  0x00007fffe5553ce8 in __GI_abort () at abort.c:90
> > #2  0x00007fffe6dbbd47 in ceph::__ceph_assert_fail
> (assertion=assertion@entry=0x7fffe70599d8 "sub < m_subsys.size()",
> >     file=file@entry=0x7fffe7059688
> "/mnt/data/avnerb/rpmbuild/BUILD/ceph-11.0.2-1611-
> geb25965/src/log/SubsystemMap.h", line=line@entry=62,
> >     func=func@entry=0x7fffe7074040
> <_ZZN4ceph7logging12SubsystemMap13should_gatherEjiE19__PRETTY_FUNCT
> ION__> "bool ceph::logging::SubsystemMap::should_gather(unsigned int,
> int)")
> >     at /usr/src/debug/ceph-11.0.2-1611-geb25965/src/common/assert.cc:78
> > #3  0x00007fffe6cd215a in ceph::logging::SubsystemMap::should_gather
> (level=10, sub=27, this=<optimized out>) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/log/SubsystemMap.h:62
> > #4  0x00007fffe6e65865 in should_gather (level=10, sub=27, this=<optimized
> out>) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/net_handler.cc:180
> > #5  ceph::NetHandler::generic_connect (this=0x86dc18, addr=...,
> nonblock=nonblock@entry=false) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/net_handler.cc:174
> > #6  0x00007fffe6e65b17 in ceph::NetHandler::connect (this=<optimized
> out>, addr=...) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/net_handler.cc:198
> > #7  0x00007fffe700105c in RDMAConnectedSocketImpl::try_connect
> (this=this@entry=0x7fffbc000ef0, peer_addr=..., opts=...) at
> /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/rdma/RDMAConnectedSocketImpl.cc:111
> > #8  0x00007fffe6e68ed4 in RDMAWorker::connect (this=0x7fffa806e650,
> addr=..., opts=..., socket=0x7fffa00235b0) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/rdma/RDMAStack.cc:48
> > #9  0x00007fffe6fee873 in AsyncConnection::_process_connection
> (this=this@entry=0x7fffa0023450) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/AsyncConnection.cc:864
> > #10 0x00007fffe6ff5148 in AsyncConnection::process (this=0x7fffa0023450)
> at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/AsyncConnection.cc:812
> > #11 0x00007fffe6e5d6ac in EventCenter::process_events
> (this=this@entry=0x7fffa806e6d0, timeout_microseconds=<optimized out>,
> timeout_microseconds@entry=30000000)
> >     at /usr/src/debug/ceph-11.0.2-1611-geb25965/src/msg/async/Event.cc:430
> > #12 0x00007fffe6e5fbba in NetworkStack::__lambda1::operator()
> (__closure=0x7fffa80f5630) at /usr/src/debug/ceph-11.0.2-1611-
> geb25965/src/msg/async/Stack.cc:47
> > #13 0x00007fffe3e71220 in std::(anonymous
> namespace)::execute_native_thread_routine (__p=<optimized out>) at
> ../../../../../libstdc++-v3/src/c++11/thread.cc:84
> > #14 0x00007fffe5ae9dc5 in start_thread (arg=0x7fffcbb93700) at
> pthread_create.c:308
> > #15 0x00007fffe561321d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
> >
> >
> >> -----Original Message-----
> >> From: Avner Ben Hanoch
> >> Sent: Sunday, November 20, 2016 15:22
> >> To: 'Haomai Wang' <haomai@xsky.com>; Marov Aleksey
> >> <Marov.A@raidix.com>
> >> Cc: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> >> Subject: RE: ceph issue
> >>
> >> This PR doesn't have any effect on the assertion.  I still get it in same
> situation
> >>
> >> ---
> >> $ ./fio --ioengine=rbd --invalidate=0 --rw=write --bs=10M --numjobs=1 --
> >> clientname=admin --pool=rbd --iodepth=128 --rbdname=img2g --name=1
> >> 1: (g=0): rw=write, bs=10M-10M/10M-10M/10M-10M, ioengine=rbd,
> >> iodepth=128
> >> fio-2.13-91-gb678
> >> Starting 1 process
> >> rbd engine: RBD version: 0.1.11
> >> /mnt/data/avnerb/rpmbuild/BUILD/ceph-11.0.2-1611-
> >> geb25965/src/log/SubsystemMap.h: In function 'bool
> >> ceph::logging::SubsystemMap::should_gather(unsigned int, int)' thread
> >> 7f7c7b3a5700 time 2016-11-20 13:17:56.090289
> >> /mnt/data/avnerb/rpmbuild/BUILD/ceph-11.0.2-1611-
> >> geb25965/src/log/SubsystemMap.h: 62: FAILED assert(sub <
> m_subsys.size())
> >> ceph version 11.0.2-1611-geb25965
> >> (eb25965b74aa1a0379d091169d80786f30c72a8b)
> >> ---
> >>
> >> > -----Original Message-----
> >> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> > owner@vger.kernel.org] On Behalf Of Haomai Wang
> >> > Subject: Re: ceph issue
> >> >
> >> > sorry, I got the issue. I submitted a
> >> > pr(https://github.com/ceph/ceph/pull/12068). plz tested with this.
