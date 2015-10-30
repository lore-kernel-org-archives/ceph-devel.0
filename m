From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Async reads, sync writes, op thread model discussion
Date: Fri, 30 Oct 2015 12:55:19 -0400
Message-ID: <20151030165518.GA30622@ultraspiritum.redhat.com>
References: <CAN=+7FU-2TDMGjc_VnizjPcXrefyzVaDZCbxpFtDaoRhYObtPw@mail.gmail.com>
 <466106455.5089126.1439587153429.JavaMail.zimbra@redhat.com>
 <CANP1eJE9ac27PvcqQS_SqTvgeQLOGyc4VjZh1Qz2Vm9zPmi5Sw@mail.gmail.com>
 <CAN=+7FU2wEsg3ftmND7LiXEz0Qq4-JLegdmgsKYN9MoWRNTszA@mail.gmail.com>
 <3649A15A2562B54294DE14BCE5AC79120B5973F5@FMSMSX119.amr.corp.intel.com>
 <CAN=+7FU5gdAM-PsuyN0MDimQCbcLo7dh87ZrtXTpgMqzS8NPpA@mail.gmail.com>
 <CAN=+7FV7MWJBSU7NP1rM+283yAgWxfMr6tqow6wufjzvHj7NBw@mail.gmail.com>
 <1544035527.68429313.1446222005998.JavaMail.zimbra@redhat.com>
 <1491577902.41976602.1446223269619.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbbJ3QzX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Oct 2015 12:55:23 -0400
Content-Disposition: inline
In-Reply-To: <1491577902.41976602.1446223269619.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Milosz Tanski <milosz@adfin.com>, Matt Benjamin <mbenjamin@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Sage Weil <sage@newdream.net>, Adam Emerson <aemerson@redhat.com>, Stephen L Blinick <stephen.l.blinick@intel.com>

On 30/10/2015, Jason Dillaman wrote:
> In terms of overhead for the interface, is your concern due to the
> potential for more heap allocations for storing tasks to complete
> the future?  If that's the case, Adam's std::function replacement [1],
> which allocates a configurable amount of storage on the stack (as opposed
> to going to the heap for functions larger than 16 bytes as in the GCC
> implementation [2]), might be a good compromise.
> 
> I had some time to deep-dive through the seastar library this week and
> was really impressed by its design.  I know we (semi-)recently needed to
> introduce a workaround change to librbd which now results in a context
> switch for each AIO op -- all to ensure that we never block the QEMU IO
> thread.  Long term, I would love if we could take some of these reactive
> programming concepts to avoid all potential blocking on the librbd /
> librados IO path (with a side benefit of perhaps eliminating the potential
> for thousands of network IO threads by instead sharding the work).
> 
> [1] http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/27100
> [2] http://www.drdobbs.com/cpp/efficient-use-of-lambda-expressions-and/232500059?pgno=2

We have been working on a short run prototype/research project to see
about using Seastar itself as a reimplementation of the OSD top-half that
can support the semantics that Ceph's placement group system currently
relies upon as well as different guarantees alongside them. This is
part of our effort to repackage and upstream the Cohort low-latency
OSD work in a way that will integrate better with the existing Ceph
requirements. (Eric is also hoping to use this as a model for
implementing and evaluating DM-CLOCK.)

We did find that replacing Context* with the static-reservation function
implementation greatly improved the performance of Objecter (which
is what I initially designed it for), but there was still a lot of
lock contention. While Seastar itself as it exists is not suitable for
client applications (since it wants to take over your whole program and
assumes it owns cores in their entirety) a refactoring or inspiration
from Seastar that included futures, the CPU-affine allocator, their
mostly lock-free approach, and their userspace network support would
likely give even better gains in Objecter performance. We are not (yet)
working on Objecter, but we would love to collaborate with anyone wanting
to do this work.

-- 
Adam C. Emerson, Senior Software Engineer
Red Hat Storage, Ann Arbor, Michigan, United States
