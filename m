From: Tomoki BENIYA <beniya@bit-isle.co.jp>
Subject: Build error in 0.44
Date: Tue, 27 Mar 2012 17:43:18 +0900
Message-ID: <20120327171741.D52F.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bit-isle.co.jp ([61.117.207.4]:46388 "EHLO
	mail.bit-isle.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757611Ab2C0JSE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 05:18:04 -0400
Received: from [192.168.40.41] (unknown [219.166.46.195])
	by mail.bit-isle.co.jp (Postfix) with ESMTP id 9F3DF290007
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 17:41:27 +0900 (JST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all

When I build ceph 0.44, it occured error and failed to build.
They said following error
===================================
make: *** [build-stamp] Error 1
dpkg-buildpackage: error: debian/rules build gave error exit status 2
===================================

What should I do?


# cat /etc/debian_version
wheezy/sid

# uname -a
Linux debian7 3.1.0-1-amd64 #1 SMP Tue Jan 10 05:01:58 UTC 2012 x86_64 GNU/Linux

# dpkg-buildpackage
......
autoreconf: running: /usr/bin/autoheader --force
autoreconf: running: automake --add-missing --copy --force-missing
Makefile.am:182: `lib/libgtest.a' is not a standard libtool library name
Makefile.am:182: did you mean `lib/libgtest.la'?
Makefile.am:182: `lib/libgtest_main.a' is not a standard libtool library name
Makefile.am:182: did you mean `lib/libgtest_main.la'?
autoreconf: Leaving directory `.'
autoreconf: `configure.ac' or `configure.in' is required
make: *** [build-stamp] Error 1
dpkg-buildpackage: error: debian/rules build gave error exit status 2


-- 
Tomoki BENIYA <beniya@bit-isle.co.jp>

