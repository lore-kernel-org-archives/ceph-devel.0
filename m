From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: update osd_req_encode_op()
Date: Sat, 16 Feb 2013 11:00:02 -0600
Message-ID: <511FBB12.6050207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:38943 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3BPRAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:00:06 -0500
Received: by mail-qa0-f41.google.com with SMTP id hy16so733246qab.7
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:00:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series just modifies osd_req_encode_op so it is
more informative, distinguishing between defined but
not supported opcodes and garbage opcodes.

					-Alex

[PATCH 1/2] libceph: report defined but unsupported osd ops
[PATCH 2/2] libceph: remove dead code in osd_req_encode_op()
