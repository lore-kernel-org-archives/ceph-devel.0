From: Steve Taylor <steveftaylor@gmail.com>
Subject: Librbd licensing
Date: Fri, 30 May 2014 17:29:35 +0000 (UTC)
Message-ID: <loom.20140530T192820-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54219 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbaE3RfG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 May 2014 13:35:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1WqQhs-00079k-0H
	for ceph-devel@vger.kernel.org; Fri, 30 May 2014 19:35:04 +0200
Received: from 216.51.73.42 ([216.51.73.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 19:35:04 +0200
Received: from steveftaylor by 216.51.73.42 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 19:35:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am working with a company that wants to utilize librbd in a project to
interact with Ceph storage. For the purposes of this integration,
LGPL-licensed open source code is acceptable, but GPL-licensed code is not.
Well, at least not without other changes to the project, which can be
accomplished if necessary.

The COPYING file distributed with the Ceph source code seems to indicate
that librbd would fall under LGPL 2.1, but some of the source files in
librbd reference GPL 2.1 in their copyright headers.

From what I have found so far, it appears to me that the sources in
question were probably originally LGPL, but were switched to GPL a few
years back to comply with FUSE licensing, which is GPL. Is my understanding
correct that these librbd source files are now GPL? If so and FUSE is the
reason behind it, is it possible to dual-license those files so they could
be LGPL when not used with FUSE?

I just want to make sure I understand the licensing properly. I apologize
if this has been discussed previously. I am new to the list and can't seem
to get the archive search feature to work.

Steve

