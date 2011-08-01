From: Sage Weil <sage@newdream.net>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 09:42:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108010941200.6290@cobra.newdream.net>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
 <CAORUGqAhp4bSHojzGXOzVFekoUjg5vc_TbTw8hKxMxYwyy0adg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58986 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab1HAQir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:38:47 -0400
In-Reply-To: <CAORUGqAhp4bSHojzGXOzVFekoUjg5vc_TbTw8hKxMxYwyy0adg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 1 Aug 2011, Tommi Virtanen wrote:
> On Mon, Aug 1, 2011 at 09:24, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > We've talked about generating/parsing JSON a few times, and how we've
> > run into edge cases whenever we've rolled our own functions for that.
> > I've mentioned this C library a few times, but I'm not sure if I've
> > actually sent the link to anyone.. Here's a C library for
> > generating/parsing JSON, written by an ex-cow-orker of mine.
> 
> D'oh!
> 
> https://github.com/akheron/jansson

Ah, yeah.  The problem with the current code is it's assuming the 
string to dump is ASCII.  We need to do this:

https://github.com/akheron/jansson/blob/master/src/dump.c#L67

Thanks!
sage

