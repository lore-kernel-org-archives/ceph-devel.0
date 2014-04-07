From: Gregory Farnum <greg@inktank.com>
Subject: Re: Deterministic thrashing
Date: Mon, 7 Apr 2014 09:55:12 -0700
Message-ID: <CAPYLRzh4LhWS5VE8yur=5uQUB_T5F66VHeXNkgj+j_LCBTE1eA@mail.gmail.com>
References: <53412C8E.2070504@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51158 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbaDGQzN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Apr 2014 12:55:13 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so6583407qcr.25
        for <ceph-devel@vger.kernel.org>; Mon, 07 Apr 2014 09:55:12 -0700 (PDT)
In-Reply-To: <53412C8E.2070504@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This would be really nice but there are unfortunately even more
hiccups than you've noted here:
1) Thrashing is both time and disk access sensitive, and hardware diffe=
rs
2) The teuthology thrashing is triggered largely based on PG state
events (eg, "all PGs are clean, so restart an OSD")
3) The actual failures tend to involve a combination of PG state and
inbound client operations, and I can't think of any realistic way to
coordinate those.

Those problems look technically insurmountable to me, but maybe I'm
missing something?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sun, Apr 6, 2014 at 3:29 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> It would be nice to have a way to replay the random events injected b=
y stanzas such as
>
> - thrashosds:
>     chance_pgnum_grow: 2
>     chance_pgpnum_fix: 1
>
> When a teuthology workload (such as tracker.ceph.com/issues/7914#note=
-34) crashes once a week and the error is not obvious, it would increas=
e the probability to reproduce the crash. Instead of the "trashosds" we=
 could have something like "recorded-trashosds: trashosd.events" and in=
stead of being random they would happen more deterministically (same nu=
mber of events and same number of seconds between events ?).
>
> I realize this is non trivial to implement but maybe someone already =
thought about that and has a better idea ?
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
