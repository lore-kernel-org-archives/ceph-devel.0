From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: get rid of unused "one shot" event support
Date: Sat, 16 Feb 2013 10:36:40 -0600
Message-ID: <511FB598.50603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:44616 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab3BPQgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:36:43 -0500
Received: by mail-qa0-f50.google.com with SMTP id dx4so735464qab.9
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:36:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The osd client supports a "one shot" event, but nobody ever uses
it.  It probably works right, but it's effectively dead code, so
just get rid of it.  Get rid of ceph_osd_wait_event() as well,
because whatever purpose it served was probably related to
using a one shot event.

					-Alex

[PATCH 1/2] libceph: kill ceph_osdc_create_event() "one_shot"
[PATCH 2/2] libceph: kill ceph_osdc_wait_event()
