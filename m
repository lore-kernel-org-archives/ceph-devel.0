From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: simplify rbd_do_op() et al
Date: Wed, 10 Oct 2012 19:17:56 -0700
Message-ID: <50762C54.40101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64760 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964986Ab2JKCSA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 22:18:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1337464pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 19:18:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These three patches simplify a few paths through the code
involving read and write requests.

					-Alex

[PATCH 1/3] rbd: kill rbd_req_{read,write}()
[PATCH 2/3] rbd: kill drop rbd_do_op() opcode and flags
[PATCH 3/3] rbd: consolidate rbd_do_op() calls
