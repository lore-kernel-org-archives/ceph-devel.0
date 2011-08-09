From: Fyodor Ustinov <ufm@ufm.su>
Subject: cfuse memory leak?
Date: Tue, 09 Aug 2011 19:26:22 +0300
Message-ID: <4E415FAE.3050808@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:46334 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab1HIQ0Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Aug 2011 12:26:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 3FD2C600248
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 19:26:23 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGu4XgPdUIQz for <ceph-devel@vger.kernel.org>;
	Tue,  9 Aug 2011 19:26:23 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 131A2600245
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 19:26:22 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

root@backup-ext:/etc/pure-ftpd/conf# ps v -C cfuse
   PID TTY      STAT   TIME  MAJFL   TRS   DRS   RSS %MEM COMMAND
   916 ?        Sl    86:35  21025  2260 1514931 645632 63.1 
/usr/bin/cfuse -m 10.5.51.230 -r /clients /clients

WBR,
     Fyodor.
