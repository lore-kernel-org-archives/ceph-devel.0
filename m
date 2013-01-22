From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: a few simple changes
Date: Tue, 22 Jan 2013 15:56:50 -0600
Message-ID: <50FF0B22.5060201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:60113 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3AVV4y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:56:54 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so12564032iec.27
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:56:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm about to post a set of large rbd patches for review.
But before doing so I'm slipping in these three little
patches that are unrelated to that big chunk of work.

					-Alex

[PATCH 1/3] rbd: small changes
[PATCH 2/3] rbd: check for overflow in rbd_get_num_segments()
[PATCH 3/3] rbd: don't retry setting up header watch

