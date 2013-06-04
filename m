From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH 0/2 v2] librados: Add RADOS locks to the C/C++ API
Date: Tue,  4 Jun 2013 12:52:06 +0300
Message-ID: <1370339528-26872-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:41102 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415Ab3FDJwz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 05:52:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, synnefo-devel@googlegroups.com, Filippos Giannakos <philipgian@grnet.gr>

Hi team,

This set of patches export the RADOS advisory locking functionality to the C/C++
API.
They have been refactored to incorporate Josh suggestions from his review:
 * Always set tag to "" for exclusive lock
 * Add duration argument to lock_{exclusive, shared}
 * Add lock flags to librados.h
 * Return -EINVAL on client parsing error
 * Remove unneeded std::string convertions
 * Typos/style fixes

Kind Regards,
Filippos

Filippos Giannakos (2):
  Add RADOS lock mechanism to the librados C/C++ API.
  Add RADOS API lock tests

 src/Makefile.am                |   11 +-
 src/include/rados/librados.h   |  102 +++++++++++++-
 src/include/rados/librados.hpp |   29 ++++
 src/librados/librados.cc       |  180 ++++++++++++++++++++++++
 src/test/librados/lock.cc      |  301 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 621 insertions(+), 2 deletions(-)
 create mode 100644 src/test/librados/lock.cc

-- 
1.7.10.4

