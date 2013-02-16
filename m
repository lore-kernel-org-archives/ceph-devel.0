From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: get rid of some unneeded function parameters
Date: Sat, 16 Feb 2013 10:30:01 -0600
Message-ID: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:34431 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3BPQaE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:30:04 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so734608qah.11
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:30:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series eliminates some unneeded parameters from functions
in the osd client.

					-Alex

[PATCH 1/4] ceph: kill ceph_osdc_writepages() "nofail" parameter
[PATCH 2/4] ceph: kill ceph_osdc_writepages() "dosync" parameter
[PATCH 3/4] ceph: kill ceph_osdc_writepages() "flags" parameter
[PATCH 4/4] ceph: kill ceph_osdc_new_request() "num_reply"
