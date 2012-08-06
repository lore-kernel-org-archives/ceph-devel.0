From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: a few small cleanups
Date: Mon, 06 Aug 2012 11:01:53 -0700
Message-ID: <50200691.3040006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51695 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab2HFSB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:01:56 -0400
Received: by pbbrr13 with SMTP id rr13so2902837pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:01:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a small series of cleanups to rbd code.

     [PATCH 1/3] rbd: make snap_names_len a u64
     [PATCH 2/3] rbd: ensure invalid pointers are made null
     [PATCH 3/e] rbd: use sizeof (object) instead of sizeof (type)

					-Alex
