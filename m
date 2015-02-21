From: Mark Nelson <mnelson@redhat.com>
Subject: Re: -fno-omit-frame-pointer
Date: Sat, 21 Feb 2015 17:27:05 -0600
Message-ID: <54E91449.4090000@redhat.com>
References: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbbBUX1I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Feb 2015 18:27:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1LNR8i9008555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2015 18:27:08 -0500
In-Reply-To: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 02/21/2015 03:43 PM, Sage Weil wrote:
> Hey Mark,
>
> I just watched Brendan Gregg's talk at SCALE (which was extremely good)
> and one of the things he mentioned is the importance of
> -fno-omit-frame-pointer.  I notice we are setting it via do_autogen.sh
> (i.e., for developers) but not in the production builds.  Should we be?
> I think it's important to be able to get meaningful callgraph output from
> production deployments and I suspect there is minimal performance impact.
>
> http://www.slideshare.net/brendangregg/scale2015-linux-perfprofiling
>
> sage
>

Ah, Brendan Gregg is quite good.  He moved over to the Linux world when 
he went to work for Netflix after being a Solaris guy forever at Joyent. 
  He's probably one of the most knowledgeable people in the world 
regarding dtrace and in a short time has become very good with perf as 
well.  He wrote a very nice perf cheat sheet here:

http://www.brendangregg.com/perf.html

I didn't realize our production builds skip -fno-omit-frame-pointer.  I 
swear we looked at that like 2 years ago and enabled it to try and make 
perf show symbols properly.  Maybe I'm misremembering.  The performance 
impact discussion is interesting.  I've seen some people say up to 20% 
with GCC but others say it really doesn't matter.  I'd be curious to 
hear what people's opinions these days are.

I've still had the best luck using DWARF though.  I was able to get much 
better stack traces with it.  A semi-modern kernel with libunwind 
support in perf is needed though.  I just checked one of our RHEL7 and 
it sadly doesn't look like they have it linked.  We really should hassle 
them to get this in.  Perf on our Ubuntu 14.04 does use libunwind, 
primarily due to the kernel bug we submitted:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1248289

Mark
