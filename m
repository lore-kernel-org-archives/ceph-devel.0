From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH 0/2] librados: Add RADOS locks to the C/C++ API
Date: Thu, 30 May 2013 16:02:00 +0300
Message-ID: <1369918922-867-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:18848 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755113Ab3E3NSb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 May 2013 09:18:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Filippos Giannakos <philipgian@grnet.gr>, synnefo-devel@googlegroups.com

Hi Team,

The following patches export the RADOS advisory locks functionality to the C/C++
librados API. The extra API calls added are inspired by the relevant functions
of librbd.

Kind Regards,
Filippos

Filippos Giannakos (2):
  Add RADOS lock mechanism to the librados C/C++ API.
  Add RADOS API lock tests

 src/Makefile.am                |   11 +-
 src/include/rados/librados.h   |   95 +++++++++++++++-
 src/include/rados/librados.hpp |   27 +++++
 src/librados/librados.cc       |  187 +++++++++++++++++++++++++++++++
 src/test/librados/lock.cc      |  236 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 554 insertions(+), 2 deletions(-)
 create mode 100644 src/test/librados/lock.cc

--
1.7.10.4

