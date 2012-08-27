From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: On tmap, omap, xattr physical layout
Date: Mon, 27 Aug 2012 12:25:23 -0700
Message-ID: <CAPrxi58gbo-PofkJzvrF-BFpDUZbNRpMMhtS+90WbwVfJSKXgQ@mail.gmail.com>
References: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
	<CAPYLRzhCz1Si2-NuR-JKp2LNf3RkuL+OpYkCyhfi1upUNe8cHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43366 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab2H0TZX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 15:25:23 -0400
Received: by ialo24 with SMTP id o24so8916320ial.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 12:25:23 -0700 (PDT)
In-Reply-To: <CAPYLRzhCz1Si2-NuR-JKp2LNf3RkuL+OpYkCyhfi1upUNe8cHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the clarification, guys!

On Sun, Aug 26, 2012 at 11:06 AM, Gregory Farnum <greg@inktank.com> wrote:

> omaps are put in a per-osd leveldb store, carefully keyed so they can

Interesting. Is this really per OSD, or is it per PG? And if it is the
former, wouldn't this mean that an OSD failure would need to
explicitly request each individual key/value pair for the re-mapped
objects?

- Noah
