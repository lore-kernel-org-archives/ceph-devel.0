From: Hannu Valtonen <me@ormod.com>
Subject: Python-rados announcement
Date: Sun, 06 Feb 2011 15:01:07 +0200
Message-ID: <4D4E9B93.2070901@ormod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:39764 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1BFNKG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Feb 2011 08:10:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id D28F019B476
	for <ceph-devel@vger.kernel.org>; Sun,  6 Feb 2011 15:01:07 +0200 (EET)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id tgf8LS2pxfPV for <ceph-devel@vger.kernel.org>;
	Sun,  6 Feb 2011 15:01:07 +0200 (EET)
Received: from FSAPPLE12-2.local (cs181254100.pp.htv.fi [82.181.254.100])
	by smtp4.welho.com (Postfix) with ESMTP id 5C3C35BC005
	for <ceph-devel@vger.kernel.org>; Sun,  6 Feb 2011 15:01:07 +0200 (EET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I wrote a basic Python ctypes librados wrapper:
https://github.com/Ormod/python-rados

It's in very initial stages of development and only supports things like 
write/read/deletes at this stage.

Any patches/bugs/ideas are welcome and can be sent my way.

- Hannu Valtonen
hannu.valtonen@ormod.com
