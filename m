From: =?ISO-8859-15?Q?Simon_Frerichs_=7C=A0Fremaks_GmbH?=
	<frerichs@fremaks.de>
Subject: librbd: error finding header: (2) No such file or directory
Date: Sat, 01 Dec 2012 03:00:48 +0100
Message-ID: <50B964D0.7000806@fremaks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.fremaks.net ([46.19.89.69]:35728 "EHLO mail.fremaks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab2LACIo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Nov 2012 21:08:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.fremaks.net (Postfix) with ESMTP id A37B139F66
	for <ceph-devel@vger.kernel.org>; Sat,  1 Dec 2012 03:00:59 +0100 (CET)
Received: from mail.fremaks.net ([127.0.0.1])
	by localhost (mail.fremaks.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvR-iRl+LAV1 for <ceph-devel@vger.kernel.org>;
	Sat,  1 Dec 2012 03:00:50 +0100 (CET)
Received: from morpheus-macbookpro.fritz.box (unknown [46.19.88.245])
	by mail.fremaks.net (Postfix) with ESMTPSA id C812939F1C
	for <ceph-devel@vger.kernel.org>; Sat,  1 Dec 2012 03:00:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we war starting to see this error on some images:

-> rbd info kvm1207
error opening image kvm1207: (2) No such file or directory
2012-12-01 02:58:27.556677 7ffd50c60760 -1 librbd: error finding header: 
(2) No such file or directory

Anyway to fix these images?

Best regards,
Simon
