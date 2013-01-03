From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/2] libceph: embed r_trail struct in ceph_osd_request()
Date: Thu, 03 Jan 2013 17:34:33 -0600
Message-ID: <50E61589.6080900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55693 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab3ACXef (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:34:35 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so19109622iea.12
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:34:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series simplifies some handling of osd client message
handling by using an initialized ceph_pagelist structure
to refer to the trail portion of a ceph_osd_request rather
than using a null pointer to represent "not there".

					-Alex

[PATCH REPOST 1/2] libceph: always allow trail in osd request
[PATCH REPOST 2/2] libceph: kill op_needs_trail()

