From: Michael Sevilla <mikesevilla3@gmail.com>
Subject: Where do MDSHealthMetrics show up?
Date: Thu, 20 Nov 2014 17:54:56 -0800
Message-ID: <CAD=PzHKrzs9Wx-pjONM+nL_eoO8+0crr-_K1iVT_PrMJJdr5bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:52336 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbaKUBy6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 20:54:58 -0500
Received: by mail-la0-f51.google.com with SMTP id mc6so3440276lab.24
        for <ceph-devel@vger.kernel.org>; Thu, 20 Nov 2014 17:54:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi. Where do the MDSHealthMetrics in MMDSBeacon (e.g.,
MDS_HEALTH_TRIM) show up in the monitors? When we run ceph -s? I
suspect I don't see them because I'd have to run ceph -s at the exact
moment when the MDS is trimming. Is there an easier way to see these
warning or is there some debug flag I need to turn on?

Thanks!
Michael
