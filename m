From: djlee064 <djlee064@gmail.com>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 19:29:37 +1200
Message-ID: <BANLkTi=PT57Xm_o8hmHfwq4pG0CCvjWerQ@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
	<BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
	<BANLkTikOLuHmw-3ijpamDgMdPeU4wqhXRw@mail.gmail.com>
	<BANLkTim5m1xN=cAF-jjVpLNb1CJFbu5J6w@mail.gmail.com>
	<BANLkTikSN836svxj7R19CbmGzTn4sUgwcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51708 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab1EaH3i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 03:29:38 -0400
Received: by pwi15 with SMTP id 15so1926652pwi.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 00:29:37 -0700 (PDT)
In-Reply-To: <BANLkTikSN836svxj7R19CbmGzTn4sUgwcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

> Caching effect decreases as the writing size increases. Sure, when you
> write 100GB+ data, the difference may be subtle. (It still depends on
> your RAM size.)
>
RAM does no play when goes over 100gb+ too, I've gone mad and tried 4
8 12 18gb ram.
Again, huge impact/differences at the start, but all declines quickly,
and so virtually no differences over the huge write.
btw, 100gb was an example, to see the real effect one needs to write
at least 10% or more of the
current capacity. e.g., 2TB -> 200GB, after this point, the decrease
almost stabilizes; slowly.
maybe I'm thinking too much, or too little.
thanks!
