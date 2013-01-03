From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/2] rbd: standardize some variable names
Date: Thu, 03 Jan 2013 16:37:54 -0600
Message-ID: <50E60842.2040204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63952 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3ACWh5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 17:37:57 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so18736314ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 14:37:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series just makes the names of variables for
certain objects follow a consistent naming convention.

					-Alex

[PATCH REPOST 1/2] rbd: standardize rbd_request variable names
[PATCH REPOST 2/2] rbd: standardize ceph_osd_request variable names
