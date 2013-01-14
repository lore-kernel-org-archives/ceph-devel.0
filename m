From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: prevent open of image being unmapped
Date: Mon, 14 Jan 2013 12:50:02 -0600
Message-ID: <50F4535A.6030601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49427 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab3ANSuH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 13:50:07 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so5600320iea.30
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 10:50:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series protects an open of a mapped rbd image from succeeding
once an unmap of that image is underway.

Note:  Once committed these should be back-ported.

					-Alex

[PATCH 1/2] rbd: define flags field, use it for exists flag
[PATCH 2/2] rbd: prevent open for image being removed
