From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Just noticed this with ceph-0.43 - ceph-0.39 does not have
 this issue.  I'm trying to use Ceph on multiple platforms, one of
 which is CentOS 5.  CentOS 5 still uses Python 2.4, and
 byte-compilation o
Date: Tue, 20 Mar 2012 15:42:48 -0600
Message-ID: <4F68A57802000099000DD35F@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45796 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab2CTVmx convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Tue, 20 Mar 2012 17:42:53 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2KMcHEb011380
	for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 16:38:20 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 63A7244C58
	for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 15:42:49 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just noticed this with ceph-0.43 - ceph-0.39 does not have this issue.  I'm trying to use Ceph on multiple platforms, one of which is CentOS 5.  CentOS 5 still uses Python 2.4, and byte-compilation of the rados.py file fails during the build of ceph 0.43 with the following error:

Byte-compiling python modules...
rados.py  File "/usr/lib/python2.4/site-packages/rados.py", line 422
    with self.lock:
            ^
SyntaxError: invalid syntax

A quick Google search doesn't turn up anything obviously wrong with this statement - just that Python 2.4 may not support this?  Is there anything that can be done to make this block of code (Ioctx, some of the aio stuff) compatible with Python 2.4?

Thanks - Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
