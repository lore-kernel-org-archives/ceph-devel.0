From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Implication of using rados_ioctx_locator_set_key
Date: Tue, 28 Feb 2012 10:07:02 -0800
Message-ID: <8CC04085-3786-4230-8793-0D9097F261F0@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:33192 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2B1SHF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 13:07:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Adam Manzanares <nmtadam@gmail.com>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

I'm curious about what performance implications there may be when using rados_ioctx_locator_set_key.

If a large number of objects are forced into a single PG using a fixed locator key, are there performance implications for subsequent look-ups by object name? Is some type of index structure used under the hood since the PG isn't chosen using locator_key = object_name?

-Noah