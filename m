From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 13:39:11 -0800
Message-ID: <89CFC754-4DC1-457F-8559-D2C50C302025@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu> <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu> <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:42011 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0K3VjM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 16:39:12 -0500
In-Reply-To: <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> Yeah, not pretty.  A shared library wouldn't really help here either, 
> right?  And a command-line tool means additional overhead.  JNI (or 
> equivalent) calling an ioctl seems like the most appropriate tool.

Not to continually dog on JNI, but I'd like to point out another downside, and that is portability. Using JNI to connect to the IOCTL requires that the JNI-based Java code be build on all platforms. As a result, each per-node deployment of Hadoop must ensure it's version of the JNI connector was built for that particular architecture. I'm wondering how this will affect Hadoop over Ceph in terms of a sales pitch, given that it could require a configuration headache for large-scale deployments.

Thanks,
Noah