From: Gary Lowell <gary.lowell@inktank.com>
Subject: Question about building on SLES 11SP2
Date: Fri, 16 Nov 2012 12:36:33 -0800
Message-ID: <9ADD3B57-61D6-4DF7-83BB-185BC62B2499@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37200 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2KPUgh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 15:36:37 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1288091dak.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 12:36:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hmacht@suse.de
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi -

We are setting up an in-house build machine on SLES 11SP2.   I've run into a couple issues compiling the latest ceph release.   I suspect the root problem is that we need more up to date Boost libraries.  The latest I can find for SLES are version 1.36.

So I am wondering how other folks have solved this problem.  Are more recent libraries compiled for SLES 11SP2 available somewhere ?

Thanks,
Gary