From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Whitepaper: database workloads using RBD with dm-cache and Ceph
 cache tiering
Date: Wed, 4 Nov 2015 13:27:14 +1100
Message-ID: <CA+z5Dsy4B_Us3Q0ihmgue45hXtZWRirqrQCYKCZrm_Y9fdY4=A@mail.gmail.com>
References: <4E0B5E66-351F-45EC-96B2-790536D4EE5D@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36533 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbbKDC1f convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 21:27:35 -0500
Received: by obdgf3 with SMTP id gf3so28864597obd.3
        for <ceph-devel@vger.kernel.org>; Tue, 03 Nov 2015 18:27:34 -0800 (PST)
In-Reply-To: <4E0B5E66-351F-45EC-96B2-790536D4EE5D@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Douglas,

It's not clear whether you used SSD journals for the OSDs in the base
config (or in the backing pool for the tiered tests) - it looks like
not?

If that's the case then I don't think this provides the most
interesting point of comparison, because the tests are write-latency
sensitive you'd naturally expect SSD journals to make a lot of
difference and would surely start with those in the base config. I'm
interested in how a similar setup would perform compared to regular
journaling and Ceph tiering all on the server-side, e.g., dm-cache (or
bcache) based OSDs - apparently a bunch of people do this in the wild
with success, but AFAIK there has never been any detailed benchmarking
published.

Cheers,

On 3 November 2015 at 05:09, Douglas Fuller <dfuller@redhat.com> wrote:
> I=E2=80=99ve published a whitepaper detailing configuration and bench=
mark results using SysBench MySQL on top of RBD with dm-cache. Results =
using a Ceph cache tier are also included. Questions, comments, critici=
sm, nitpicking, and/or discussion are welcome.
>
> http://tracker.ceph.com/projects/ceph/wiki/Ceph_and_dm-cache_for_Data=
base_Workloads
>
> =E2=80=94Doug--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Cheers,
~Blairo
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
