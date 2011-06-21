From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: error: 'pthread_spin_lock' does not name a type
Date: Mon, 20 Jun 2011 22:36:35 -0700
Message-ID: <BANLkTimc_PUHPbYT2+Wcwwb47bEqxtD+uQ@mail.gmail.com>
References: <44eba4c7dce082b9d25c96de62ead304@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39002 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1FUFgg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2011 01:36:36 -0400
Received: by fxm17 with SMTP id 17so1419737fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2011 22:36:35 -0700 (PDT)
In-Reply-To: <44eba4c7dce082b9d25c96de62ead304@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi Dyweni,

It seems that you do not have libatomic ops, so you spotted a build
error that I overlooked.
Thanks for the report, it should be fixed shortly.

cheers,
Colin


On Mon, Jun 20, 2011 at 9:55 PM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> Hi List!
>
>
> Ceph master seems to be broken on my development machine. =A0Here's t=
he error:
>
>
> i686-pc-linux-gnu-g++ -DHAVE_CONFIG_H -I. =A0 =A0 -Wall -D__CEPH__
> -D_FILE_OFFSET_BITS=3D64 -D_REENTRANT -D_THREAD_SAFE -rdyna ic -Wtype=
-limits
> -Wignored-qualifiers -Winit-self -Wpointer-arith -fno-strict-aliasing
> -Wnon-virtual-dtor -Wno-invalid-o fsetof -Wstrict-null-sentinel
> -march=3Dpentium3 -pipe -ggdb -MT libcommon_a-AuthNoneAuthorizeHandle=
r.o -MD
> -MP -MF .deps libcommon_a-AuthNoneAuthorizeHandler.Tpo -c -o
> libcommon_a-AuthNoneAuthorizeHandler.o `test -f 'auth/none/AuthNoneAu=
thor
> zeHandler.cc' || echo './'`auth/none/AuthNoneAuthorizeHandler.cc
> In file included from ./msg/Message.h:138,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from ./messages/PaxosServiceMessage.h=
:4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from ./messages/MAuth.h:18,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from auth/AuthClientHandler.cc:21:
> ./include/atomic.h:66: error: 'pthread_spin_lock' does not name a typ=
e
> ./include/atomic.h: In constructor 'ceph::atomic_t::atomic_t(int)':
> ./include/atomic.h:71: error: 'lock' was not declared in this scope
> ./include/atomic.h: In destructor 'ceph::atomic_t::~atomic_t()':
> ./include/atomic.h:74: error: 'lock' was not declared in this scope
> ./include/atomic.h: In member function 'int ceph::atomic_t::inc()':
> ./include/atomic.h:77: error: 'lock' was not declared in this scope
> ./include/atomic.h: In member function 'int ceph::atomic_t::dec()':
> ./include/atomic.h:83: error: 'lock' was not declared in this scope
> ./include/atomic.h: In member function 'void ceph::atomic_t::add(int)=
':
> ./include/atomic.h:89: error: 'lock' was not declared in this scope
> ./include/atomic.h: In member function 'void ceph::atomic_t::sub(int)=
':
> ./include/atomic.h:94: error: 'lock' was not declared in this scope
> ./include/atomic.h: In member function 'int ceph::atomic_t::read() co=
nst':
> ./include/atomic.h:100: error: 'lock' was not declared in this scope
>
>
>
>
>
> I've bisected the error back to this commit:
> 03c83799b3915dd8e42606a23bcc9b01a5a48bac is the first bad commit
> commit 03c83799b3915dd8e42606a23bcc9b01a5a48bac
> Author: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
> Date: =A0 Fri Jun 10 14:43:28 2011 -0700
>
> =A0 =A0include/atomic cleanup
>
> =A0 =A0* Don't allow copying of class atomic_t.
> =A0 =A0* Remove common/Spinlock.h because it's unecessary
> =A0 =A0* SimpleMessenger: use atomic var for qlen
>
> =A0 =A0Signed-off-by: Colin McCabe <colin.mccabe@dreamhost.com>
>
> :040000 040000 1f89f38df725669be6a302634cd9a3624632cb11
> 3e4bae4751d40947710767efd2533bdc02d8a53a M =A0 =A0 =A0src
>
>
>
>
>
>
> I am running GLIBC 2.12.2.
>
>
>
>
>
>
> --
> Thanks,
> Dyweni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
