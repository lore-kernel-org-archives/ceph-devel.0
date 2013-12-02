From: charles L <charlesboy009@hotmail.com>
Subject: RE: /usr/bin/ld: cannot find -lboost_program_options
Date: Mon, 2 Dec 2013 04:08:18 +0100
Message-ID: <DUB116-W134E49F9CEF650DA65ED882E0EA0@phx.gbl>
References: <DUB116-W1392EBBBE3792703D625FEFE0EA0@phx.gbl>,<529BEDF9.8050009@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc3-s2.dub0.hotmail.com ([157.55.2.11]:23939 "EHLO
	dub0-omc3-s2.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439Ab3LBDIT convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 Dec 2013 22:08:19 -0500
In-Reply-To: <529BEDF9.8050009@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

i reinstalled ...libboost-program-options-dev and it fixed the issue.

Thanks.
----------------------------------------
> Date: Mon, 2 Dec 2013 10:18:33 +0800
> From: liwang@ubuntukylin.com
> To: charlesboy009@hotmail.com
> CC: ceph-devel@vger.kernel.org
> Subject: Re: /usr/bin/ld: cannot find -lboost_program_options
>
> Please install libboost-program-options-dev package before compiling
> for example, for Ubuntu,
> sudo apt-get install libboost-program-options-dev
>
> On 12/02/2013 09:57 AM, charles L wrote:
>> Pls can some1 help? Im compiling ceph...i did the make -j2 command and got this "cannot find -lboost_program_options" many times ..so i tried to run make in verbose mode...and got this...
>>
>> root@ubuntuserver:/home/ceph# V=1 make
>> Making all in .
>> make[1]: Entering directory `/home/ceph'
>> make[1]: Nothing to be done for `all-am'.
>> make[1]: Leaving directory `/home/ceph'
>> Making all in src
>> make[1]: Entering directory `/home/ceph/src'
>> make all-recursive
>> make[2]: Entering directory `/home/ceph/src'
>> Making all in ocf
>> make[3]: Entering directory `/home/ceph/src/ocf'
>> make[3]: Nothing to be done for `all'.
>> make[3]: Leaving directory `/home/ceph/src/ocf'
>> Making all in java
>> make[3]: Entering directory `/home/ceph/src/java'
>> make all-am
>> make[4]: Entering directory `/home/ceph/src/java'
>> make[4]: Nothing to be done for `all-am'.
>> make[4]: Leaving directory `/home/ceph/src/java'
>> make[3]: Leaving directory `/home/ceph/src/java'
>> make[3]: Entering directory `/home/ceph/src'
>> ./check_version ./.git_version
>> ./.git_version is up to date.
>> /bin/bash ../libtool --tag=CXX --mode=link g++ -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing -fsigned-char -rdynamic -Wnon-virtual-dtor -Wno-invalid-offsetof -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free -Wstrict-null-sentinel -g -Wl,--as-needed -latomic_ops -o ceph_filestore_tool tools/ceph-filestore-tool.o libosd.la libosdc.la libos.la -laio -lleveldb -lsnappy libperfglue.la -ltcmalloc libos.la -laio -lleveldb -lsnappy libglobal.la -lpthread -lm -lcrypto++ -luuid -lm -lkeyutils -lrt -lboost_program_options -ldl -lboost_thread -lboost_system -lleveldb -lsnappy
>> libtool: link: g++ -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing -fsigned-char -rdynamic -Wnon-virtual-dtor -Wno-invalid-offsetof -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free -Wstrict-null-sentinel -g -Wl,--as-needed -o ceph_filestore_tool tools/ceph-filestore-tool.o /usr/lib/libatomic_ops.a ./.libs/libosd.a ./.libs/libosdc.a ./.libs/libperfglue.a -ltcmalloc ./.libs/libos.a -laio ./.libs/libglobal.a -lpthread -lcrypto++ -luuid -lm -lkeyutils -lrt -lboost_program_options -ldl -lboost_thread -lboost_system -lleveldb -lsnappy
>> /usr/bin/ld: cannot find -lboost_program_options
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [ceph_filestore_tool] Error 1
>> make[3]: Leaving directory `/home/ceph/src'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/home/ceph/src'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/ceph/src'
>> make: *** [all-recursive] Error 1 --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> 		 	   		  