From: Gregory Farnum <greg@gregs42.com>
Subject: Re: timeout 120 teuthology-killl is highly recommended
Date: Tue, 21 Jul 2015 17:29:34 +0100
Message-ID: <CAC6JEv9E20XRpc0Y_egivj+N-KQdLEnGwGbHGGyqcOwt9fAczA@mail.gmail.com>
References: <55AE6F90.3070503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37388 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933316AbbGUQ3f convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:29:35 -0400
Received: by igbpg9 with SMTP id pg9so111571546igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 09:29:35 -0700 (PDT)
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com. [209.85.223.177])
        by smtp.gmail.com with ESMTPSA id h138sm16089800ioe.2.2015.07.21.09.29.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 09:29:34 -0700 (PDT)
Received: by ietj16 with SMTP id j16so146816777iet.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 09:29:34 -0700 (PDT)
In-Reply-To: <55AE6F90.3070503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 21, 2015 at 5:13 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> Today I did something wrong and that blocked the lab for a good half =
hour.
>
> a) I ran two teuthology-kill simultaneously and that makes them deadl=
ock each other
> b) I let them run unattended only to come back to the terminal 30 min=
utes later and see them stuck.
>
> Sure, two teuthology-kill simultaneously should not deadlock and that=
 needs to be fixed. But the easy workaround to avoid that trouble is to=
 just not let it run forever. Even for ~200 jobs it takes at most a min=
ute or two.

Mmm, I'm not sure that's correct if you're killing jobs which are
actually running =E2=80=94 teuthology-nuke (which it will invoke) can t=
ake a
while and you definitely don't want to time that out! So beware for
in-process runs.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
