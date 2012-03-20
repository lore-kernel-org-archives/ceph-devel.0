From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph mon crash
Date: Mon, 19 Mar 2012 17:19:41 -0700
Message-ID: <A542F36937A84D5D9450188A02E47FC7@dreamhost.com>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
 <CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
 <CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
 <66BEE4F342554A54BA21F31CB051E2C4@dreamhost.com>
 <CAHULbCkQ-vzDgHHZtSLNGgZFLAODphUTjFJfmK5y+SnveJqfYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38872 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab2CTATo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 20:19:44 -0400
Received: by yhmm54 with SMTP id m54so6020059yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 17:19:44 -0700 (PDT)
In-Reply-To: <CAHULbCkQ-vzDgHHZtSLNGgZFLAODphUTjFJfmK5y+SnveJqfYg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Monday, March 19, 2012 at 11:44 AM, ruslan usifov wrote:
> Sorry but no, i use precompiled binaries from this
> http://ceph.newdream.net/debian. Perhaps this helps, initialy i
> configure all ceph services mon, mds, osd, but then i test only rdb
> and remove all mds from cluster (3 vmware machines) throw follow
> command:
> 
> ceph mds rm 1 (i write this lines by memory so can mistaken in syntax)

Oh. That's a fun command! Where on earth did you find it documented?
Unfortunately, it's only supposed to be used "when things get weird." (And really, I'm not sure when it would be appropriate.) If you run it on a healthy cluster, it will break things.
I created a bug to make it not do that: http://tracker.newdream.net/issues/2188

If necessary I can figure out how to create a good MDSMap and inject it into your monitors, but I'd rather not if you don't have any data in there. (In which case, reformat the cluster.)
-Greg

