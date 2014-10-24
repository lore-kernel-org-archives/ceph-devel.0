From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: krbd blk-mq support ?
Date: Fri, 24 Oct 2014 09:54:15 +0200 (CEST)
Message-ID: <7a39f49a-2e11-48d6-90ce-e88dd652f6b9@mailpro>
References: <9894b2d1-b7c6-4a17-9747-d8a41ec208a4@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39765 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaJXHyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Oct 2014 03:54:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id E5F3E1808B4FD
	for <ceph-devel@vger.kernel.org>; Fri, 24 Oct 2014 09:54:21 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOOeZQ3LlSTp for <ceph-devel@vger.kernel.org>;
	Fri, 24 Oct 2014 09:54:15 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id D28EF1808B4E5
	for <ceph-devel@vger.kernel.org>; Fri, 24 Oct 2014 09:54:15 +0200 (CEST)
In-Reply-To: <9894b2d1-b7c6-4a17-9747-d8a41ec208a4@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

Hi,

I would like to known if it's planned to add blk-mq (block multiqueue from kernel 3.17)  support to krbd ?

I think it could help single threaded workload (including qemu) to reach more iops.

I find some small discussion about it here:
http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/20584

But no news since then.

Regards,

Alexandre

