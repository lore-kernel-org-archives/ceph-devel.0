From: =?UTF-8?B?UGF3ZcWCIFNhZG93c2tp?= <ceph@sadziu.pl>
Subject: Ceph data consistency
Date: Tue, 30 Dec 2014 09:21:49 +0100
Message-ID: <54A2609D.1010302@sadziu.pl>
Reply-To: ceph@sadziu.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mojave.sadziu.pl ([192.30.35.41]:41334 "EHLO mail.sadziu.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752047AbaL3I7X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Dec 2014 03:59:23 -0500
Received: from mail.sadziu.pl ([192.168.54.2])
	by mail.sadziu.pl with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <ceph@sadziu.pl>)
	id 1Y5s40-0000hI-BO
	for ceph-devel@vger.kernel.org; Tue, 30 Dec 2014 09:22:00 +0100
Received: from mysql.sadziu.pl ([192.168.54.2] helo=[127.0.0.1])
	by mail.sadziu.pl with esmtpsa (TLS1.0:ECDHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.84)
	(envelope-from <ceph@sadziu.pl>)
	id 1Y5s3t-0005sC-2P
	for ceph-devel@vger.kernel.org; Tue, 30 Dec 2014 09:21:58 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

On our Ceph cluster from time to time we have some inconsistent PGs
(after deep-scrub). We have some issues with disk/sata cables/lsi
controller causing IO errors from time to time (but that's not the point
in this case).

When IO error occurs on OSD journal partition everything works as is
should -> OSD is crashed and that's ok - Ceph will handle that.

But when IO error occurs on OSD data partition during journal flush OSD
continue to work. After calling *writev* (in buffer::list::write_fd) OSD
does check return code from this call but does NOT verify if write has
been successful to disk (data are still only in memory and there is no
fsync). That way OSD thinks that data has been stored on disk but it
might be discarded (during sync dirty page will be reclaimed and you'll
see "lost page write due to I/O error" in dmesg).

Since there is no checksumming of data I just wanted to make sure that
this is by design. Maybe there is a way to tell OSD to call fsync after
write and have data consistent?


-- 
Cheers,
PS
