From: Sage Weil <sage@newdream.net>
Subject: Re: Authentication error
Date: Tue, 27 Sep 2011 12:54:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109271253310.15397@cobra.newdream.net>
References: <CAMiHsJJTrCerY+J71-dMpam081wecCxYLVoc55woVDhfohBpcw@mail.gmail.com>
 <CAMiHsJJitpTZCUZDN21ew0J2+fyYKX2pUDCzuVgwkW54ev5Uow@mail.gmail.com>
 <CAF3hT9DwJQNk6Cqm+umDyz6OXSMnjMqizwt+VuRQ2e5-S5xTJA@mail.gmail.com>
 <CAMiHsJL8LHnKVCcEQLK02KA3qz+Ry6Kscpx7mSvHbyexMP7PJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57388 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1I0Tyn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2011 15:54:43 -0400
In-Reply-To: <CAMiHsJL8LHnKVCcEQLK02KA3qz+Ry6Kscpx7mSvHbyexMP7PJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, 28 Sep 2011, Atish Kathpal wrote:
> Thanks for your help Gregory. I tried what you suggested, but still
> can't resolve the problem.
> 
> I have given 777 privileges to the keyring file and am also able to
> read its contents. Here is a snapshop of what I did:-
> 
> atish@atish-virtual-machine:/etc/ceph$ sudo ceph health -k
> /etc/ceph/ceph.keyring
> 2011-09-28 01:16:30.066795 b78746d0 unable to authenticate as client.admin
> 2011-09-28 01:16:30.067890 b78746d0 ceph_tool_common_init failed.
> atish@atish-virtual-machine:/etc/ceph$ cat ceph.keyring
> [client.admin]
>         key = AQDQynxOCNuXJRAAvt17zqCn70kGovuIhJXEyg==
>         auid = 18446744073709551615

It sounds like that key doesn't match what your monitors have on file.  :/

> Even providing the path to the keyring is not helping for some  reason.
> 
> Any way to avoid the keyring/authentication problem I am facing?

You can disable authentication entirely by putting

	auth supported = none

in ceph.conf and restarting your daemons.

sage

