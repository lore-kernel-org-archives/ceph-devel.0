From: Gary Lowell <gary.lowell@inktank.com>
Subject: v0.55 update
Date: Tue, 4 Dec 2012 16:13:30 -0800
Message-ID: <BA25D90D-9E1B-4418-9D97-8B7EA39D4A1E@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51518 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab2LEANe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 19:13:34 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3133978pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 16:13:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi -

The debian-testing repository for v0.55 has been fixed. 

The issue was that we've added a new all arch package, and didn't handle it being built on both amd64 and i386.  The reprepro command got a checksum error and didn't complete building the index.

Cheers,
Gary