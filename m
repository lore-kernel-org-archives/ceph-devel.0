From: Ali Maredia <amaredia@redhat.com>
Subject: Running Test Scripts without CMake Environment Variables
Date: Mon, 18 Apr 2016 17:53:34 -0400 (EDT)
Message-ID: <545596550.14429240.1461016414390.JavaMail.zimbra@redhat.com>
References: <75379254.14369376.1461010122306.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59292 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbcDRVxf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 17:53:35 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3ILrYj0021939
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 17:53:34 -0400
In-Reply-To: <75379254.14369376.1461010122306.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph community,

Recently certain tests that are run in `make check` (one's that end in .sh and a handful of others) were changed to remove relative paths and hard coded directories (".libs" was littered throughout the codebase). 

These test scripts pass when you run `make check` because of preset environment variables in CTest and in src/Makefile.am (CEPH_BIN, CEPH_ROOT, CEPH_LIB, CEPH_BUILD_DIR, etc.) that are meant to replace the relative paths from before. However running these tests by themselves after an autotools build without setting those variables before hand will result in failures. 

I understand how these recent changes disrupt developers workflows and plan on issuing a fix that defines those environment variables according to which build system you build with ASAP.

Finally I strongly encourage developers to transition to using CMake and CTest (run ctest -V -R {test_name} from CMAKE_BINARY_DIR), and submit fixes and other contributions.
 
-Ali
