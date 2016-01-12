From: Erwan Velu <evelu@redhat.com>
Subject: About ceph_clock_now()
Date: Tue, 12 Jan 2016 10:59:53 -0500 (EST)
Message-ID: <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:52762 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761547AbcALP7y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 10:59:54 -0500
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0CFxrCZ006201
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jan 2016 10:59:53 -0500
In-Reply-To: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

When reading the code I noticed that ceph_clock_now() is mostly used to compute a local difference of time.
I do see you are using "clock_gettime(CLOCK_REALTIME, &tp)" but was wondering if CLOCK_MONOTONIC_RAW isn't more accurate.

I mean if the local system time is readujsted by NTP (or similar) some computation could be wrong leading to some possible mis-interpretation or wrong scheduling.

Any thoughts on that ?

I could work on a PR is you find this interesting.

Cheers,
Erwan
