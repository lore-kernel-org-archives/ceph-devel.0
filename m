From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 15:55:54 -0700
Message-ID: <CAPrxi59g8bQj9FZh32GMrg17H6ggN+5FYSaZDwnZz3ds_RwEeA@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
	<CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
	<CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
	<CAPrxi58oZZ25BmcftEz+TgnHy70dPsHhivuFtXd6KkkF7NG8LQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301339120.11149@cobra.newdream.net>
	<CAPrxi58zJQx4ersx2sQ=e0N9U1hxk5cKZmqBW1f9fONd-W-ToQ@mail.gmail.com>
	<CAPYLRzh6G+H1bA_G4GoSKxrZPt4wPxcDtih1W1xt2thCXTvuvg@mail.gmail.com>
	<CAPrxi591mVDbvPH4=S557ryOWibKZ5F3aKVeMdqu2QW9a7h53Q@mail.gmail.com>
	<alpine.DEB.2.00.1208301538200.15643@cobra.newdream.net>
	<CAPrxi59KhNJUZu3kg8OxdKKb0kz+xx87BEiKizZV_DbpvAe0bQ@mail.gmail.com>
	<CAPYLRzjpfPs+Jsp5dMOEd-iccoogVk720sqb=B1FGxx0iVmVBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48738 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab2H3Wzz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 18:55:55 -0400
Received: by ieje11 with SMTP id e11so1201023iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 15:55:54 -0700 (PDT)
In-Reply-To: <CAPYLRzjpfPs+Jsp5dMOEd-iccoogVk720sqb=B1FGxx0iVmVBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

The delay is indefinite (I was killing it after >3 minutes).
Interestingly, this "first mount" hang issue is not present after a
restart of a fresh file system (./vstart.sh -n), but always occurs if
I restart with an existing file system untouched (./stop.sh &&
./vstart).

- Noah

On Thu, Aug 30, 2012 at 3:47 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Aug 30, 2012 at 3:44 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> On Thu, Aug 30, 2012 at 3:39 PM, Sage Weil <sage@inktank.com> wrote:
>>> On Thu, 30 Aug 2012, Noah Watkins wrote:
>>>
>>> I think this is just the mds reconnect delay; it's complete normal when
>>> the mds restarts and some of the clients also crashed that it has to wait
>>> for the full reconnect window to pass.
>>
>> Are you talking about the clients running during the restart? In the
>> case I'm describing I bring down all daemons and the client, before
>> starting the cluster and re-running the test.
>
> How long a hang have you observed? Since you brought down a client,
> the MDS needs to wait through a full time-out period before letting
> other people do things (it's giving the previous client a chance to
> claim some state). The default looks to be 45 seconds right now.
>
> But the patch shouldn't have changed that behavior in any way; so if
> it's actually different behavior in testing then we just
> broke...something else, somehow...
