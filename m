From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Fri, 5 Aug 2016 14:49:38 -0400
Message-ID: <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33551 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937832AbcHESuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 14:50:10 -0400
Received: by mail-qk0-f173.google.com with SMTP id p74so271485832qka.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 11:50:09 -0700 (PDT)
In-Reply-To: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 2:00 PM, Alfredo Deza <adeza@redhat.com> wrote:
> There is a tendency to embed dependencies in the Ceph project which is a big
> problem for maintainers (there are many reasons for this, including security
> patches, and keeping up to date with forks). For Mantle, this is the case
> again: it depends on a Pull Request [1] that embeds a *forked* version of the
> official Lua repository that includes custom changes.

I think we should be using our own copy of the upstream tarballs. Is
there no way to use Lua's Makefiles with our cmake build?

> Here are a few concerns I have:
>
> * The fork is already modified and has diverged from the upstream Lua [2], who
>   is going to keep up with upstream changes? (pulling/rebasing etc...)

The cmsgpack module should be in the ceph/ tree and added to the preload table:

https://www.lua.org/manual/5.3/manual.html#pdf-require

Scripts should then require "cmsgpack".

> * Embedding Lua in this form makes it *impossible* for distro maintainers to
>   package Ceph: they would most likely rip out and figure out how to try and
>   make it work with the distro-provided version. *This is very frowned upon and
>   creates a gigantic amount of work for package maintainers*.

We should definitely try to limit changes to Lua unless it's
absolutely necessary. I haven't seen a good reason yet so I suggest
using bare upstream so maintainers can use the system liblua if
desired.

-- 
Patrick Donnelly
