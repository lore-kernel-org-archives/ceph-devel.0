From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Tue, 9 Aug 2016 15:07:41 -0700
Message-ID: <CAB2gnbXTbjGjWasZxu2VPUupwQmD+oyAfF=eGMNa6D=xHNN+mg@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35459 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcHIWHn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 18:07:43 -0400
Received: by mail-oi0-f52.google.com with SMTP id 4so36499850oih.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 15:07:42 -0700 (PDT)
In-Reply-To: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 11:00 AM, Alfredo Deza <adeza@redhat.com> wrote:
>
> * The fork is already modified and has diverged from the upstream Lua [2], who
>   is going to keep up with upstream changes? (pulling/rebasing etc...)
> * Who (or whom) is going to be responsible for keeping track of CVE's and their
>   corresponding patches?

I'm not trying to avoid these questions, but here is some information
that might be useful in figuring out answers:

Lua scripting was enabled in Redis in 2011 and is a high-profile
feature. Since 2011 it appears that only a handful of commits were
related to core Lua [1] (there are many related to included 3rd party
libraries): a couple build fixes and a patch to disable bytecode
execution, but the later was likely not a CVE, it was disabling a Lua
feature.

With respect to Lua being used to program object classes, it would
seem that at the moment both Redis and Ceph have a similar security
model in which API access is explicitly granted and those users are
trusted; similar to users with enough access to dynamic load c++
modules. My point being that we might want to at first consider the
on-going maintenance costs of fixes for stability over those that
address vulnerabilities, and Redis seems to be one big example of
where stability has not been an issue for the core Lua library. What
this means for Mantle, I'm not sure.

> * Embedding Lua in this form makes it *impossible* for distro maintainers to
>   package Ceph: they would most likely rip out and figure out how to try and
>   make it work with the distro-provided version. *This is very frowned upon and
>   creates a gigantic amount of work for package maintainers*.

I think that as Patrick points out in [2], making this choice flexible
would be nice if we have a compelling reason. And starting with the
distro-provided version might be a good option. Linking against
distro-provided versions is very convenient, but also means we give up
the ability to customize the VM if we wanted, and have added headaches
with handling differences across all possible versions of Lua we might
need to link against. On the other hand, some users [3] may want to
link against LuaJIT for special features, and unlike the Lua
interpreter which is commonly built into its target package, it is
explicitly recommended that users link against the distro-provided
versions of LuaJIT.

[1]: https://github.com/antirez/redis/tree/unstable/deps/lua
[2] Lua object class support Pull Request https://github.com/ceph/ceph/pull/7338
[3]: http://ceph.com/rados/dynamic-object-interfaces-with-lua/
