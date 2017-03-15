From: kefu chai <tchaikov@gmail.com>
Subject: Re: Can't compile because of -lpthreads
Date: Wed, 15 Mar 2017 18:14:35 +0800
Message-ID: <CAJE9aOM+2-iOwp-Qm2OdK9sTXVsApJUgEO4bD4k4kcipeMOUXg@mail.gmail.com>
References: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
 <CAJE9aOMdgg=Y97PKPQGdxrMN1BShdVLS_QdZZA_1xx+yKgLKEg@mail.gmail.com>
 <CAAXqJ+qmmZTbDi-ipF_AThYO6bMvFxHjo4OZMxweW21fA0Gkyg@mail.gmail.com>
 <CAJE9aOMBGNs7F9hEyii55=XSs0rMPAdDAj7rjg_0iRnZtkiMjA@mail.gmail.com>
 <CAAXqJ+pUpdvEZQKn2eVKo-p-dxaASL9Q1Q-PpsV=n2unW-AV1g@mail.gmail.com>
 <CAJE9aONRJKuDKTHc4BrOorahnG6WtCox_vOuaVOFG0d5X8tWuw@mail.gmail.com>
 <CAAXqJ+rbZTfKA0bVaHXVF3cXG2FuMTdyv9LCSo1tKFydHytGeA@mail.gmail.com> <CAAXqJ+q_=j4-3fDG8AM=CD+bkOC1v5E+NCVZ01KM5NdSMH1eTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36784 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdCOKOh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Mar 2017 06:14:37 -0400
Received: by mail-ua0-f178.google.com with SMTP id 72so6394851uaf.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Mar 2017 03:14:36 -0700 (PDT)
In-Reply-To: <CAAXqJ+q_=j4-3fDG8AM=CD+bkOC1v5E+NCVZ01KM5NdSMH1eTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 15, 2017 at 1:42 PM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> This is the output of the command `./bootstrap.sh --show-libraries`
> under src/boost
>
> "
> Building Boost.Build engine with toolset gcc...
> tools/build/src/engine/bin.linuxx86_64/b2
>
> The following Boost libraries have portions that require a separate build
> and installation step. Any library not listed here can be used by including
> the headers only.
>
> The Boost libraries requiring separate building and installation are:
> "
>
> And I synced boost before running the above command.
>

so none of the boost's submodules are in place. please check if
src/boost/libs/coroutine is empty or not, otherwise, i doubt that your
boost's submodules are sync'ed. you can run "git submodule update
--force --init --recursive" to sync the submodules.


-- 
Regards
Kefu Chai
