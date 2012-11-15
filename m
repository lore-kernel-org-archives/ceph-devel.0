From: Dan Mick <dan.mick@inktank.com>
Subject: RFC: incompatible change to rbd tool behavior on copy
Date: Thu, 15 Nov 2012 14:57:02 -0800
Message-ID: <50A5733E.5030408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62311 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2KOW5F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 17:57:05 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1414577pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 14:57:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

A user has noticed some surprising behavior with the rbd command-line 
tool: with rbd copy, if the destination pool is not set (either with 
--dest-pool or by specifying destpool/image), then it is assumed to be 
the source pool name.

This seems to me only marginally convenient, and much more confusing; 
given how easy it is to specify the pool if it matters, and given the 
fact that the default pool is always 'rbd' for all other operations, I 
think it makes much more sense for the destination of a copy to default 
to 'rbd' unless otherwise specified.

I propose to make this change.  Does anyone think it's a bad idea?
