From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Errors on compiling master-backport of ceph-client-standalone
Date: Thu, 16 Dec 2010 15:39:09 +0800
Message-ID: <AANLkTinJW=QHXpsq1K_arYW5goARdPV15UTpEi6hYz51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43838 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0LPHjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 02:39:09 -0500
Received: by qyk12 with SMTP id 12so3028970qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Dec 2010 23:39:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Just tried to compile master-backport of ceph-client-standalone and got errors.
I did two modifications to fix the errors:

1. include <linux/smp_lock.h> in ceph/mds_client.c for lock_kernel()
2. Revert commit "convert ceph"
(ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e) because mount operation
does not exist before 2.6.37.

Henry
