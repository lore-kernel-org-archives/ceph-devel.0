From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: some firefly -std=c++11 changes
Date: Thu, 29 May 2014 11:30:29 -0400 (EDT)
Message-ID: <1529397390.44.1401377429252.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2606 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbaE2Pac (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 May 2014 11:30:32 -0400
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id s4TFUVrB014099
	for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 11:30:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id F243F3FC8499
	for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 11:30:30 -0400 (EDT)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
	by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgA3y+veOFRE for <ceph-devel@vger.kernel.org>;
	Thu, 29 May 2014 11:30:29 -0400 (EDT)
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 6A46B3FC8498
	for <ceph-devel@vger.kernel.org>; Thu, 29 May 2014 11:30:29 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph devs,

I pushed a small set of changes against Firefly to permit building with
-std=std++11 (actually I'm using -std=gnu++11 atm, due to a problem in a
fio header).

If folks are interested:

To https://github.com/linuxbox2/linuxbox-ceph.git
 * [new branch]      firefly-std11 -> firefly-std11

Thanks,

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
