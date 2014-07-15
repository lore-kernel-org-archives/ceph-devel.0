From: Sage Weil <sweil@redhat.com>
Subject: rpm dependencies
Date: Mon, 14 Jul 2014 21:39:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407142132260.21295@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36642 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaGOEjL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jul 2014 00:39:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lpabon@redhat.com, ceph-devel@vger.kernel.org

Hey Luis,

I pushed wip-dencoder, which moves ceph-dencoder to ceph from ceph-common.  
This avoids the dependency for ceph-common.

For the librados2 package, though, there is still a leveldb dependency 
that makes no sense.  See the packages at

 http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/

 $ wget http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/librados2-0.82-595.g95f5a44.el6.x86_64.rpm
 $ rpm -qpR librados2-0.82-595.g95f5a44.el6.x86_64.rpm | grep level
 warning: librados2-0.82-595.g95f5a44.el6.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 03c3951a: NOKEY
 libleveldb.so.1()(64bit)
 $ rpm2cpio librados2-0.82-595.g95f5a44.el6.x86_64.rpm | cpio -i --make-directories
 ...
 $ ldd usr/lib/librados2.so.2 | grep -c leveldb
 1

Our Makefile.am doesn't specify that we link against leveldb for librados, 
although strangely it is listed in the librados.la file anyway (along with 
every other lib anything links against).  Despite this, ldd 
.libs/librados.so on my (debian) box doesn't list it when building 
locally.

The Makefile-env.am has --as-needed, which is supposed to make us only use 
dependencies we actually use.

Not sure what is going on with the RPM build that is putting this 
dependency in place...

Any idea what is going on?  :/

sage
