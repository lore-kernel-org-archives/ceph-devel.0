From: Fyodor Ustinov <ufm@ufm.su>
Subject: cfuse vs kernel mount. differences.
Date: Sat, 18 Jun 2011 18:44:36 +0300
Message-ID: <4DFCC7E4.70307@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:52056 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab1FRPoj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 18 Jun 2011 11:44:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 15A7C600485
	for <ceph-devel@vger.kernel.org>; Sat, 18 Jun 2011 18:44:38 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSeufhazb6RR for <ceph-devel@vger.kernel.org>;
	Sat, 18 Jun 2011 18:44:37 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id E6DE5600484
	for <ceph-devel@vger.kernel.org>; Sat, 18 Jun 2011 18:44:37 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

1-st. Mount by kernel:

root@stb1:~# df /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
10.5.51.230:/        51409168384 799601664 49637535744   2% /mnt

2-nd. Mount by cfuse:

root@stb1:~# df /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
cfuse                51409169084 1771587996 49637581088   4% /mnt

Hmm... All different. It's correct? Who should I believe?

kernel 3.0.0-rc3
ceph - 0.29.1

WBR,
     Fyodor.
