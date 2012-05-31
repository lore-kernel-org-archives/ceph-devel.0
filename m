From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 16:58:46 -0700
Message-ID: <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com> <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com> <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <05C460A496DC45689D6578B20D699425@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:58919 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758691Ab2EaX6r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 19:58:47 -0400
In-Reply-To: <05C460A496DC45689D6578B20D699425@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Nam Dang <namd@de.cs.titech.ac.jp>, ceph-devel <ceph-devel@vger.kernel.org>


On May 31, 2012, at 3:39 PM, Greg Farnum wrote:
>> 
>> Nevermind to my last comment. Hmm, I've seen this, but very rarely.
> Noah, do you have any leads on this? Do you think it's a bug in your Java code or in the C/++ libraries?

I _think_ this is because the JVM uses its own threading library, and Ceph assumes pthreads and pthread compatible mutexes--is that assumption about Ceph correct? Hence the error that looks like Mutex::lock(bool) being reference for context during the segfault. To verify this all that is needed is some synchronization added to the Java.

There are only two segfaults that I've ever encountered, one in which the C wrappers are used with an unmounted client, and the error Nam is seeing (although they could be related). I will re-submit an updated patch for the former, which should rule that out as the culprit.

Nam: where are you grabbing the Java patches from? I'll push some updates.


The only other scenario that comes to mind is related to signaling:

The RADOS Java wrappers suffered from an interaction between the JVM and RADOS client signal handlers, in which either the JVM or RADOS would replace the handlers for the other (not sure which order). Anyway, the solution was to link in the JVM libjsig.so signal chaining library. This might be the same thing we are seeing here, but I'm betting it is the first theory I mentioned.

- Noah