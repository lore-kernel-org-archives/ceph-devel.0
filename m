From: Zack Cerza <zack.cerza@inktank.com>
Subject: Re: Running a teuthology workload depending on the distribution
Date: Wed, 3 Sep 2014 15:44:42 -0600
Message-ID: <CAMfdg1Og0RRjR+a4ERtkaQuW2B2BL9FAA6kf3wEAHnCBWKeLfw@mail.gmail.com>
References: <5402FA0E.809@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:48167 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbaICVon convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Sep 2014 17:44:43 -0400
Received: by mail-yh0-f54.google.com with SMTP id b6so5788890yha.27
        for <ceph-devel@vger.kernel.org>; Wed, 03 Sep 2014 14:44:42 -0700 (PDT)
In-Reply-To: <5402FA0E.809@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Sage recently filed these, which seem like they might help with what
you're asking.

http://tracker.ceph.com/issues/9256
http://tracker.ceph.com/issues/9255

I'll be getting to work on them relatively soon, just not quite yet.
In the meantime, would it be feasible to, say, make the relevant task
in the workload check for the presence of the plugin, and immediately
fail if it's not found? That way we can waive those failures, and have
them not use many more resources than necessary.

Zack

On Sun, Aug 31, 2014 at 4:33 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> The isa erasure code plugin is only built on some architectures. The =
workload described at
>
> https://github.com/ceph/ceph-qa-suite/blob/master/erasure-code/ec-rad=
os-plugin%3Disa-k%3D2-m%3D1.yaml
>
> can therefore only be run on those architectures. How would you recom=
mend that it is integrated in the upgrade suites ? Adding it to
>
> https://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/fire=
fly-x/stress-split/9-workload
>
> for instance, at the same level as
>
> https://github.com/ceph/ceph-qa-suite/blob/master/suites/upgrade/fire=
fly-x/stress-split/9-workload/ec-rados-plugin%3Djerasure-k%3D3-m%3D1.ya=
ml
>
> will not work because it will fail when running on precise (for insta=
nce).
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
