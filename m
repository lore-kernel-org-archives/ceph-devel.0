From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Help with CEPH deployment
Date: Tue, 05 May 2015 09:53:52 +1200
Message-ID: <5547EA70.6010604@catalyst.net.nz>
References: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>	<CAKKTCLXG3nzSQs8V5Qq7ycpbd__-vVHMG3Dma+Mihij4o7kakg@mail.gmail.com>	<5546A1E7.7060208@catalyst.net.nz> <CAKKTCLWxPOan=Z46Kvx9t6pHpvz=eAGHzTOO0EtXO80scM_E3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:36326 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbEDVx5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 17:53:57 -0400
In-Reply-To: <CAKKTCLWxPOan=Z46Kvx9t6pHpvz=eAGHzTOO0EtXO80scM_E3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 05/05/15 04:16, Venkateswara Rao Jujjuri wrote:
> Thanks Mark. I switched to completely different machine and started from
> scratch, things were much smoother this time. Cluster was up in 30 mins.
> I guess purgedata , droplets and and purge is
> Not enough to bring the machine back clean?
> What I was trying on the old machine to reset it.
>

One other thing to check on that machine (rgulistan-wsl11) if you want 
to use it again is that it resolves its own hostname sensibly (it really 
screws up the key creation if a different ip get returned)!

Cheers

Mark
