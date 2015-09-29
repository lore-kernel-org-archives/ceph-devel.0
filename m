From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Compiler prerequisite and C++11-ificartion
Date: Tue, 29 Sep 2015 06:53:11 -0700
Message-ID: <CAJ4mKGaTn-yFRLB639dh5zdDOFWJ8dqM2XBypPTn=Uj5_zNp_Q@mail.gmail.com>
References: <90559C83A9C7FA45B5846C975DFA612DDB54D33194@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36095 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965448AbbI2NxM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 09:53:12 -0400
Received: by wicgb1 with SMTP id gb1so150461342wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2015 06:53:11 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB54D33194@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 29, 2015 at 2:21 AM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
> Hello,
>
> With recent C++11-ification of Ceph codebase, there's been (silent) c=
ompiler requirement change, in particular: GCC 4.4.7 is not enough to b=
uild Ceph from master branch, and recent commits made even GCC 4.7 obso=
lete, requiring GCC 4.8. That is not noted anywhere. Maybe it's a good =
idea to note this somewhere?
> This is particularly painful for some LTS distros, like CentOS 6, whi=
ch come shipped with GCC 4.4.7 and require installation of at least Dev=
Toolset 2 to build Ceph successfully.

I'm not sure we've ever reported required compiler versions for the
Ceph toolchain. :/ I'd merge a PR doing somewhere, probably in the
README file.

But honestly to do that properly we'd have to keep track of which
version of gcc will build the source, and I have a suspicion we won't
notice anything like that unless it breaks our gitbuilders =E2=80=94 wh=
ich
include a CentOS 6 one using standard tools, so the necessarily
compiler is at least readily available! :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
