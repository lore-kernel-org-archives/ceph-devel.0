From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: jemalloc and transparent hugepage
Date: Tue, 8 Sep 2015 21:42:35 +0200 (CEST)
Message-ID: <1694547545.35004320.1441741355122.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52440 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbIHTmh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 15:42:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,
I have found an interesting article about jemalloc and transparent hugepages

https://www.digitalocean.com/company/blog/transparent-huge-pages-and-alternative-memory-allocators/


Could be great to see if disable transparent hugepage help to have lower jemalloc memory usage.


Regards,

Alexandre

