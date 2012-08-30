From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 13:06:40 -0700
Message-ID: <CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63925 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2H3UGl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 16:06:41 -0400
Received: by iahk25 with SMTP id k25so54947iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 13:06:41 -0700 (PDT)
In-Reply-To: <CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
> Using a tick interval of 1 drops the cost down to 3 seconds, but stil=
l
> a long time for running many unit tests that use fresh mounts.

Are you using ceph-fuse or the kernel client? And how many of each daem=
on type?

That said; I'm seeing broadly similar numbers =97=A0with one of each
daemon (but otherwise the vstart defaults) "time sudo ceph-fuse mnt"
reports 3.1 seconds.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
