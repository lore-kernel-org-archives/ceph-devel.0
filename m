From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:26:25 -0800
Message-ID: <CAORUGqCvEqZe4144x07s+T-bAxXh7EoXAYn-bAhUy_Ri_7Rfug@mail.gmail.com>
References: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
 <Pine.LNX.4.64.1111091255150.31435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44616 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab1KIV0r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:26:47 -0500
Received: by wwh12 with SMTP id 12so1323796wwh.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2011 13:26:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1111091255150.31435@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <gregory.farnum@dreamhost.com>

On Wed, Nov 9, 2011 at 12:56, Sage Weil <sage@newdream.net> wrote:
> The only issue with this is that, in the event that you don't guess a
> sufficiently large array on the first call, you may need to call agai=
n,
> and in some cases that may mean multiple MDS requests. =C2=A0Normally=
 that's
> not the case. =C2=A0And a smart caller should guess 4 and only pass 0=
 and then
> N if 4 failed. =C2=A0But a naive caller will always make two calls, f=
irst with
> 0 and then with N, and in some cases that's actually slower.

That's the biggest benefit of the "return number that would be
returned" or "int *naddr_out" approaches; if you didn't allocate
enough, you get told how much to allocate. No need to 1. try with too
small 2. probe for size 3. try with right size.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
