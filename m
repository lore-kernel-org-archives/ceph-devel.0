From: Takuya ASADA <syuu@dokukino.com>
Subject: "acconfig.h: No such file or directory" when -DNO_ATOMIC_OPS
Date: Tue, 3 Aug 2010 22:53:40 +0900
Message-ID: <AANLkTi=-00_d8_ZM_jz+HWBv9Hk1L5JGPss2ri6tHXvo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45274 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949Ab0HCNyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Aug 2010 09:54:01 -0400
Received: by wwj40 with SMTP id 40so5160846wwj.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Aug 2010 06:54:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The program using librados.hpp cannot compile in case
-DNO_ATOMIC_OPS(without libatomic_ops), like this:

g++ -Wall -Werror -D_FILE_OFFSET_BITS=64 -g -DNO_ATOMIC_OPS   -c -o
put_obj.o put_obj.cc
In file included from /usr/local/include/rados/Spinlock.h:19,
                 from /usr/local/include/rados/atomic.h:57,
                 from /usr/local/include/rados/buffer.h:55,
                 from /usr/local/include/rados/librados.hpp:9,
                 from put_obj.cc:6:
/usr/local/include/rados/assert.h:6:22: error: acconfig.h: No such
file or directory

To avoid the error, we need to comment out #include "acconfig.h" in assert.h.

If libatomic_ops exist, it won't happen.
yum -y install libatomic_ops-devel
g++ -Wall -Werror -D_FILE_OFFSET_BITS=64 -g -c -o put_obj.o put_obj.cc

Note: put_obj.cc is on github.com.
http://github.com/syuu1228/radoscmds/blob/master/put_obj.cc

syuu
