From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: ceph_setattr mask
Date: Mon, 13 Feb 2012 16:05:45 -0800
Message-ID: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:48874 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2BNAFq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 19:05:46 -0500
Received: from [192.168.50.124] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id B78B67744003
	for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2012 16:05:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Howdy,

It looks like ceph_fs.h contains the mask flags (e.g. CEPH_SETATTR_MODE) used in ceph_setattr, but I do not see these flags in any header installed from .deb files (grep /usr/include/*).

Am I missing a location? Should these flags be part of the installed headers?

Thanks,
-Noah