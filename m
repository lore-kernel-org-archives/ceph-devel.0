From: Christopher Kunz <chrislist@de-punkt.de>
Subject: btrfs vulnerable to hash-DoS attack
Date: Thu, 13 Dec 2012 17:26:11 +0100
Message-ID: <50CA01A3.1060607@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-10.de-punkt.de ([93.190.68.161]:60431 "EHLO
	mail-10.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab2LMQfg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 11:35:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-10.de-punkt.de (Postfix) with ESMTP id 3BB393A339
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 17:26:08 +0100 (CET)
Received: from mail-10.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Owa0eLmR6OzA for <ceph-devel@vger.kernel.org>;
	Thu, 13 Dec 2012 17:26:02 +0100 (CET)
Received: from Christophers-MacBook-Pro.local (p4FD0749C.dip.t-dialin.net [79.208.116.156])
	(Authenticated sender: chris@de-punkt.de)
	by mail-10.de-punkt.de (Postfix) with ESMTPSA id 0D31A3A338
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 17:26:01 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

since a couple people here are using btrfs (we, fortunately, are not), I
thought you might be interested in this blog entry:
<http://crypto.junod.info/2012/12/13/hash-dos-and-btrfs/>

Basically, it seems that if you create files with filenames that have
colliding CRC32 hashes, all kind of hell breaks loose.

Definitely an interesting read.

Regards,

--ck
