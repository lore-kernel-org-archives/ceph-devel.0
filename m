From: Sage Weil <sweil@redhat.com>
Subject: Re: Strange issue with CRUSH
Date: Thu, 9 Jul 2015 15:06:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507091501570.20547@cobra.newdream.net>
References: <CAOWwpMJv4N0BvdEy2Y-WpDqqZ6R=f_5_+2j1dWeVe-Xk1fg1bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbbGIWGC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jul 2015 18:06:02 -0400
In-Reply-To: <CAOWwpMJv4N0BvdEy2Y-WpDqqZ6R=f_5_+2j1dWeVe-Xk1fg1bQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gleb Borisov <borisov.gleb@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 10 Jul 2015, Gleb Borisov wrote:
> Hi Sage,
> 
> Sorry for mailing you in person, I realize that you're quite busy at redhat,
> but I wanted you have a look on an issue with CRUSH map.

No problem. I hope you don't mind I've added ceph-devel to the cc list.

> I've described very first insights here:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2015-July/002897.html
> 
> We are continue our research and found that distribution of PG count by OSD
> is very strange and after digging into CRUSH source code found rjenkins1
> hash function.
> 
> After some testing we realized that rjenkins1's value distribution is
> exponential, and this can cause our disbalance.

Any issue with rjenkins1's hash function is very interesting and 
concerning.  Can you describe your analysis and what you mean by the 
distribution being exponential?

> What do you think about adding additional hashing algorithm to CRUSH? It
> seems that it could improve distribution.

I am definitely open to adding new hash functions, especially if the 
current ones are flawed.  The current hash was created by making ad hoc 
combinations of rjenkins' mix function with various numbers of 
arguments--hardly scientific or methodical.  We did an analysis a couple 
years back and found that it effectively modeled a uniform distribution, 
but if we missed something or were wrong we should definitely correct it!

In any case, the important step is to quantify what is wrong with the 
current hash so that we can ensure any new one is not flawed in the same 
way.

Thanks-
sage


> We have also tried to generate some syntetic crushmaps (another bucket
> types, more OSDs per host, more/less hosts by rack, different cound of
> racks, linear osd ids, random osd ids, etc), but didn't found any
> combination with better distribution of PG across OSD.
> 
> Thanks and one more sorry for bothering you in person.
> --
> Best regards,
> Gleb M Borisov
> 
> 
