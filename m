From: Christopher Kunz <chrislist@de-punkt.de>
Subject: 0.56.6: MDS asserts on restart
Date: Fri, 10 May 2013 15:21:31 +0200
Message-ID: <518CF45B.7010402@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:39415 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab3EJNbP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 09:31:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail-1.de-punkt.de (Postfix) with ESMTP id 194233A393
	for <ceph-devel@vger.kernel.org>; Fri, 10 May 2013 15:21:31 +0200 (CEST)
Received: from mail-1.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-7H09ccOc1N for <ceph-devel@vger.kernel.org>;
	Fri, 10 May 2013 15:21:30 +0200 (CEST)
Received: from Christophers-MacBook-Pro.local (p4FECE7C9.dip0.t-ipconnect.de [79.236.231.201])
	(Authenticated sender: chrislist@de-punkt.de)
	by mail-1.de-punkt.de (Postfix) with ESMTPSA id E72653A387
	for <ceph-devel@vger.kernel.org>; Fri, 10 May 2013 15:21:30 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

after our update to 0.56.6, all MDSes assert and crash on start. This is
not essential for our setup, but still not great. We assume this might
be due to a bug - see the nopaste below for a trace.

http://nopaste.info/aa06c50a2f.html

Regards,

--ck
