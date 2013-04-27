From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: avoid snapshot update race
Date: Sat, 27 Apr 2013 14:37:56 -0500
Message-ID: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55742 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3D0Th6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:37:58 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6100622iea.18
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:37:58 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm9305687igv.1.2013.04.27.12.37.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:37:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series ends with a patch that avoids a race involving the
initial read of an rbd image header and a change to the snapshot
context.  The problem occurs because the rbd client sets up its
watch request on the header object *after* the initial header
read, and if the snapshot context changes between them the
kernel client snapshot context will not be up-to-date.

The fix is to set up the watch before doing the initial
header read.  The recent patches, along with the patches
in this series, make doing things in this order possible.

					-Alex

[PATCH 1/5] rbd: move more initialization into rbd_dev_probe_image()
[PATCH 2/5] rbd: define rbd_header_name()
[PATCH 3/5] rbd: don't clean up watch in device release function
[PATCH 4/5] rbd: don't bother checking whether order changes
[PATCH 5/5] rbd: set up watch in rbd_dev_probe_image()
