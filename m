From: Wido den Hollander <wido@widodh.nl>
Subject: EU Ceph.com mirror for Debian/Ubuntu packages
Date: Wed, 25 Jul 2012 10:12:55 +0200
Message-ID: <500FAA87.3000501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57302 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab2GYIM6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 04:12:58 -0400
Received: from [IPv6:2a00:f10:113:0:91c1:71e9:2f21:3d47] (unknown [IPv6:2a00:f10:113:0:91c1:71e9:2f21:3d47])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPA id 1ECB2762F4
	for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 10:12:55 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On a couple of systems I'm using the Debian packages provided on 
Ceph.com, but these packages are hosted on a CA based server.

In the EU that's rather slow, especially when updating multiple servers 
and when downloading the debug packages.

As I'm lazy I don't want to maintain my own mirror with my own build 
packages, I rather use the ones build by Ceph.com

Could we set up a EU mirror like eu.ceph.com or nl.ceph.com?

deb http://eu.ceph.com/debian/ precise main

That could update from the main mirror with rsync every hour.

I could offer some space if needed?

Thanks,

Wido
