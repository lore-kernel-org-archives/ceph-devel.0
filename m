From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: rgw: bytes sent/received excludes headers
Date: Tue, 3 Feb 2015 17:40:03 -0800
Message-ID: <622F4407872BA447A16110F65453358C037C20E05608@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu24.fnanic.fujitsu.com ([192.240.6.14]:52146 "EHLO
	fujitsu24.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544AbbBDCZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 21:25:42 -0500
Received: from pps.filterd (fujitsu24 [127.0.0.1])
	by fujitsu24.fnanic.fujitsu.com (8.14.4/8.14.4) with SMTP id t141QiGL022666
	for <ceph-devel@vger.kernel.org>; Tue, 3 Feb 2015 17:40:05 -0800
Received: from fujitsu7i.fnanic.fujitsu.com ([133.164.253.7])
	by fujitsu24.fnanic.fujitsu.com with ESMTP id 1sb65784t1-1
	for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 17:40:05 -0800
Received: from FMSAHC1.fmsa.local (localhost [127.0.0.1])
	by fujitsu7i.fnanic.fujitsu.com (8.13.8/8.13.8) with ESMTP id t141e4X0009764
	for <ceph-devel@vger.kernel.org>; Tue, 3 Feb 2015 17:40:04 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

It is my impression that bytes_sent and bytes_received do not include headers. We got a request from a customer who wants to include them (I know... greedy.) Is there a way to calculate the amount of header information that was transferred?

Thanks,
Paul
