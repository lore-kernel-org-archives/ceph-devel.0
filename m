From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: little cleanups
Date: Thu, 01 Nov 2012 08:45:39 -0500
Message-ID: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:45191 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760647Ab2KANpn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:45:43 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1916071iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:45:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These are a handful of fairly minor cleanup items I've
been putting off sending out until some of the meatier
stuff got done.

					-Alex

[PATCH 1/5] rbd: document rbd_spec structure
[PATCH 2/5] rbd: kill rbd_spec->image_name_len
[PATCH 3/5] rbd: kill rbd_spec->image_id_len
[PATCH 4/5] rbd: don't use ENOTSUPP
[PATCH 5/5] rbd: use kmemdup()
