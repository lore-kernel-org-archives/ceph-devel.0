From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: MDS running at 100% CPU, no clients
Date: Wed, 6 Mar 2013 17:57:06 -0800
Message-ID: <42F276A0-444F-4300-866D-4CDEE569D398@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39405 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3CGB5E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 20:57:04 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so36168pad.38
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 17:57:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The MDS process in my cluster is running at 100% CPU. In fact I thought the cluster came down, but rather an ls was taking a minute. There aren't any clients active. I've left the process running in case there is any probing you'd like to do on it:

virt   res          cpu
4629m  88m 5260 S   92  1.1 113:32.79 ceph-mds

Thanks,
Noah

