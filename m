From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: focus calc_layout() on filling in the osd op
Date: Mon, 25 Feb 2013 17:09:26 -0600
Message-ID: <512BEF26.3030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62867 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab3BYXJa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:09:30 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so3785000iec.4
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:09:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series refactors the code involved with identifying the
details of the name, offset, and length of an object involved
with an osd request based on a file layout.  It makes the focus
of calc_layout() be filling in an osd op structure based on the
file layout it is provided.  The caller (ceph_osdc_new_request())
is then responsible for filling in fields related to the request,
such as the name of the target object.

					-Alex

[PATCH 1/3] libceph: pass object number back to calc_layout() caller
[PATCH 2/3] libceph: format target object name in caller
[PATCH 3/3] libceph: don't pass request to calc_layout()
