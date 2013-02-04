From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 14:50:38 -0800 (PST)
Message-ID: <20130204.145038.210467743.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57329 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3BDWuq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 17:50:46 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj3so2455809pad.20
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 14:50:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

I happened to have an incorrect crush map in the start-up of
my system, but even after fixing it manually, the PGs do not
seem to be created properly. Is there any way to trigger the
system to start creating the PGs again ?

Here's my configurations:
ceph.conf: http://pastebin.com/EwwdQrf9
crush map: http://pastebin.com/UYNFvvQx
ceph osd tree: http://pastebin.com/u2Z4Hppn
ceph pg dump: http://pastebin.com/JfE146WJ

FYI, in the first, I had mistakenly osd.0 in all host clauses.

regards,
Yasu

