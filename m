From: Wido den Hollander <wido@widodh.nl>
Subject: higher level library for storing large(r) RADOS objects
Date: Thu, 03 May 2012 08:07:10 +0200
Message-ID: <4FA2208E.5010208@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:41084 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2ECGIG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 02:08:06 -0400
Received: from [192.168.1.61] (74-93-0-217-SFBA.hfc.comcastbusiness.net [74.93.0.217])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPA id B0919763A6
	for <ceph-devel@vger.kernel.org>; Thu,  3 May 2012 08:07:32 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've been talking to Josh today and we've been talking a bit about 
storing large objects in RADOS.

One of the problem I currently see with using RADOS is storing really 
large objects.

RADOS objects are stored on the OSD as a whole file, so potentially a 
single RADOS object could press an OSD over the full_ratio and stalling 
the whole cluster.

This also shows another problem. It this object is heavily used a couple 
of OSDs will be very busy with the I/O's for this object.

So I was thinking about an library on top of RADOS which is kind of 
similar to RBD, but it's only focused on storing objects.

The first object in a pool could have a couple of xattrs:

object1
- stripe_size: 4096
- size: 40960

Based on the xattr operation we know where to read or write when asked 
for a specific offset and length.

object1, object1_1, object1_2, until object1_9

Potentially this could also be used for the RADOS Gateway? Since that 
will suffer from the same problem when you want to scale out.

With the RAODS Gateway you can't control a user storing a 200G tar file 
with his backups in it, you never know.

It's just a thought but I just wanted to get it out there and check out 
the opinions.

Comments? Suggestions?

Wido
