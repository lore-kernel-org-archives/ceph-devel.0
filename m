From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Passing LUA script via python rados execute
Date: Sun, 19 Feb 2017 15:15:07 -0500
Message-ID: <CA+2bHPYgFkRbNwc8b1aLcTX+0-=DecM1m3BV5ssjKFmBYBmo2w@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
 <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
 <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
 <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
 <CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
 <3a5eb209.AEEAIECau6cAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYp3rL@mailjet.com> <CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34832 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdBSUPt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Feb 2017 15:15:49 -0500
Received: by mail-io0-f182.google.com with SMTP id j18so17339944ioe.2
        for <ceph-devel@vger.kernel.org>; Sun, 19 Feb 2017 12:15:43 -0800 (PST)
In-Reply-To: <CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Nick Fisk <nick@fisk.me.uk>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Sat, Feb 18, 2017 at 2:55 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> The least intrusive solution is to simply change the sandbox to allow
> the standard file system module loading function as expected. Then any
> user would need to make sure that every OSD had consistent versions of
> dependencies installed using something like LuaRocks. This is simple,
> but could make debugging and deployment a major headache.

A locked down require which doesn't load C bindings (i.e. only load
.lua files) would probably be alright.

> A more ambitious version would be to create an interface for users to
> upload scripts and dependencies into objects, and support referencing
> those objects as standard dependencies in Lua scripts as if they were
> standard modules on the file system. Each OSD could then cache scripts
> and dependencies, allowing applications to use references to scripts
> instead of sending a script with every request.

This is very doable. I imagine we'd just put all of the Lua modules in
a flattened hierarchy under a RADOS namespace? The potentially
annoying nit in this is writing some kind of mechanism for installing
a Lua module tree into RADOS. Users would install locally and then
upload the tree through some tool.

-- 
Patrick Donnelly
