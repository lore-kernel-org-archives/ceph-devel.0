From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Fri, 1 Jun 2012 13:44:55 +0900
Message-ID: <CAHwdYF00BLvDHDWHXs2CFuLS9AdA+BVNa0YLKHRf9c56eUFhtg@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <05C460A496DC45689D6578B20D699425@inktank.com>
 <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.nap.gsic.titech.ac.jp ([131.112.222.52]:49845 "EHLO
	mail2.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754844Ab2FAEp2 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Jun 2012 00:45:28 -0400
Received: from 209.85.215.46 (209.85.215.46 [209.85.215.46])
	by mail2.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF00BLvDHDWHXs2CFuLS9AdA+BVNa0YLKHRf9c56eUFhtg@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Fri, 1 Jun 2012 13:45:19 +0900
Received: by lahd3 with SMTP id d3so1263041lah.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 21:45:16 -0700 (PDT)
In-Reply-To: <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I pulled the Java lib from https://github.com/noahdesu/ceph/tree/wip-java-cephfs
However, I use ceph 0.47.1 installed directly from Ubuntu's repository
with apt-get, not the one that I built with the java library. I
assumed that since the java lib is just a wrapper.

>>There are only two segfaults that I've ever encountered, one in which the C wrappers are used with an unmounted client, and the error Nam is seeing (although they
>> could be related). I will re-submit an updated patch for the former, which should rule that out as the culprit.

No, this occurs when I call mount(null) with the monitor being taken
down. The library should throw an Exception instead, but since SIGSEGV
originates from libcephfs.so so I guess it's more related to Ceph's
internal code.

Best regards,

Nam Dang
Tokyo Institute of Technology
Tokyo, Japan


On Fri, Jun 1, 2012 at 8:58 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>
> On May 31, 2012, at 3:39 PM, Greg Farnum wrote:
>>>
>>> Nevermind to my last comment. Hmm, I've seen this, but very rarely.
>> Noah, do you have any leads on this? Do you think it's a bug in your Java code or in the C/++ libraries?
>
> I _think_ this is because the JVM uses its own threading library, and Ceph assumes pthreads and pthread compatible mutexes--is that assumption about Ceph correct? Hence the error that looks like Mutex::lock(bool) being reference for context during the segfault. To verify this all that is needed is some synchronization added to the Java.
>
> There are only two segfaults that I've ever encountered, one in which the C wrappers are used with an unmounted client, and the error Nam is seeing (although they could be related). I will re-submit an updated patch for the former, which should rule that out as the culprit.
>
> Nam: where are you grabbing the Java patches from? I'll push some updates.
>
>
> The only other scenario that comes to mind is related to signaling:
>
> The RADOS Java wrappers suffered from an interaction between the JVM and RADOS client signal handlers, in which either the JVM or RADOS would replace the handlers for the other (not sure which order). Anyway, the solution was to link in the JVM libjsig.so signal chaining library. This might be the same thing we are seeing here, but I'm betting it is the first theory I mentioned.
>
> - Noah
