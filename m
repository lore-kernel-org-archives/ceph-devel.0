From: Daniel Hsueh <dchsueh@alumni.uwaterloo.ca>
Subject: any reason why multiple ranged-reads not currently supported in rados-java?
Date: Fri, 15 Aug 2014 11:33:13 -0400
Message-ID: <CAAmmvixquAW-s5td03UpnEhFDWujAWServHgehKzrYHRs+dsBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50016 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaHOPdO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 11:33:14 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so2568933igi.2
        for <ceph-devel@vger.kernel.org>; Fri, 15 Aug 2014 08:33:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm looking at the Java librados JNA-based API, and note that ranged
reads (rados_create_read_op, rados_release_read_op,
rados_read_op_read, rados_read_op_operate) are not currently
accessible to a Java program.

Are there any difficulties in implementing access to these calls?  If
it is straightforward, I'll implement them myself and contribute back
to the github repository.

Thank you.

-- 
Daniel Hsueh <mailto:dchsueh@alumni.uwaterloo.ca>
