From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph fixes
Date: Tue, 26 Jun 2012 14:45:26 -0700
Message-ID: <4FEA2D76.8080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58465 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab2FZVp2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 17:45:28 -0400
Received: by pbbrp8 with SMTP id rp8so630607pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 14:45:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

These two patches from Sage fix two problems have arisen
since the  recent changes in the messenger code.  I have
already reviewed them both.

[PATCH 1/2] libceph: set peer name on con_open, not init
[PATCH 2/2] libceph: close socket directly during ceph_con_close()

					-Alex
