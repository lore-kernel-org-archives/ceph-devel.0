From: Mark Kampe <mark.kampe@dreamhost.com>
Subject: Re: The costs of logging and not logging
Date: Mon, 21 Nov 2011 11:31:40 -0800
Message-ID: <4ECAA71C.10202@dreamhost.com>
References: <4ECA7C83.1090702@dreamhost.com> <Pine.LNX.4.64.1111211047330.24847@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43486 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1KUTbl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 14:31:41 -0500
In-Reply-To: <Pine.LNX.4.64.1111211047330.24847@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I'm a big believer in asynchronous flushes of an in-memory
ring-buffer.  For user-mode processes a core-dump-grave
robber can reliably pull out all of the un-flushed entries
... and the same process will also work for the vast majority
of all kernel crashes.

String logging is popular because:
   1. It trivial to do (in the instrumented code)
   2. It is trivial to read (in the recovered logs)
   3. It is easily usable by grep/perl/etc type tools

But binary logging:
   1. is much (e.g. 4-10x) smaller (especially for standard header info)
   2. is much faster to take (no formatting, less data to copy)
   3. is much faster to process (no re-parsing)
   4. is smaller to store on disk and faster to ship for diagnosis

   and a log dumper can quickly produce output that
   is identical to what the strings would have been

So I also prefer binary logs ... even though they require
the importation of additional classes.  But ...

  (a) the log classes must be kept upwards compatible so
      that old logs can be ready by newer tools.

  (b) the binary records should glow-in-the-dark, so that
      they can be recovered even from corrupted ring-buffers
      and blocks whose meta-data has been lost.

> I see two main issues with the slowness of the current logs:
>
>   - all of the string rendering in the operator<<()'s is slow.  things like
> prefixing every line with a dump of the pg state is great for debugging,
> but makes the overhead very high.  we could scale all of that back, but
> it'd be a big project.
>   - the logging always goes to a file, synchronously.  we could write to a
> ring buffer and either write it out only on crash, or (at the very least)
> write it async.

> I wonder, though, if something different might work.  gcc lets you
> arbitrarily instrument function calls with -finstrument-functions.
> Something that logs function calls and arguments to an in-memory ring
> buffer and dumps that out on crash could potentially have a low overhead
> (if we restrict it to certain code) and would give us lots of insight into
> what happend leading up to the crash.

This does have the advantage of being automatic ... but it is much more
information, perhaps without much more value.  My experience with
logging is that you don't have to capture very much information,
and that in fact we often go back to weed out no-longer-interesting
information.  Not only does too much information take cycles and
space, but it also makes it hard to find "the good stuff".  I think that 
human architects can make very good decisions about what
information should be captured, and when.
