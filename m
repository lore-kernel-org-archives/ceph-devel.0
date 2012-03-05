From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 1/3] java: add Java and C++ source files
Date: Mon, 5 Mar 2012 12:49:54 -0800
Message-ID: <AEAC99B6-B38D-438B-BAA3-D06CD0716676@cs.ucsc.edu>
References: <4F516A75.6020500@cs.ucsc.edu> <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:38315 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757455Ab2CEUty convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 15:49:54 -0500
In-Reply-To: <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mar 5, 2012, at 9:25 AM, Tommi Virtanen wrote:

> On Fri, Mar 2, 2012 at 16:48, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> 
> 
> Simple typo, "omitted".
> 
>> +package net.newdream.ceph.fs;
> 
> I think com.ceph.fs would be a smaller punishment on the programmers
> using this, and we have that domain name.

I took care of these--good timing with the com.ceph.fs rename.


> 
>> diff --git a/src/java/test/CephMountCreateTest.java b/src/java/test/CephMountCreateTest.java
> ...
> 
> So the JUnit tests require a functional ceph cluster to run. Can you
> state that explicitly in the source/docs, please?

Yes, I'll make this clear in the source and docs. Is there currently a mechanism available for testing libcephfs w/o a functional cluster? If so it would probably be feasible to adapt the same techniques to the Java library.

Thanks,
Noah