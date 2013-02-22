From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Question on extended attributes
Date: Thu, 21 Feb 2013 17:13:43 -0800 (PST)
Message-ID: <20130221.171343.75467379.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57369 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab3BVBNs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 20:13:48 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so85425pbc.39
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 17:13:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi.

Can we add extended attributes on a file stored in the Ceph
mounted space ? I'm running the Ceph FS using Btrfs.

The setfattr command returns Operation not supported.
Is it not supported ?

regards,
Yasu


