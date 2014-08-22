From: David Zafman <david.zafman@inktank.com>
Subject: Re: Building a tool which links with librados
Date: Thu, 21 Aug 2014 17:11:52 -0700
Message-ID: <6FE165EA-9D00-4CC4-B372-B457933BDFFE@inktank.com>
References: <297F9FFE-3717-463F-84E3-E53EA06EDF4F@inktank.com> <CAPYLRzheVbPRzA=DH5Gru1-OaJ48Buz9pSuhFLybAvOsqhcuSw@mail.gmail.com> <alpine.DEB.2.00.1408211653540.31169@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47271 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbaHVAL4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 20:11:56 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so14683646pdj.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 17:11:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408211653540.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


The import-rados feature (#8276) uses librados so in my wip-8231 branch=
 I now link with librados.   It is hard to reproduce, but I=92ll play w=
ith that commit and branch.

David Zafman
Senior Developer
http://www.inktank.com
http://www.redhat.com

On Aug 21, 2014, at 4:56 PM, Sage Weil <sweil@redhat.com> wrote:

> On Thu, 21 Aug 2014, Gregory Farnum wrote:
>> On Thu, Aug 21, 2014 at 4:37 PM, David Zafman <david.zafman@inktank.=
com> wrote:
>>>=20
>>> Has anyone seen anything like this from an application linked with =
librados using valgrind?  Or a Segmentation fault on exit from such an =
application?
>>>=20
>>> Invalid free() / delete / delete[] / realloc()
>>>    at 0x4C2A4BC: operator delete(void*) (in /usr/lib/valgrind/vgpre=
load_memcheck-amd64-linux.so)
>>>    by 0x8195C12: std::basic_string<char, std::char_traits<char>, st=
d::allocator<char> >::~basic_string() (in /usr/lib/x86_64-linux-gnu/lib=
stdc++.so.6.0.16)
>>>    by 0x13890F3: coll_t::~coll_t() (osd_types.h:468)
>>>    by 0x8944DEC: __cxa_finalize (cxa_finalize.c:56)
>>>    by 0x6E1CEC5: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
>>>    by 0x725F400: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
>>>    by 0x89449D0: __run_exit_handlers (exit.c:78)
>>>    by 0x8944A54: exit (exit.c:100)
>>>    by 0x137FF37: usage(boost::program_options::options_description&=
) (ceph_objectstore_tool.cc:1794)
>>>    by 0x1380572: main (ceph_objectstore_tool.cc:1849)
>>=20
>> This looks fairly strange to me ? why does ceph_objectstore_tool do
>> anything with librados? I thought it was just hitting the OSD
>> filesystem structure directly.
>> Also note that the crash appears to be underneath the coll_t
>> destructor, probably in destroying its string. That combined with th=
e
>> weird librados presence makes me think memory corruption is running
>> over the stack somewhere.
>=20
> Ah, this was fixed in 5d79605319fcde330bccce5e1b07276a98be02de in the=
=20
> wip-libcommon branch.  The problem is partly when we link libcommon=20
> staticaly (ceph-objectstore-tool) and dynamically (librados) at teh s=
ame=20
> time.  The easy fix here is not linking librados at all.
>=20
> Not sure why we see this sometimes and not always.. maybe link order?=
  In=20
> any case, wip-libcommon moves libcommon.la into a .so shared between=20
> librados and the binary using it to avoid the problem.  Makes things=20
> slightly more restrictive with mixed versions, but i suspect it is wo=
rth=20
> avoiding this sort of pain.
>=20
> Can you cherry-pick that commit and see if it resolves this for you? =
=20
> And/or merge in that entire branch?
>=20
> sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
