From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: make check bot failures (2 hours today)
Date: Fri, 11 Sep 2015 09:53:10 -0400
Message-ID: <CAL-2WbF9TuPK_H5kTu9jVxRjgQg9P8B2zvjgcibeyubYhkgAWA@mail.gmail.com>
References: <55F2D137.9090401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33394 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbIKNxb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:53:31 -0400
Received: by wiclk2 with SMTP id lk2so65419190wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 06:53:29 -0700 (PDT)
In-Reply-To: <55F2D137.9090401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Maybe periodically run git gc on the clone out-of-line?  Git runs it
occasionally when it thinks it's necessary, and that can take a while
on large and/or fragmented repos.

Daniel

On Fri, Sep 11, 2015 at 9:03 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> The make check bot failed a number of pull request verifications toda=
y. Each of them was notified as false negative (you should have receive=
d a short note if your pull request is concerned). The problem is now f=
ixed[1] and all should be back to normal. If you want to schedule anoth=
er run, you just need to rebase your pull request and re-push it, the b=
ot will notice.
>
> Sorry for the inconvenience and thanks for your patience :-)
>
> P.S. I'm not sure what it was exactly. Just that git fetch took too l=
ong to answer and failed. Reseting the git clone from which the bot wor=
ks fixed the problem. It happened a few times in the past but did not s=
how up in the past six month or so.
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
