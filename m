From: Gregory Farnum <greg@inktank.com>
Subject: Re: Building a tool which links with librados
Date: Thu, 21 Aug 2014 16:50:48 -0700
Message-ID: <CAPYLRzheVbPRzA=DH5Gru1-OaJ48Buz9pSuhFLybAvOsqhcuSw@mail.gmail.com>
References: <297F9FFE-3717-463F-84E3-E53EA06EDF4F@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:44301 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaHUXut convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 19:50:49 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so10005924qcv.26
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 16:50:48 -0700 (PDT)
In-Reply-To: <297F9FFE-3717-463F-84E3-E53EA06EDF4F@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 21, 2014 at 4:37 PM, David Zafman <david.zafman@inktank.com=
> wrote:
>
> Has anyone seen anything like this from an application linked with li=
brados using valgrind?  Or a Segmentation fault on exit from such an ap=
plication?
>
> Invalid free() / delete / delete[] / realloc()
>     at 0x4C2A4BC: operator delete(void*) (in /usr/lib/valgrind/vgprel=
oad_memcheck-amd64-linux.so)
>     by 0x8195C12: std::basic_string<char, std::char_traits<char>, std=
::allocator<char> >::~basic_string() (in /usr/lib/x86_64-linux-gnu/libs=
tdc++.so.6.0.16)
>     by 0x13890F3: coll_t::~coll_t() (osd_types.h:468)
>     by 0x8944DEC: __cxa_finalize (cxa_finalize.c:56)
>     by 0x6E1CEC5: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
>     by 0x725F400: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
>     by 0x89449D0: __run_exit_handlers (exit.c:78)
>     by 0x8944A54: exit (exit.c:100)
>     by 0x137FF37: usage(boost::program_options::options_description&)=
 (ceph_objectstore_tool.cc:1794)
>     by 0x1380572: main (ceph_objectstore_tool.cc:1849)

This looks fairly strange to me =E2=80=94 why does ceph_objectstore_too=
l do
anything with librados? I thought it was just hitting the OSD
filesystem structure directly.
Also note that the crash appears to be underneath the coll_t
destructor, probably in destroying its string. That combined with the
weird librados presence makes me think memory corruption is running
over the stack somewhere.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
