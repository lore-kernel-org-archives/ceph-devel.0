From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Mon, 7 Nov 2011 14:00:54 -0800
Message-ID: <CAORUGqAS7xgKGrf6SgxoRg4P6JaZwuRmjDBwmW6PDFyTG+GoDw@mail.gmail.com>
References: <172453601.38993.1320698769959.JavaMail.root@mail-01.cse.ucsc.edu> <CAF3hT9BhwtpjZx8WcAk-5rPrBbzU8ufUQZxRrcn-ah_noWJOxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55163 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1KGWBQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 17:01:16 -0500
Received: by wyh15 with SMTP id 15so4976438wyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 14:01:15 -0800 (PST)
In-Reply-To: <CAF3hT9BhwtpjZx8WcAk-5rPrBbzU8ufUQZxRrcn-ah_noWJOxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 7, 2011 at 13:43, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> This generally looks good to me, but that return statement is weirding
> me out a bit. I guess you're trying to compress the information about
> the number of returned addresses, and whether or not you got all the
> addresses, into that one value? It seems more idiomatic to me to send
> back the number of filled-in addresses, or an error code if there
> wasn't enough space for all of them.
> I'm not sure if that idiom is worth applying here, but it was my one
> thought about the interface. :)

The value in returning the number that *would have been written* is in
that now the caller can reallocate a buffer of exactly the right size
(barring races). Like snprintf() and friends. With just a generic
-ENOBUFS/-EMSGSIZE/whatever you cram in there, the caller must do a
series of increasing guesses.

But yes, the function is tricky to use right. Gets a 3 on the Rusty
scale I'd say..

http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

Maybe instead of

extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info
*cmount, int fh,
                                           loff_t offset, struct
sockaddr_storage *addr, int naddr)

it should be

extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info
*cmount, int fh,
                                           loff_t offset, struct
sockaddr_storage *addr, int naddr, int *naddr_out)

and the return value is just 0 or -errno, gets -ESOMETHING if all
entries won't fit, and naddr_out (if not NULL) is set to be the number
of entries that would have been returned. More moving parts but harder
to get wrong by forgetting to check ret < naddr.
