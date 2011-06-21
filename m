From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: error: =?UTF-8?Q?=27pthread=5Fspin=5Flock=27=20does=20not=20name?=
 =?UTF-8?Q?=20a=20type?=
Date: Mon, 20 Jun 2011 23:55:39 -0500
Message-ID: <44eba4c7dce082b9d25c96de62ead304@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:36205 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab1FUEzj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jun 2011 00:55:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi List!


 Ceph master seems to be broken on my development machine.  Here's the 
 error:


 i686-pc-linux-gnu-g++ -DHAVE_CONFIG_H -I.     -Wall -D__CEPH__ 
 -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdyna ic 
 -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
 -fno-strict-aliasing -Wnon-virtual-dtor -Wno-invalid-o fsetof 
 -Wstrict-null-sentinel   -march=pentium3 -pipe -ggdb -MT 
 libcommon_a-AuthNoneAuthorizeHandler.o -MD -MP -MF .deps 
 libcommon_a-AuthNoneAuthorizeHandler.Tpo -c -o 
 libcommon_a-AuthNoneAuthorizeHandler.o `test -f 
 'auth/none/AuthNoneAuthor zeHandler.cc' || echo 
 './'`auth/none/AuthNoneAuthorizeHandler.cc
 In file included from ./msg/Message.h:138,
                  from ./messages/PaxosServiceMessage.h:4,
                  from ./messages/MAuth.h:18,
                  from auth/AuthClientHandler.cc:21:
 ./include/atomic.h:66: error: 'pthread_spin_lock' does not name a type
 ./include/atomic.h: In constructor 'ceph::atomic_t::atomic_t(int)':
 ./include/atomic.h:71: error: 'lock' was not declared in this scope
 ./include/atomic.h: In destructor 'ceph::atomic_t::~atomic_t()':
 ./include/atomic.h:74: error: 'lock' was not declared in this scope
 ./include/atomic.h: In member function 'int ceph::atomic_t::inc()':
 ./include/atomic.h:77: error: 'lock' was not declared in this scope
 ./include/atomic.h: In member function 'int ceph::atomic_t::dec()':
 ./include/atomic.h:83: error: 'lock' was not declared in this scope
 ./include/atomic.h: In member function 'void ceph::atomic_t::add(int)':
 ./include/atomic.h:89: error: 'lock' was not declared in this scope
 ./include/atomic.h: In member function 'void ceph::atomic_t::sub(int)':
 ./include/atomic.h:94: error: 'lock' was not declared in this scope
 ./include/atomic.h: In member function 'int ceph::atomic_t::read() 
 const':
 ./include/atomic.h:100: error: 'lock' was not declared in this scope





 I've bisected the error back to this commit:
 03c83799b3915dd8e42606a23bcc9b01a5a48bac is the first bad commit
 commit 03c83799b3915dd8e42606a23bcc9b01a5a48bac
 Author: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
 Date:   Fri Jun 10 14:43:28 2011 -0700

     include/atomic cleanup
 
     * Don't allow copying of class atomic_t.
     * Remove common/Spinlock.h because it's unecessary
     * SimpleMessenger: use atomic var for qlen
 
     Signed-off-by: Colin McCabe <colin.mccabe@dreamhost.com>

 :040000 040000 1f89f38df725669be6a302634cd9a3624632cb11 
 3e4bae4751d40947710767efd2533bdc02d8a53a M      src






 I am running GLIBC 2.12.2.






-- 
 Thanks,
 Dyweni
