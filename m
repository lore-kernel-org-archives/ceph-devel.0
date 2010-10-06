From: Leander Yu <leander.yu@gmail.com>
Subject: No space left while there are still available disk space
Date: Wed, 6 Oct 2010 12:40:07 +0800
Message-ID: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48914 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0JFEkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 00:40:09 -0400
Received: by wyb28 with SMTP id 28so6818377wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 21:40:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Hi,
I just found my ceph cluster report no space left error. I check the
df and every osd disk. it still has space available and after delete
some file, I still can't write any data to the file system.
Any suggestion for trouble shooting this case?

Regards,
Leander Yu.
