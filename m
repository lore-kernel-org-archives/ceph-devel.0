From: =?iso-8859-1?Q?Fran=E7ois?= Charlier
	<francois.charlier@enovance.com>
Subject: Tuning placement group
Date: Fri, 20 Jul 2012 18:33:11 +0200
Message-ID: <20120720163311.GB17454@potjevlesh.enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:34705 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2GTQdP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 12:33:15 -0400
Received: from Satellite-1.enovance.com (94-143-112-83.enovance.net [94.143.112.83])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxi1.enovance.com (Postfix) with ESMTP id 54A8212754
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 18:33:13 +0200 (CEST)
Received: from zimbra.enovance.com (zimbra.enovance.com [10.142.4.4])
	by Satellite-1.enovance.com (Postfix) with ESMTP id 45C6A1B81BC
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 18:33:13 +0200 (CEST)
Received: from localhost (mail-1 [127.0.0.1])
	by zimbra.enovance.com (Postfix) with ESMTP id 3C76E37003F
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 18:33:13 +0200 (CEST)
Received: from zimbra.enovance.com ([127.0.0.1])
	by localhost (zimbra.enovance.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOyt1k0zgpAP for <ceph-devel@vger.kernel.org>;
	Fri, 20 Jul 2012 18:33:12 +0200 (CEST)
Received: from potjevlesh.enovance.com (unknown [10.142.32.73])
	by zimbra.enovance.com (Postfix) with ESMTPSA id 7D13037003E
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 18:33:12 +0200 (CEST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

Reading    http://ceph.com/docs/master/ops/manage/grow/placement-groups/
and thinking to build a ceph cluster with potentially 1000 OSDs.

Using the recommandations on the previously cited link, it would require
pg_num being set between 10,000 &  30,000. Okay with that. Let's use the
recommended value of 16,384 ; this  is alreay about 160 placement groups
per OSD.

What  if, for  a start,  we choose  to reach  this number  of 1000  OSDs
slowly, starting with 100 OSDs ? It's now 1600 placement groups per OSD.

What if  we chose 30,000 (or  32,768) placement groups to  keep room for
expansion ?

My question  is : How will  behave a Ceph  pool with 1000, 5000  or even
10000 placement groups per OSD ?  Will this impact performance ? How bad
? Can it be worked around ? Is this a problem of RAM size ? CPU usage ?

Any hint about this would be much appreciated.

Thanks !
