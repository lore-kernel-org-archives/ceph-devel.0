From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: PG state issue
Date: Thu, 1 Mar 2012 17:43:30 +0800
Message-ID: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35268 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab2CAJnb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 04:43:31 -0500
Received: by wibhm2 with SMTP id hm2so178097wib.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Mar 2012 01:43:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

With version 0.42, I found that the pg's state is not in "degrade" any
more if the number of osds is smaller than that of the replication.
For example, if I create a cluster of one osd with replication 2, all
pgs are in active+clean state. (The pgs were in active+clean+degrade
state in the earlier versions.)

I think it should be a bug in terms of cluster status although it does
not cause any other problems to me so far.

Henry
