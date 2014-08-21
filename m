From: Sage Weil <sweil@redhat.com>
Subject: Re: Building a tool which links with librados
Date: Thu, 21 Aug 2014 16:56:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408211653540.31169@cobra.newdream.net>
References: <297F9FFE-3717-463F-84E3-E53EA06EDF4F@inktank.com> <CAPYLRzheVbPRzA=DH5Gru1-OaJ48Buz9pSuhFLybAvOsqhcuSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49711 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaHUX43 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 19:56:29 -0400
In-Reply-To: <CAPYLRzheVbPRzA=DH5Gru1-OaJ48Buz9pSuhFLybAvOsqhcuSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: David Zafman <david.zafman@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 21 Aug 2014, Gregory Farnum wrote:
> On Thu, Aug 21, 2014 at 4:37 PM, David Zafman <david.zafman@inktank.com> wrote:
> >
> > Has anyone seen anything like this from an application linked with librados using valgrind?  Or a Segmentation fault on exit from such an application?
> >
> > Invalid free() / delete / delete[] / realloc()
> >     at 0x4C2A4BC: operator delete(void*) (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> >     by 0x8195C12: std::basic_string<char, std::char_traits<char>, std::allocator<char> >::~basic_string() (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16)
> >     by 0x13890F3: coll_t::~coll_t() (osd_types.h:468)
> >     by 0x8944DEC: __cxa_finalize (cxa_finalize.c:56)
> >     by 0x6E1CEC5: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
> >     by 0x725F400: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
> >     by 0x89449D0: __run_exit_handlers (exit.c:78)
> >     by 0x8944A54: exit (exit.c:100)
> >     by 0x137FF37: usage(boost::program_options::options_description&) (ceph_objectstore_tool.cc:1794)
> >     by 0x1380572: main (ceph_objectstore_tool.cc:1849)
> 
> This looks fairly strange to me ? why does ceph_objectstore_tool do
> anything with librados? I thought it was just hitting the OSD
> filesystem structure directly.
> Also note that the crash appears to be underneath the coll_t
> destructor, probably in destroying its string. That combined with the
> weird librados presence makes me think memory corruption is running
> over the stack somewhere.

Ah, this was fixed in 5d79605319fcde330bccce5e1b07276a98be02de in the 
wip-libcommon branch.  The problem is partly when we link libcommon 
staticaly (ceph-objectstore-tool) and dynamically (librados) at teh same 
time.  The easy fix here is not linking librados at all.

Not sure why we see this sometimes and not always.. maybe link order?  In 
any case, wip-libcommon moves libcommon.la into a .so shared between 
librados and the binary using it to avoid the problem.  Makes things 
slightly more restrictive with mixed versions, but i suspect it is worth 
avoiding this sort of pain.

Can you cherry-pick that commit and see if it resolves this for you?  
And/or merge in that entire branch?

sage


