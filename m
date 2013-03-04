From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] ceph: assign message data fields consistently
Date: Mon, 04 Mar 2013 12:14:04 -0600
Message-ID: <5134E46C.9020402@inktank.com>
References: <5134E25E.4030701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:37436 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab3CDSOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:14:05 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so5162661iaf.28
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:14:05 -0800 (PST)
In-Reply-To: <5134E25E.4030701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rearrange code so all the fields related to message data get
assigned the same way throughout the ceph code.

					-Alex

[PATCH 1/3] ceph: use calc_pages_for() in start_read()
[PATCH 2/3] ceph: simplify ceph_sync_write() page_align calculation
[PATCH 3/3] libceph: don't assign page info in ceph_osdc_new_request()
