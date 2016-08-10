From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Tue, 9 Aug 2016 22:17:21 -0400
Message-ID: <CA+2bHPaU6nEUkiSjE+9a=8HMMFebDSt=yzZ6ZDMooEmyXf8Pig@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
 <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
 <CAB2gnbW3-PXaBJN4DiqwnuQ7MUSXpKTvxVUR7VaF4e3PS=tffw@mail.gmail.com> <CAB2gnbU_HMvmhX3ipgP3wdRzJOHgxv_xFnr=48je9KX065pYJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33217 "EHLO
	mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbcHJCRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 22:17:53 -0400
Received: by mail-qt0-f178.google.com with SMTP id w38so14754767qtb.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 19:17:52 -0700 (PDT)
In-Reply-To: <CAB2gnbU_HMvmhX3ipgP3wdRzJOHgxv_xFnr=48je9KX065pYJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 9, 2016 at 9:50 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> I've put up cls-lua-syslib branch that builds against the distro-provided
> version of Lua. It's currently assuming Lua 5.1 which is a choice on Ubuntu
> (along with 5.2), and appears to be only version available on CentOS 7. My
> Fedora 24 box only has Lua 5.3. What are the range of platforms that need
> support?

Supporting multiple versions of Lua isn't a good idea. I suggest
sticking with Lua 5.3. [This has the consequence of making LuaJIT
unsupported by cls-lua but I'm personally okay with that. There isn't
any strong reason to maintain support with LuaJIT and it lacks many
new Lua facilities we will want (like string.pack).]

Is it not okay to require distributions to build our bundled Lua if
they don't have 5.3 in their repos?

-- 
Patrick Donnelly
