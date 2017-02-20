From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Passing LUA script via python rados execute
Date: Mon, 20 Feb 2017 00:43:52 -0800
Message-ID: <10499347-8c11-83fb-9778-e95049668c6c@redhat.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
 <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
 <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
 <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
 <CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
 <3a5eb209.AEEAIECau6cAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYp3rL@mailjet.com>
 <CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com>
 <CA+2bHPYgFkRbNwc8b1aLcTX+0-=DecM1m3BV5ssjKFmBYBmo2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdBTIn4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 03:43:56 -0500
In-Reply-To: <CA+2bHPYgFkRbNwc8b1aLcTX+0-=DecM1m3BV5ssjKFmBYBmo2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Noah Watkins <noahwatkins@gmail.com>
Cc: Nick Fisk <nick@fisk.me.uk>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 02/19/2017 12:15 PM, Patrick Donnelly wrote:
> On Sat, Feb 18, 2017 at 2:55 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
>> The least intrusive solution is to simply change the sandbox to allow
>> the standard file system module loading function as expected. Then any
>> user would need to make sure that every OSD had consistent versions of
>> dependencies installed using something like LuaRocks. This is simple,
>> but could make debugging and deployment a major headache.
>
> A locked down require which doesn't load C bindings (i.e. only load
> .lua files) would probably be alright.
>
>> A more ambitious version would be to create an interface for users to
>> upload scripts and dependencies into objects, and support referencing
>> those objects as standard dependencies in Lua scripts as if they were
>> standard modules on the file system. Each OSD could then cache scripts
>> and dependencies, allowing applications to use references to scripts
>> instead of sending a script with every request.
>
> This is very doable. I imagine we'd just put all of the Lua modules in
> a flattened hierarchy under a RADOS namespace? The potentially
> annoying nit in this is writing some kind of mechanism for installing
> a Lua module tree into RADOS. Users would install locally and then
> upload the tree through some tool.

Using rados objects for this is not really feasible. It would be
incredibly complex within the osd - it involves multiple objects, cache
invalidation, and has all kinds of potential issues with consistent
versioning and atomic updates across objects.

The simple solution of loading modules from the local fs sounds
way better to me. Putting modules on all osds and reloading the modules
or restarting the osds seems like a pretty simple deployment model with
any configuration management system.

That said, for research purposes you could resurrect something like the
ability to load modules into the cluster from a client - just store
them on the local fs of each osd, not in rados objects. This was
removed back in 2011:

https://github.com/ceph/ceph/commit/7c04f81ca16d11fc5a592992a4462b34ccb199dc
https://github.com/ceph/ceph/commit/964a0a6e1326d4f773c547655ebb2a5c97794268

Josh
