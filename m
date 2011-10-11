From: Martin Mailand <martin@tuxadero.com>
Subject: rbd import rbd_writeback_window
Date: Tue, 11 Oct 2011 22:20:12 +0200
Message-ID: <4E94A4FC.4020609@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:44204 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab1JKUU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 16:20:26 -0400
Received: from [192.168.1.106] (e178216139.adsl.alicedsl.de [85.178.216.139])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9BKKDr0012041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 22:20:24 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
is it possible to use the rbd_writeback_window with the rbd command to 
speed up the import?
Something like rbd import /mnt/image_vm1 vm99:rbd_writeback_window=800000

Best Regards,
  Martin
