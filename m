From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling
 more flexible
Date: Thu, 9 Aug 2012 10:46:38 -0600
Message-ID: <5023E96E.30209@sandia.gov>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:49519 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2HIQrK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 12:47:10 -0400
In-Reply-To: <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On 08/09/2012 10:26 AM, Tommi Virtanen wrote:
> mkcephfs is not a viable route forward. For example, it is unable to
> expand a pre-existing cluster.
>
> The new "OSD hotplugging" style init is much, much nicer. And does
> more than just mkfs&  mount.

I'm embarrassed to admit I haven't been keeping up with this,
but I seem to recall that early versions didn't handle a
journal on a partition.  Did I get that wrong, or maybe that
capability exists now?  In the past I've found it to have a
small performance benefit, and would hate to lose it.

Thanks -- Jim

