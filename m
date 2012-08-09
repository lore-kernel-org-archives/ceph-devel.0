From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 9 Aug 2012 09:53:03 -0700
Message-ID: <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com> <5023E96E.30209@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38503 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab2HIQxY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 12:53:24 -0400
Received: by vcbfk26 with SMTP id fk26so580356vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 09:53:23 -0700 (PDT)
In-Reply-To: <5023E96E.30209@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Thu, Aug 9, 2012 at 9:46 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> I'm embarrassed to admit I haven't been keeping up with this,
> but I seem to recall that early versions didn't handle a
> journal on a partition.  Did I get that wrong, or maybe that
> capability exists now?  In the past I've found it to have a
> small performance benefit, and would hate to lose it.

It's still not quite ready for prime time. Journal placement was cut
out to allow us to focus on the distributed aspects of it first; those
are now working pretty well. Putting much effort on the alternative is
probably not a good bet.

This ticket needs to get fixed (and defined better, first!) to have
more flexibility with journals:
http://tracker.newdream.net/issues/2398
