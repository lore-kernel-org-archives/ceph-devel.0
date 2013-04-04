From: Alexey Shvetsov <alexxy@gentoo.org>
Subject: MDS crash on 0.60 after upgrade from 0.58
Date: Thu, 04 Apr 2013 12:27:25 +0400
Message-ID: <dcbb6527421f9a4537782e43dcaf4e47@omrb.pnpi.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from omrb.pnpi.spb.ru ([91.151.181.195]:45790 "EHLO omrb.pnpi.spb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763982Ab3DDIfu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Apr 2013 04:35:50 -0400
Received: from omrb.pnpi.spb.ru (omrb.pnpi.spb.ru [91.151.181.195])
	by omrb.pnpi.spb.ru (Postfix) with ESMTP id F253B649ABE
	for <ceph-devel@vger.kernel.org>; Thu,  4 Apr 2013 12:27:25 +0400 (MSK)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all!

I'm getting mds crash on 0.60 after i upgraded to it from 0.58 release.
MDS log looks like http://bpaste.net/show/88863/
MON log looks like http://bpaste.net/show/88864/

Interesting that if we didnt started osd then mds will not crash

PS configuration consist of 18 osd + 1 mon + 1 mds

-- 
Best Regards,
Alexey 'Alexxy' Shvetsov
Petersburg Nuclear Physics Institute, NRC Kurchatov Institute, 
Gatchina, Russia
Department of Molecular and Radiation Biophysics
Gentoo Team Ru
Gentoo Linux Dev
mailto:alexxyum@gmail.com
mailto:alexxy@gentoo.org
mailto:alexxy@omrb.pnpi.spb.ru
