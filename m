From: Sage Weil <sage@inktank.com>
Subject: Re: PowerDNS backend for Rados Gateway to direct bucket traffic
Date: Thu, 7 Nov 2013 20:37:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311072036580.15297@cobra.newdream.net>
References: <52765A7E.9040306@42on.com> <CAFMfnwpa874DOywJwiwS0gYVaQ70cf4V6403KRrJUMM6NqX=wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48635 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab3KHEhl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 23:37:41 -0500
In-Reply-To: <CAFMfnwpa874DOywJwiwS0gYVaQ70cf4V6403KRrJUMM6NqX=wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think this is a good path forward, FWIW.  Want to write up a blueprint, 
Wido?  :)

sage


On Thu, 7 Nov 2013, Kyle Bader wrote:

> > Does it sound reasonable what I'm thinking of or am I completely wrong about
> > this?
> >
> > [0]: http://doc.powerdns.com/html/remotebackend.html
> 
> I was considering exactly what your describe, not being a programmer
> though it was simply an idea. I could see myself using a powerdns
> backend for bucket mapping, all other ways I've considered seem very
> brittle. Let me know if you write it, I'd be willing to test it out.
> 
> -- 
> 
> Kyle
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
