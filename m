From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Wed, 10 Aug 2016 15:01:09 -0700
Message-ID: <CAB2gnbUHQROsGQbxHCYTC-PM52iopwujhyHxjaGkZxfWB6-CYQ@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
 <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
 <CAB2gnbW3-PXaBJN4DiqwnuQ7MUSXpKTvxVUR7VaF4e3PS=tffw@mail.gmail.com>
 <CAB2gnbU_HMvmhX3ipgP3wdRzJOHgxv_xFnr=48je9KX065pYJw@mail.gmail.com> <CA+2bHPaU6nEUkiSjE+9a=8HMMFebDSt=yzZ6ZDMooEmyXf8Pig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33072 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcHJWBL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 18:01:11 -0400
Received: by mail-oi0-f45.google.com with SMTP id c15so78010818oig.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 15:01:10 -0700 (PDT)
In-Reply-To: <CA+2bHPaU6nEUkiSjE+9a=8HMMFebDSt=yzZ6ZDMooEmyXf8Pig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 9, 2016 at 7:17 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>
> Supporting multiple versions of Lua isn't a good idea. I suggest
> sticking with Lua 5.3. [This has the consequence of making LuaJIT
> unsupported by cls-lua but I'm personally okay with that. There isn't
> any strong reason to maintain support with LuaJIT and it lacks many
> new Lua facilities we will want (like string.pack).]

One compelling reason for LuaJIT is that it supports linking against C
libraries dynamically. So for instance linking against ImageMagick to
create thumbnail compression plugin is possible without writing any C
glue. But really the first version of cls_lua is probably not the last
version and that sort of thing can come later.

> Is it not okay to require distributions to build our bundled Lua if
> they don't have 5.3 in their repos?

I too would very much prefer supporting a single version (5.3). Since
distro-provided versions of Lua don't satisfy our goal of supporting a
single Lua version, the two+ options are:

1) statically link the Lua VM into Ceph like we had been doing
2) produce distro-specific packages only for Ceph (I think once upon a
time this was done for LevelDB?)
3) ??

- Noah
