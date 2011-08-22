From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: ceph-0.33 make
Date: Mon, 22 Aug 2011 12:26:22 -0700
Message-ID: <CA+qbEUMxSwtNVGJmeixfaNuQz4+mCryE=+NcyAbnKpqLxzG35w@mail.gmail.com>
References: <CADSLUZkRr4rs1nxGJ04bY50mrQOykANLifxpS5QEFmDw+cNxBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56990 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab1HVT0Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2011 15:26:24 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B39F8C06E
	for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 12:29:02 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 61928C06A
	for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 12:29:02 -0700 (PDT)
Received: by fxh19 with SMTP id 19so3467362fxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 12:26:22 -0700 (PDT)
In-Reply-To: <CADSLUZkRr4rs1nxGJ04bY50mrQOykANLifxpS5QEFmDw+cNxBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p6X55Sx5riF?= <linyouqing7@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

This should be resolved by change
abe5cd28d1e1e1e1684cd227cf9f9272202bea8d in the master branch.

Give it a try and see if you can compile with the new code.

cheers,
Colin


On Fri, Aug 19, 2011 at 11:32 PM, =E6=9E=97=E7=94=B1=E6=B8=85 <linyouqi=
ng7@gmail.com> wrote:
> centos5.5 i386 , ceph-0.33
>
> #./autogen.sh&&./configure
> # make
>
> then , I meet some =C2=A0problems:
>
> common/admin_socket.cc: In static member function ?.tatic std::string
> AdminSocket::create_shutdown_pipe(int*, int*)?.
> common/admin_socket.cc:113: error: ?._CLOEXEC?.was not declared in th=
is scope
> common/admin_socket.cc:113: error: ?.ipe2?.was not declared in this s=
cope
> make[3]: *** [libcommon_la-admin_socket.lo] Error 1
> make[3]: Leaving directory `/usr/src/lyq/ceph-0.33/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/usr/src/lyq/ceph-0.33/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/usr/src/lyq/ceph-0.33/src'
> make: *** [all-recursive] Error 1
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
