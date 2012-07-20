From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Fri, 20 Jul 2012 14:50:37 +0930
Message-ID: <5008EAA5.3000908@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <5007FB6E.1080307@bashkirtsev.com> <CADvuQRGaivtgho4R=rk3c_B6eJ2GfG=tZFGNy9knoKyh2CR-zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:54097 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab2GTFU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 01:20:56 -0400
In-Reply-To: <CADvuQRGaivtgho4R=rk3c_B6eJ2GfG=tZFGNy9knoKyh2CR-zg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 20/07/2012 1:22 AM, Tommi Virtanen wrote:
> On Thu, Jul 19, 2012 at 5:19 AM, Vladimir Bashkirtsev
> <vladimir@bashkirtsev.com> wrote:
>> Look like that osd.0 performs with low latency but osd.1 latency is way too
>> high and on average it appears as 200ms. osd is backed by btrfs over LVM2.
>> May be issue lie in backing fs selection? All four osds running similar
> Our typical experience with btrfs right now seems to be that it works
> fast when the filesystem is fresh, but as it ages, it starts to have
> higher and higher delays on syncing writes. This does not seem to be
> completely deterministic, that is, if you run many btrfs'es, the
> symptoms start to appear at different times on different instances.
I would suspect it as well but all btrfs are relatively fresh as we have 
moved ceph from test bed to a production environment.
