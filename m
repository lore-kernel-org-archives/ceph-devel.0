From: Christian Brunner <chb@muc.de>
Subject: additional librados functions
Date: Thu, 13 May 2010 17:34:53 +0200
Message-ID: <20100513153453.GC53373@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:60289 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0EMPe5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 May 2010 11:34:57 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,
Hi Sage,

while thinking about using RBD in our environment I came across two things:

1. I would like to be able to clone an image. This doesn't need to be
   based on a snapshot. Doing a simple copy of the objects would be
   sufficient. I could do this by using rados_read and rados_write easily.
   However I think that calling something like rados_copy would be more
   efficient, since the client wouldn't be involved.  Would it be possible 
   to provide such a call?

2. For accounting purposes I would like to read pool statistics. In the
   librados header file I can see that there are two structures () where
   the data may get stored. However I can't find a function to fill these
   structures. Am I missing something here?

Thanks,
Christian
