From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: manage racing opens/removes
Date: Mon, 28 Jan 2013 16:08:18 -0600
Message-ID: <5106F6D2.7040805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38578 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab3A1WIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 17:08:17 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so306270iec.18
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 14:08:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A recent change to rbd prevented rbd devices from being unmapped
when they were in use.  However that change did not address a
different, but related problem.  It is possible for an open (the
one that would bump the open count from 0 to 1) to begin after
a request to remove the rbd device has decided it can proceed.

To fix this, define a new "removing" flag to prevent opens from
proceeding once ermoval of a device has begun.  The first patch
in this series defines a new flags field, and uses it for this
as well as the "exists" flag for snapshot mappings.

					-Alex

[PATCH 1/2] rbd: define flags field, use it for exists flag
[PATCH 2/2] rbd: prevent open for image being removed
