From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cmake build. C compiler.
Date: Tue, 20 Sep 2016 00:00:44 +0200
Message-ID: <c41894d2-1d9f-b640-b9e3-bcc958a8a518@digiware.nl>
References: <D405A8C2.12B32%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:63063 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753209AbcISWAw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Sep 2016 18:00:52 -0400
In-Reply-To: <D405A8C2.12B32%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 19-9-2016 23:37, Evgeniy Firsov wrote:
> Hi, Guys,
> 
> When I build Ceph using ./do_cmake.sh && cd build && make -j32, looks like
> everything is compiled using C++ compiler, even files with .c extension.
> This fails ZetaScale compilation, which is pure C.
> 
> In oppose to that if I am building ³in tree², with cmake . && make -j32,
> Ceph build fails, because it uses proper C compiler for .c extension, but
> they include Ceph¹s assert.h which is C++.
> 
> So, probably, I need to configure compiler on per directory basis, is
> there known way to do that?
> Also, can somebody point me where in the CMakeList.txt compiler is
> configured for ³out of tree² build? I mean C++ for everything.

You can run
	cmake --system-information
to find out what you system is using for defaults....

Mine (FreeBSD) has:

CMAKE_CXX_COMPILER == "/usr/bin/CC"
CMAKE_C_COMPILER == "/usr/bin/cc"

So it sort of already knows from the beginning the difference between C
and C++

--WjW
> 
> ‹
> Evgeniy
> 
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

