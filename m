From: Haomai Wang <haomai@xsky.com>
Subject: Re: Fork and RDMA operations
Date: Fri, 12 Aug 2016 23:22:25 +0800
Message-ID: <CACJqLybXfss4ay5+9WV6Ux1myrkDBiBN2jUSrbVKB44kak-XQg@mail.gmail.com>
References: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440> <alpine.DEB.2.11.1608121314380.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0132.outbound.protection.outlook.com ([104.47.93.132]:41041
	"EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752601AbcHLP4D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 11:56:03 -0400
Received: by mail-ua0-f175.google.com with SMTP id 97so46723926uav.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 08:22:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608121314380.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Vu Pham <vuhuong@mellanox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Avner Ben Hanoch <avnerb@mellanox.com>, Oren Duer <oren@mellanox.com>

Hi Vu,

Actually you and me go into the same loop, in my async backend
pr(https://github.com/ceph/ceph/pull/10264) the
commit(https://github.com/ceph/ceph/pull/10264/commits/7055bafbcbf06425e71808cb2b089d1d04706728)
defines a interface for prefork/postfork things. It's much like
global_init_prefork_start/global_init_postfork_start but it's a
generic interface.

Refer to Kefu's comment why we need this:
=============
note to myself, w.r.t. the before/after daemonize hook

1. it's a natural way to do bind/rebind in the event thread
2. we do bind before daemon(2) now
3. the child process after daemon(2) is a single threaded process, and
all event threads are terminated, so no threads is taking care of
bind/rebind after daemon(2),

that's why we need to re-spawn the threads after daemon(2).
=============

So let's resolve alike problem like this


On Fri, Aug 12, 2016 at 9:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 11 Aug 2016, Vu Pham wrote:
>> Hello all,
>>
>> The background:
>> We have tested scaling with xio messenger and faced multiple *unknown*
>> problems (hard to trace and reproduce). We recently find out that the
>> daemonize/fork support isn't full in ibverbs. It assumes that the parent
>> process will do the RDMA operations. Any child process try to do rdma
>> operations will experience various unexpected problems.
>>
>> ceph-osd/ceph-mon/ceph-mds daemonize (fork) after creating messengers.
>> Xio messenger will initialize accelio library and register RDMA memory
>> in the 1st call to XioMessenger constructor.
>> This situation is very problematic where child process do rdma
>> operations as described above
>>
>> http://www.rdmamojo.com/2012/05/24/ibv_fork_init
>> http://www.spinics.net/lists/linux-rdma/msg03364.html
>> I create this PR which forces to daemonize/fork before creating
>> messenger
>>
>> https://github.com/ceph/ceph/pull/10600
>>
>> I have tested this patch by bringing up a cluster with 4 nodes, 8
>> osds/node, two monitors and run I/Os (4K - 4M block size) from 4 fio
>> clients.
>>
>> Is there any known problem to daemonize/fork before creating messenger?
>> Could you help to review and provide feedback?
>
> This more or less works.  The main issue is that we don't catch errors as
> early as we did and a daemon may appear to start and then immediately
> exit without printing an error.
>
> There is a Preforker class in common that is meant to address this (it's
> used by ceph-fuse and ceph-mon already).  It does the fork early, when
> prefork() is called, and keeps stdout/stderr open for an interim period
> until you call preforker.exit() or .daemonize().  Any exit code gets
> passed back to the parent over a socket.  I'm guessing that the mon is
> already working fine since you're just moving the prefork.daemonize() line
> around (the actual fork happened way back at
>
>         https://github.com/vuhuong/ceph-upstream/blob/5cd5546fb7ddb9ef69380476b0a80038ba74a405/src/ceph_mon.cc#L500
>
> ) and you just need to make ceph_osd.cc and ceph_mds.cc use Preforker in a
> similar way.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
