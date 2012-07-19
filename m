From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Thu, 19 Jul 2012 08:52:41 -0700
Message-ID: <CADvuQRGaivtgho4R=rk3c_B6eJ2GfG=tZFGNy9knoKyh2CR-zg@mail.gmail.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com>
 <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <5007FB6E.1080307@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55184 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab2GSPxC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 11:53:02 -0400
Received: by pbbrp8 with SMTP id rp8so4557590pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 08:53:02 -0700 (PDT)
In-Reply-To: <5007FB6E.1080307@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Jul 19, 2012 at 5:19 AM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> Look like that osd.0 performs with low latency but osd.1 latency is way too
> high and on average it appears as 200ms. osd is backed by btrfs over LVM2.
> May be issue lie in backing fs selection? All four osds running similar

Our typical experience with btrfs right now seems to be that it works
fast when the filesystem is fresh, but as it ages, it starts to have
higher and higher delays on syncing writes. This does not seem to be
completely deterministic, that is, if you run many btrfs'es, the
symptoms start to appear at different times on different instances.
