From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: rgw_rest.cc build failure
Date: Wed, 10 Oct 2012 14:25:56 -0700
Message-ID: <CAPrxi5-fb2hQeLcgC577JOLxZmMaKT=SYhCxzBwwUEDcxxLBvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52406 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab2JJVZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 17:25:57 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1812826iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 14:25:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This needed for latest master:

diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
index 53bbeca..3612a9e 100644
--- a/src/rgw/rgw_rest.cc
+++ b/src/rgw/rgw_rest.cc
@@ -1,4 +1,5 @@
 #include <errno.h>
+#include <limits.h>

 #include "common/Formatter.h"
 #include "common/utf8.h"

to fix:

  CXX    radosgw-rgw_rest.o
rgw/rgw_rest.cc: In static member function =E2=80=98static int
RESTArgs::get_uint64(req_state*, const string&, uint64_t, uint64_t*,
bool*)=E2=80=99:
rgw/rgw_rest.cc:326:15: error: =E2=80=98ULLONG_MAX=E2=80=99 was not dec=
lared in this scope
rgw/rgw_rest.cc: In static member function =E2=80=98static int
RESTArgs::get_int64(req_state*, const string&, int64_t, int64_t*,
bool*)=E2=80=99:
rgw/rgw_rest.cc:351:15: error: =E2=80=98LLONG_MAX=E2=80=99 was not decl=
ared in this scope

- Noah
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
