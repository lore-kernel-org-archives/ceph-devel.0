From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: rgw: sticky user quota data on bucket removal
Date: Wed, 23 Dec 2015 15:53:17 -0800
Message-ID: <622F4407872BA447A16110F65453358C04D1467F323A@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu25.fnanic.fujitsu.com ([192.240.6.15]:60452 "EHLO
	fujitsu25.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051AbbLWXxV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Dec 2015 18:53:21 -0500
Received: from pps.filterd (fujitsu25.fnanic.fujitsu.com [127.0.0.1])
	by fujitsu25.fnanic.fujitsu.com (8.15.0.59/8.15.0.59) with SMTP id tBNNVKiY018636
	for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 15:33:26 -0800
Received: from fujitsuii.fna.fujitsu.com ([133.164.253.2])
	by fujitsu25.fnanic.fujitsu.com with ESMTP id 1yw63cj3pw-1
	for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 15:33:25 -0800
Received: from FMSAHC1.fmsa.local (localhost [127.0.0.1])
	by fujitsuii.fna.fujitsu.com (8.13.8/8.13.8) with ESMTP id tBNNrJN7009496
	for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 15:53:19 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We're testing user quotas on Hammer with civetweb and we're running into an issue with user stats.

If the user/admin removes a bucket using -force/-purge-objects options with s3cmd/radosgw-admin respectively, the user stats will continue to reflect the deleted objects for quota purposes, and there seems to be no way to reset them. It appears that user stats need to be sync'ed prior to bucket removal. Setting " rgw user quota bucket sync interval = 0" appears to solve the problem.

What is the downside to setting the interval to 0?

I think the right solution is to have an implied sync-stats during bucket removal. Other suggestions?

All the best,
Paul
