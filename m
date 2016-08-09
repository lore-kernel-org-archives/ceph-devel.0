From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Tue, 9 Aug 2016 15:17:50 -0700
Message-ID: <CAB2gnbW3-PXaBJN4DiqwnuQ7MUSXpKTvxVUR7VaF4e3PS=tffw@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
 <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36050 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcHIWRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 18:17:52 -0400
Received: by mail-oi0-f54.google.com with SMTP id f189so36586369oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 15:17:51 -0700 (PDT)
In-Reply-To: <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 11:49 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>
> We should definitely try to limit changes to Lua unless it's
> absolutely necessary. I haven't seen a good reason yet so I suggest
> using bare upstream so maintainers can use the system liblua if
> desired.

We have put together versions of the Lua branch for system liblua,
embed (current approach), and LuaJIT and the deltas are very small.
I'll toss up a version that links against system liblua. IIRC we had a
motivation for compiling our own version, so that should reveal itself
if it really existed :)

>
> --
> Patrick Donnelly
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
