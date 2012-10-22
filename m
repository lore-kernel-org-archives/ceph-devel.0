From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: two bugs
Date: Mon, 22 Oct 2012 11:43:34 -0500
Message-ID: <508577B6.2020708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62555 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2JVQnh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:43:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3897292iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:43:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series fixes two bugs, one that affects rbd format 2
images only, and one that fixes an inadvertent change in
an earlier commit.

					-Alex

[PATCH 1/2] rbd: zero return code in rbd_dev_image_id()
[PATCH 2/2] rbd: fix read-only option name
