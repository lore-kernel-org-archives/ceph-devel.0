From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Release/branch naming; input requested
Date: Fri, 18 May 2012 09:51:34 -0700
Message-ID: <CAC-hyiFQ7M9Y61uc4CfbWRAaMb_ovC-NG5snkPR2HEfYjVNbKA@mail.gmail.com>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
	<CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com>
	<Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932891Ab2ERQvg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 12:51:36 -0400
Received: by bkcji2 with SMTP id ji2so2517060bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 09:51:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tommi Virtanen <tommi.virtanen@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 18, 2012 at 9:32 AM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 26 Apr 2012, Yehuda Sadeh Weinraub wrote:
>> > Now, here are my actual questions:
>> >
>> > 1. What should the "relative" names of the branches be? "stable" v=
s
>> > "latest" etc. I especially don't like "integration", but I do see =
a
>> > time where it is not ready for "stable" but still needs to branch =
off
>> > of "latest".
>>
>> reallyold
>> old
>> current
>> next
>> latest/experimental
>
> I think we can limit the relative branches to:
>
> =A0master =3D integration, unstable, tip, bleeding edge (same as now)
> =A0[next] =3D next upcoming release (same as now)

However, now a release means a dev cycle, which is different than
having a few iterations on a single release. So should 'next' be the
next release, or the next output of the current dev cycle?

> =A0current =3D most recent release
> =A0stable =3D most recent stable release
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
