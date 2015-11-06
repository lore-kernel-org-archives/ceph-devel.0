From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Question about how rebuild works.
Date: Fri, 6 Nov 2015 06:50:02 -0800
Message-ID: <CAJ4mKGb=ikHAcfuSNSQr8wSh6b78ovfg2Nu2CQBK9uPL9qcd4w@mail.gmail.com>
References: <BY1PR0201MB09044CA844EFDC46E6DA589EE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38265 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbbKFOuE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 09:50:04 -0500
Received: by wmec201 with SMTP id c201so19607866wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 06:50:03 -0800 (PST)
In-Reply-To: <BY1PR0201MB09044CA844EFDC46E6DA589EE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 5, 2015 at 9:59 PM, Allen Samuels <Allen.Samuels@sandisk.co=
m> wrote:
> I have a question about rebuild in the following situation:
>
> I have a pool with 3x replication.
> For one particular PG we'll designate the active OSD set as [1,2,3] w=
ith 1 as the primary.
> Assume 2 and 3 crash with a TOTAL loss of local data.
> 2 restarts, fiddles about and then start the backfill process.
> <A little time passes, here little means enough to make some progress=
 in the rebuild process but nowhere near enough to complete it.
> 3 restarts, fiddles about then starts the backfill process.
>
> My question: Is there any optimization of the fact that we're rebuild=
ing 2 OSDs at the same time (even though the rebuilds didn't start in l=
ock step) OR do the two rebuilds continue independently??

I'm sure Sam will answer definitively, but I believe these are
independent. We don't really have the tracking structures to do
something intelligent and I'm not sure how we'd go about it =E2=80=94 d=
o you
want them to fill in the same data together and then for OSD 3 to go
back and fill in the beginning of the PG that it missed? For OSD 2 to
stop getting data while we bring OSD 3 up to speed and then continue
in lockstep? Something else I'm not thinking of that still makes use
of the sharing?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
