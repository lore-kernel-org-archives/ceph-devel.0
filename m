From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: PowerDNS backend for Rados Gateway to direct bucket traffic
Date: Thu, 7 Nov 2013 13:09:21 -0800
Message-ID: <CAFMfnwpa874DOywJwiwS0gYVaQ70cf4V6403KRrJUMM6NqX=wg@mail.gmail.com>
References: <52765A7E.9040306@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36102 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3KGVJW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 16:09:22 -0500
Received: by mail-lb0-f177.google.com with SMTP id u14so899782lbd.22
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 13:09:21 -0800 (PST)
In-Reply-To: <52765A7E.9040306@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Does it sound reasonable what I'm thinking of or am I completely wrong about
> this?
>
> [0]: http://doc.powerdns.com/html/remotebackend.html

I was considering exactly what your describe, not being a programmer
though it was simply an idea. I could see myself using a powerdns
backend for bucket mapping, all other ways I've considered seem very
brittle. Let me know if you write it, I'd be willing to test it out.

-- 

Kyle
