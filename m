From: David Zafman <david.zafman@inktank.com>
Subject: Building a tool which links with librados
Date: Thu, 21 Aug 2014 16:37:14 -0700
Message-ID: <297F9FFE-3717-463F-84E3-E53EA06EDF4F@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49915 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbaHUXhS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 19:37:18 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so14713641pdb.5
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 16:37:18 -0700 (PDT)
Received: from [10.0.1.27] (cpe-23-242-12-23.socal.res.rr.com. [23.242.12.23])
        by mx.google.com with ESMTPSA id ou8sm14752279pbc.84.2014.08.21.16.37.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 16:37:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Has anyone seen anything like this from an application linked with librados using valgrind?  Or a Segmentation fault on exit from such an application?

Invalid free() / delete / delete[] / realloc()
    at 0x4C2A4BC: operator delete(void*) (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    by 0x8195C12: std::basic_string<char, std::char_traits<char>, std::allocator<char> >::~basic_string() (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16)
    by 0x13890F3: coll_t::~coll_t() (osd_types.h:468)
    by 0x8944DEC: __cxa_finalize (cxa_finalize.c:56)
    by 0x6E1CEC5: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
    by 0x725F400: ??? (in /src/ceph/src/.libs/librados.so.2.0.0)
    by 0x89449D0: __run_exit_handlers (exit.c:78)
    by 0x8944A54: exit (exit.c:100)
    by 0x137FF37: usage(boost::program_options::options_description&) (ceph_objectstore_tool.cc:1794)
    by 0x1380572: main (ceph_objectstore_tool.cc:1849)

David Zafman
Senior Developer
http://www.inktank.com
http://www.redhat.com

