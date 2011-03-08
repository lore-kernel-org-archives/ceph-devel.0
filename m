From: H Chang <heracles@gmail.com>
Subject: connection management in ceph
Date: Tue, 8 Mar 2011 10:46:29 -0500
Message-ID: <AANLkTimQsfsBaykOsNyo6H9cMv2LL_GZDNUyuWC6Fitq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51076 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab1CHPq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 10:46:29 -0500
Received: by gyh20 with SMTP id 20so2073930gyh.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Mar 2011 07:46:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have a question on how ceph maintains tcp connections.

As I understand, given a cluster of N osds, ceph client can
potentially read from, and write to all N osds, if crush distributes
data randomly across all.  Then does the client maintains persistent
tcp connections to all osds?

How about tcp connections among osds (for replication)?  Does each osd
maintain persistent tcp connection to all the other osds, essentially
forming a clique?

Thanks,
HS
