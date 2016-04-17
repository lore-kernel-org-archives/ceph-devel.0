From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Some testprograms are no longer runable from CLI???
Date: Sun, 17 Apr 2016 21:52:29 +0200
Message-ID: <5713E97D.20609@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:36111 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbcDQVLt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Apr 2016 17:11:49 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 408211534C9
	for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2016 21:52:32 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:f05a:ef4:cd36:b28] (unknown [IPv6:2001:4cb8:3:1:f05a:ef4:cd36:b28])
	by smtp.digiware.nl (Postfix) with ESMTP id 70CC11534C7
	for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2016 21:52:30 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

As far as Ik can tell this is due to:
https://github.com/ceph/ceph/commit/1c8cd003600953ee1f469fc91be1b0cc4b4f7fa7

Author: Ali Maredia <amaredia@redhat.com>
Date:   Wed Jan 13 14:40:22 2016 -0500

     cmake: erasure-code tests passing

     Replaced relative paths in test-erausure-eio.sh
     test-erasure-code.sh, and replaced .libs in
     erasure_code unittests with CEPH_VAR environment
     variables set in cmake.

     Signed-off-by: Ali Maredia <amaredia@redhat.com>

=============

Lots of scripts now contain the header:
source $CEPH_ROOT/qa/workunits/ceph-helpers.sh

Which was uptill this commit not required to be set.

As far as I can tell other "required" Shell varaibles might be:

../cmake/modules/AddCephTest.cmake:    CEPH_ROOT=${CMAKE_SOURCE_DIR}
../cmake/modules/AddCephTest.cmake: 
CEPH_BIN=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
../cmake/modules/AddCephTest.cmake: 
CEPH_LIB=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
../cmake/modules/AddCephTest.cmake:    CEPH_BUILD_DIR=${CMAKE_BINARY_DIR}

It would be nice that if these variables are not set, it is still 
possible to
run the tests from the commandline due to setting defaults to values 
that it had
before these Cmake changes were introducded.

Something like
====
C_ROOT=${CEPH_ROOT:-.}
source $CEPH_ROOT/qa/workunits/ceph-helpers.sh
====
would help quite a bit, and keep things backwards compatible.

Thanx,
--WjW


