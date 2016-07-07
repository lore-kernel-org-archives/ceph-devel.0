From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mds jewel backports leak
Date: Thu, 7 Jul 2016 11:54:00 +0100
Message-ID: <CALe9h7fc55ukYR0fPhWwbJ+894S4D2HLBkSmELcC4Bff=EtfLQ@mail.gmail.com>
References: <577CE2B4.6010505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35440 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbcGGKyV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 06:54:21 -0400
Received: by mail-qk0-f173.google.com with SMTP id s126so10702481qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2016 03:54:20 -0700 (PDT)
In-Reply-To: <577CE2B4.6010505@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 6, 2016 at 11:51 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi John,
>
> While testing the CephFS jewel backports found in the jewel-backports=
 branch, we ran into a memory leak that consistently happen:
>
> http://pulpito.ceph.com/loic-2016-06-16_02:28:14-fs-jewel-backports--=
-basic-smithi/263842

The client leak is a false positive, I'm not sure what is triggering
it (it seems to only happen on centos nodes, and not be silenced by
the suppression that we have in the valgrind config).
http://tracker.ceph.com/issues/14794

Is it definitely not happening on the jewel branch, or is it possible
that the jewel run just wasn't executing that test on centos nodes?

The MDS leaks are currently ignored in the ceph.py task (yuck!) so
they're probably happening everywhere else too and you can ignore
them.

John

> and that is not present in the jewel branch
>
> http://pulpito.ceph.com/loic-2016-06-28_23:43:39-fs-jewel---basic-smi=
thi/282493/
>
> Meaning one of the backports is doing something wrong. Or there is a =
backport fixing the leak that is missing.
>
> This one looks interesting to me
>
> https://github.com/ceph/ceph/commit/37b7b09ee19ad64362c2faf63461353c0=
3a36ada
>
> There also are related to leaks but I'm not so sure.
>
> https://github.com/ceph/ceph/commit/89f74c98ea43df46291c8bec890b3a75c=
7ce38b4
> https://github.com/ceph/ceph/commit/4c52bf9ed47d52510536ebc34bd6c56ad=
ba1df53
>
> If you have ideas on how to approach this and save random exploration=
 time, it would be most welcome. If not, I'll get it eventually, no wor=
ries :-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
