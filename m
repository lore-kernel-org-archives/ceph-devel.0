From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/5] libceph: crush tunables5
Date: Wed,  3 Feb 2016 15:23:16 +0100
Message-ID: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37238 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbcBCOX3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:29 -0500
Received: by mail-wm0-f44.google.com with SMTP id l66so72739815wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Hello,

This series adds support for the new chooseleaf_stable CRUSH tunable
and enables TUNABLES5 feature bit.  It's likely that TUNABLES5 bit will
be shared and cover request_redirect_t encoding in MOSDOpReply and
possibly new file layouts but those aren't in master yet.

Thanks,

                Ilya


Ilya Dryomov (5):
  crush: ensure bucket id is valid before indexing buckets array
  crush: ensure take bucket value is valid
  crush: add chooseleaf_stable tunable
  crush: decode and initialize chooseleaf_stable
  libceph: advertise support for TUNABLES5

 include/linux/ceph/ceph_features.h | 13 ++++++++++++-
 include/linux/crush/crush.h        |  8 +++++++-
 net/ceph/crush/mapper.c            | 33 ++++++++++++++++++++++++++-------
 net/ceph/osdmap.c                  | 19 ++++++++++++++-----
 4 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.4.3

