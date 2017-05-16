From: Ming Lin <minggr@gmail.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Mon, 15 May 2017 19:46:15 -0700
Message-ID: <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34707 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdEPCqQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 May 2017 22:46:16 -0400
Received: by mail-yb0-f171.google.com with SMTP id 132so14053230ybq.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 May 2017 19:46:16 -0700 (PDT)
In-Reply-To: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Eric,

Do you have any integration patches I can have a try?

Thanks,
Ming

On Tue, Apr 4, 2017 at 6:32 AM, J. Eric Ivancich <ivancich@redhat.com> wrot=
e:
> In our work to improve QoS with ceph, we implemented the dmClock algorith=
m (see: https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.=
pdf).
>
> The algorithm is implemented as a general library that could be used in c=
eph and in other projects unrelated to ceph. To do this the dmClock library=
 code makes use of C++ templates. On the server side, the key class takes t=
emplate parameters to describe the type of a request and the type of a clie=
nt identifier. On the client side, the key class takes a template parameter=
 for the type of a server identifier.
>
> You can find the library here:
>
>    https://github.com/ceph/dmclock
>
> The question is how best to integrate this library with ceph code in our =
git repo into the future.
>
> There are three obvious options:
>
>    1. Keep dmClock as a separate repo and incorporate it into ceph as a g=
it submodule.
>    2. Keep dmClock as a separate repo and incorporate it into ceph as a g=
it subtree.
>    3. Move the code into the ceph tree and stop maintaining as a generali=
zed library.
>
> Both git submodules and git subtrees have their own set of challenges; ne=
ither is perfect. Many have weighed in their relative advantages and disadv=
antages (https://www.google.com/search?q=3Dgit+submodule+subtree).
>
> I=E2=80=99m inclined to keep it separate (option 1 or 2) so that others m=
ight use it in other projects.
>
> When I started the integration, Sam recommended that it be maintained as =
a subtree. So that=E2=80=99s how it=E2=80=99s implemented in my not-yet-mer=
ged branch. The key challenges have been with rebases that include the comm=
it in which the subtree was added and with pushing code changes back to the=
 library. Since relatively few would likely be doing these types of ops, pe=
rhaps option 2 might be easiest. Currently our git PR process has an automa=
ted check for "Unmodifed Submodules". I=E2=80=99m guessing we=E2=80=99d lik=
ely want a similar check for changes in subtree code.
>
> An argument for making it a submodule is that ceph already uses submodule=
s and ceph developers are familiar with working with (and around) them.
>
> But perhaps others would like to weigh in.
>
> Thanks,
>
> Eric--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
