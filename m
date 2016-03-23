From: "wido@42on.com" <wido@42on.com>
Subject: Refuse OSD removal if still up or acting for PG
Date: Wed, 23 Mar 2016 22:46:15 +0100
Message-ID: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45456 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcCWVqV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 17:46:21 -0400
Received: from ox03.mail.pcextreme.nl (unknown [109.72.87.159])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 3EF5F76302
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 22:46:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

This week I got a call to recover a Ceph cluster where somebody ran 'ceph osd rm X' for OSDs which were still holding PGs.

He removed multiple OSDs and together they were all the replicas forma certain PG.

This raised the question: Should we refuse a rm for a OSD which is still up or acting for a PG?

If not, what would the use-case be for removing a OSD from the OSDMap when it is still up or acting?

I would say that recovery/backfill has to be finished before we allow an OSD to be removed.

Wido
