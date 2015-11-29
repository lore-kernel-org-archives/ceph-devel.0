From: John Spray <jspray@redhat.com>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 20:08:30 +0000
Message-ID: <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
References: <5659CE92.4000203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34798 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbbK2UIw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 15:08:52 -0500
Received: by lffu14 with SMTP id u14so174624781lff.1
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 12:08:50 -0800 (PST)
In-Reply-To: <5659CE92.4000203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> An optional teuthology field could be added to a commit message like =
so:
>
> teuthology: --suite rbd
>
> to state that this commit should be tested with the rbd suite. It cou=
ld be parsed by bots and humans.
>
> It would make it easy and cost effective to run partial teuthology su=
ites automatically on pull requests.
>
> What do you think ?

Hmm, we are usually testing things at the branch/PR level rather than
on the per-commit level, so it feels a bit strange to have this in the
commit message.

However, if a system existed that would auto-test things when I put
something magic in a commit message, I would probably use it!

John


>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
