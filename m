From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: a few picky changes
Date: Thu, 08 Nov 2012 08:06:59 -0600
Message-ID: <509BBC83.1020203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59773 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab2KHOG7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 09:06:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4176310iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 06:06:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

These three changes are pretty trivial.	-Alex

[PATCH 1/3] rbd: standardize rbd_request variable names
[PATCH 2/3] rbd: standardize ceph_osd_request variable names
[PATCH 3/3] rbd: be picky about osd request status type
