From: Ira Cooper <ira@wakeful.net>
Subject: --with-libxfs error on F23.
Date: Tue, 29 Mar 2016 18:10:37 -0400
Message-ID: <87oa9xndeq.fsf@ira-t430.wakeful.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35298 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbcC2WKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 18:10:44 -0400
Received: by mail-qg0-f45.google.com with SMTP id y89so24532493qge.2
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 15:10:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, hch@lst.de

Work is being done on Fedora 23.

checking xfs/xfs.h usability... no
checking xfs/xfs.h presence... yes
configure: WARNING: xfs/xfs.h: present but cannot be compiled
configure: WARNING: xfs/xfs.h:     check for missing prerequisite headers?
configure: WARNING: xfs/xfs.h: see the Autoconf documentation
configure: WARNING: xfs/xfs.h:     section "Present But Cannot Be Compiled"
configure: WARNING: xfs/xfs.h: proceeding with the compiler's result
configure: WARNING:     ## ----------------------------------------- ##
configure: WARNING:     ## Report this to ceph-devel@vger.kernel.org ##
configure: WARNING:     ## ----------------------------------------- ##

There has been a change in the XFS header files, where there's a
problem:

(from config.log)

configure:23389: gcc -c -g -O2  conftest.c >&5
In file included from /usr/include/xfs/xfs.h:37:0,
                 from conftest.c:86:
/usr/include/xfs/linux.h:145:9: error: unknown type name 'off64_t'
 typedef off64_t  xfs_off_t;

ira@ira-t430:/usr/include/xfs
[/dev/pts/1](1002/0)$ ag off64_t
linux.h
145:typedef off64_t		xfs_off_t;

off64_t isn't there by default.

Kernel/Headers: uname -a 
Linux ira-t430 4.4.6-300.fc23.x86_64 #1 SMP Wed Mar 16 22:10:37 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

My research turned up:

http://oss.sgi.com/archives/xfs/2016-01/msg00385.html

Ironically:

http://oss.sgi.com/archives/xfs/2009-11/msg00151.html

So it is known there was issues with off64_t in the past.

A google search showed other projects having issues, alas. What is a
good next step?  I'd be glad to provide a revert patch for the kernel.

Cheers,

-Ira
