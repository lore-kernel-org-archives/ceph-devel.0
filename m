From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 15:44:40 -0700
Message-ID: <CAPrxi59KhNJUZu3kg8OxdKKb0kz+xx87BEiKizZV_DbpvAe0bQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34316 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2H3Wol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 18:44:41 -0400
Received: by iahk25 with SMTP id k25so296740iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 15:44:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208301538200.15643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 30, 2012 at 3:39 PM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 30 Aug 2012, Noah Watkins wrote:
>
> I think this is just the mds reconnect delay; it's complete normal when
> the mds restarts and some of the clients also crashed that it has to wait
> for the full reconnect window to pass.

Are you talking about the clients running during the restart? In the
case I'm describing I bring down all daemons and the client, before
starting the cluster and re-running the test.

- Noah
