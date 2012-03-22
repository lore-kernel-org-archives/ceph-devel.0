From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: leveldb build issues in 0.44
Date: Thu, 22 Mar 2012 08:51:11 -0600
Message-ID: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:38597 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab2CVOvQ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Thu, 22 Mar 2012 10:51:16 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2MFlH54004081
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 09:47:19 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id A71F044C56
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 08:51:12 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to build ceph 0.44, but am running into some issues with leveldb not compiling correctly.  Here is the output:

make  all-recursive
make[2]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src'
Making all in ocf
make[3]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/ocf'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/ocf'
Making all in leveldb
make[3]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/leveldb'
make  all-am
make[4]: Entering directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/leveldb'
  CXX    builder.o
In file included from ./db/builder.cc:5:0:
./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or directory
compilation terminated.
make[4]: *** [builder.o] Error 1
make[4]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/leveldb'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/abuild/rpmbuild/BUILD/ceph-0.44/src/leveldb'

If I look in the src/leveldb/include directory, I see leveldb/status.h, so I'm not sure why it is failing here?  Is there a dependency that I'm missing somewhere?  This is an RPM build - if I download the tarball and compile manually it seems to work, though I am doing that on a different system, so that may not be a great test.

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
