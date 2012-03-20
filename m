From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: Ceph mon crash
Date: Tue, 20 Mar 2012 12:02:36 +0400
Message-ID: <CAHULbCk3nktgUEWuQURc2mBs7cOOKWPir8msVcQpF4wM_TTYtA@mail.gmail.com>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
	<CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
	<CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
	<66BEE4F342554A54BA21F31CB051E2C4@dreamhost.com>
	<CAHULbCkQ-vzDgHHZtSLNGgZFLAODphUTjFJfmK5y+SnveJqfYg@mail.gmail.com>
	<A542F36937A84D5D9450188A02E47FC7@dreamhost.com>
	<CAHULbCmyc+OtJd72JJDCKE_gH=2v+SLDMjYTpZQmtRqzYCw9vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50293 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab2CTICh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 04:02:37 -0400
Received: by yhmm54 with SMTP id m54so6113133yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 01:02:36 -0700 (PDT)
In-Reply-To: <CAHULbCmyc+OtJd72JJDCKE_gH=2v+SLDMjYTpZQmtRqzYCw9vA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2012/3/20 Greg Farnum <gregory.farnum@dreamhost.com>:
> On Monday, March 19, 2012 at 11:44 AM, ruslan usifov wrote:
>> Sorry but no, i use precompiled binaries from this
>> http://ceph.newdream.net/debian. Perhaps this helps, initialy i
>> configure all ceph services mon, mds, osd, but then i test only rdb
>> and remove all mds from cluster (3 vmware machines) throw follow
>> command:
>>
>> ceph mds rm 1 (i write this lines by memory so can mistaken in syntax)
>
> Oh. That's a fun command! Where on earth did you find it documented?
> Unfortunately, it's only supposed to be used "when things get weird." (And really, I'm not sure when it would be appropriate.) If you run it on a healthy cluster, it will break things.
> I created a bug to make it not do that: http://tracker.newdream.net/issues/2188
>

I found it in source. I want to liquidate of war messages which appear
when i monitor cluster with follow:

ceph -w

There was messages that i have one down mds (actually i doesn't have any)


> If necessary I can figure out how to create a good MDSMap and inject it into your monitors, but I'd rather not if you don't have any data in there. (In which case, reformat the cluster.)


This is a test environment, so i reformat cluster map manually. Also i
must say that mons die not immediately when i run (ceph mds rm 1), but
after some time
