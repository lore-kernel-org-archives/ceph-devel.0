From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 11:09:34 -0800
Message-ID: <114FA4806BC54AAB9A6304BF5CF1A543@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com>
 <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
 <1299867988.4750.394.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
 <1299869475.4750.405.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46377 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab1CKTJi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 14:09:38 -0500
Received: by yia27 with SMTP id 27so1287543yia.19
        for <ceph-devel@vger.kernel.org>; Fri, 11 Mar 2011 11:09:37 -0800 (PST)
In-Reply-To: <1299869475.4750.405.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>


On Friday, March 11, 2011 at 10:51 AM, Jim Schutt wrote:
> I'm also confused. Here's the code I ran:
> 
>  void put() {
>  //generic_dout(0) << "RefCountedObject::put " << this << " " << nref.read() << " -> " << (nref.read() - 1) << dendl;
>  if (nref.dec() == 0) {
>  utime_t s = g_clock.now();
>  delete this;
>  utime_t e = g_clock.now();
>  if (double(e - s) > 0.5) {
>  generic_dout(1) << "RefCountedObject::put delete " << this << " took " << double(e - s) << " secs!" << dendl;
>  }
>  }
>  }
> 
> I added those double casts, because I had a similar problem with my throttler->put
> test: without the casts, it was firing but the reported delay was less than
> 0.25 sec. Adding the casts stopped that - I haven't yet checked into why.
> 
> Still checking for what I'm missing...
> 
> -- Jim

Heh -- it turns out that operator double() is a little bit broken -- it divides by the wrong constant! Pushed the (very simple) fix in 3fb4fd8612b7a05f7d89cfd0b48f765c79830f95 to the stable branch.
This would be putting everything into the wrong order of magnitude. Half second delete issues are a lot more believable (to me at least!) than 5 second ones, and I wouldn't be surprised if they were the fault of the default memory allocator combined with the throttler getting bogged down. (Apparently even tcmalloc will do a better job of memory management if memory is freed from the same thread it's allocated in, and almost none of our memory use is polite in that way.)
-Greg



