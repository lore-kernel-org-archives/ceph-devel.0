From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: reproductible kernel oops with kernel 3.2 inside kvm
Date: Thu, 17 May 2012 15:21:55 -0700
Message-ID: <4FB57A03.70309@inktank.com>
References: <4FA290C1.9080808@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47281 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967208Ab2EQWV6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 18:21:58 -0400
Received: by dady13 with SMTP id y13so2993615dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 15:21:57 -0700 (PDT)
In-Reply-To: <4FA290C1.9080808@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Yann,

Sorry for the late response.

On 05/03/2012 07:05 AM, Yann Dupont wrote:
> Hello. I'm stress testing ceph since some time now, with quite good
> results. I really like ceph and will probably use in in some
> pre-production services.
>
> Anyway I've seen some bugs.
>
> One of them is instability if the kernel is running inside KVM, leading
> to a very fast (and reproductible) kernel oops. On bare metal this
> particular oops doesn't happen.
>
> The kernel oops itself involve ceph, but it could be a real bug in kvm too.
>
> The host machine is runnning 3.2.2
> kvm is quite ancien (0.14)
> guest OS is ubuntu 12.04 with his standard kernel. Retried with custom
> 3.2 kernel with the same problem.

I'm not sure how many people are using the kernel client within kvm,
but I haven't seen this problem before. Since it's in d_prune, it's
probably Ceph related, but perhaps kvm makes a race condition trigger
more often in your environment.

I filed http://tracker.newdream.net/issues/2444 to track this.
