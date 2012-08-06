From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: separate reading from interpreting rbd header
Date: Mon, 06 Aug 2012 11:15:45 -0700
Message-ID: <502009D1.7090005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53488 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab2HFSPt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:15:49 -0400
Received: by ggnl2 with SMTP id l2so2799382ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:15:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Right now rbd_read_header() both reads the header object for an rbd
image and decodes its contents.  This series rearranges this a bit so
this process is broken into into two steps--reading of the raw header
data and then separately decoding its contents.

[PATCH 1/4] rbd: rearrange rbd_header_from_disk()
[PATCH 2/4] rbd: return earlier in rbd_header_from_disk()
[PATCH 3/4] rbd: expand rbd_dev_ondisk_valid() checks
[PATCH 4/4] rbd: separate reading header from decoding it

					-Alex

