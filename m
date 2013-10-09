From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: OpenStack and ceph integration with puppet
Date: Wed, 9 Oct 2013 16:58:38 -0700
Message-ID: <CAM0pNLMibwuWzc=E_PVj+0PzFjbjnkOX6xy3R0N-gbHMf0NGOA@mail.gmail.com>
References: <525413DE.9090405@dachary.org>
	<etPan.52541b01.d34b6a8.167b7@leseb-mba.local>
	<525448E7.5040604@dachary.org>
	<CAM0pNLPi_un=2EQ+V+Lp+gifTTr0aTNHHQPGfq8xe3wb-huq2g@mail.gmail.com>
	<5255CAFE.10304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:56555 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756941Ab3JIX6k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 19:58:40 -0400
Received: by mail-wg0-f54.google.com with SMTP id m15so1637174wgh.33
        for <ceph-devel@vger.kernel.org>; Wed, 09 Oct 2013 16:58:38 -0700 (PDT)
In-Reply-To: <5255CAFE.10304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

On Wed, Oct 9, 2013 at 2:30 PM, Loic Dachary <loic@dachary.org> wrote:
>> https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder/manifests/volume/ceph.pp
>
> The
>
> "ceph auth get-or-create ..."
>
> looks like a worthy contribution to
>
> https://github.com/stackforge/puppet-cinder/blob/master/manifests/volume/rbd.pp
>
> Is there a reason why it would not be relevant in this context ?

No, it's definitely relevant, take it if you like it :)

-- 
Dmitry Borodaenko
