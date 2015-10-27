From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: PG: all requests stuck when acting set < min_size
Date: Tue, 27 Oct 2015 12:47:34 -0700
Message-ID: <CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
References: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33162 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbJ0Trg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 15:47:36 -0400
Received: by wijp11 with SMTP id p11so229973673wij.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2015 12:47:35 -0700 (PDT)
In-Reply-To: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Oct 27, 2015 at 11:47 AM, GuangYang <yguang11@outlook.com> wrot=
e:
> Hi there,
> Is there any reason we stuck read only requests as well for a PG when=
 the acting set size is less than min_size?

A few.
The most important reason: PGs don't have any concept of a read-only
mode in the code. They are "active" or not, and an active PG handles
writes. (The full flags and other things which block writes but allow
reads are at the OSD level, not the PG level, and are handled when ops
come in before they reach the PG.) Allowing read requests against a PG
to complete even when we aren't taking writes on a per-PG level would
take some doing.
Also: it would be weird from several different levels. We'd need to
keep track of client streams because we wouldn't want to let through a
read that is ordered after a write. How would we handle the memory
pressure implied by that? While I can imagine it being useful for some
stuff like RGW reads, in general making data available for read but
not write is a pretty complicated thing to explain to users =E2=80=94 h=
ow do
we expose that in a useful way?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
