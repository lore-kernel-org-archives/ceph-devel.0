From: Sage Weil <sage@newdream.net>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 09:40:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108010936430.6290@cobra.newdream.net>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58967 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1HAQfy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:35:54 -0400
In-Reply-To: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 1 Aug 2011, Tommi Virtanen wrote:
> We've talked about generating/parsing JSON a few times, and how we've
> run into edge cases whenever we've rolled our own functions for that.
> I've mentioned this C library a few times, but I'm not sure if I've
> actually sent the link to anyone.. Here's a C library for
> generating/parsing JSON, written by an ex-cow-orker of mine.

Heh, you forgot the link again?  :)
 
> One feedback I've received earlier was that the "DOM-style"
> architecture, where you build up the JSON object in-memory and then
> dump it out, is not always a good match. If you want to avoid that,
> you can pull off a trick like this pseudocode:
> 
> write("{")
> json.dump(key)
> write(":")
> json.dump(value)
> write(",")
> json.dump(key2)
> write(":")
> json.dump(value2)
> write("}")
> 
> The above still uses the library for proper string encoding etc, while
> letting you control the top-level structure explicitly. And it should
> be pretty easy to encapsulate the above in a convenience wrapper, to
> make streaming even nicer; something like this pseudocode:
> 
> j = StreamingJSONObject(fd)
> j.dump(key, value)
> j.dump(key2, value2)
> j.close()

That's basically what JSONFormatter is doing, except it has some higher 
level methods for opening object vs array sections, and can add whitespace 
for human readability.  The only thing we'd be using here is the string 
quoting.  It's probably easier to just lift that method than link in an 
external dependency for that.  Or, fix any bugs in the current escaping...

sage
