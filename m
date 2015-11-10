From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-users] Permanent MDS restarting under load
Date: Tue, 10 Nov 2015 12:38:08 -0800
Message-ID: <CAJ4mKGYODLhtU6MfKCbWJsPYxKC2qcf0NJ9MBDd4XHYjF6_RWg@mail.gmail.com>
References: <0bde8c53b6e2bbdffbe5f470e6d08076@natalenko.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37589 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbKJUiJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 15:38:09 -0500
Received: by wmww144 with SMTP id w144so17449939wmw.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 12:38:08 -0800 (PST)
In-Reply-To: <0bde8c53b6e2bbdffbe5f470e6d08076@natalenko.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 10, 2015 at 6:32 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Hello.
>
> We have CephFS deployed over Ceph cluster (0.94.5).
>
> We experience constant MDS restarting under high IOPS workload (e.g.
> rsyncing lots of small mailboxes from another storage to CephFS using
> ceph-fuse client). First, cluster health goes to HEALTH_WARN state wi=
th the
> following disclaimer:
>
> =3D=3D=3D
> mds0: Behind on trimming (321/30)
> =3D=3D=3D
>
> Also, slow requests start to appear:
>
> =3D=3D=3D
> 2 requests are blocked > 32 sec
> =3D=3D=3D

Which requests are they? Are these MDS operations or OSD ones?

>
> Then, after a while, one of MDSes fails with the following log:
>
> =3D=3D=3D
> =D0=BB=D0=B8=D1=81 10 16:07:41 baikal bash[10122]: 2015-11-10 16:07:4=
1.915540 7f2484f13700
> -1 MDSIOContextBase: blacklisted!  Restarting...
> =D0=BB=D0=B8=D1=81 10 16:07:41 baikal bash[10122]: starting mds.baika=
l at :/0
> =D0=BB=D0=B8=D1=81 10 16:07:42 baikal bash[10122]: 2015-11-10 16:07:4=
2.003189 7f82b477e7c0
> -1 mds.-1.0 log_to_monitors {default=3Dtrue}
> =3D=3D=3D

So that "blacklisted" means that the monitors decided the MDS was
nonresponsive, failed over to another daemon, and blocked this one off
from the cluster.

> I guess writing lots of small files bloats MDS log, and MDS doesn't c=
atch
> trimming in time. That's why it is marked as failed and is replaced b=
y
> standby MDS. We tried to limit mds_log_max_events to 30 events, but t=
hat
> caused MDS to fail very quickly with the following stacktrace:
>
> =3D=3D=3D
> Stacktrace: https://gist.github.com/4c8a89682e81b0049f3e
> =3D=3D=3D
>
> Is that normal situation, or one could rate-limit client requests? Ma=
y be
> there should be additional knobs to tune CephFS for handling such a
> workload?

Yeah, the MDS doesn't really do a good job back-pressuring clients
right now when it or the OSDs aren't keeping up with the workload.
That's something we need to work on once fsck stuff is behaving. rsync
is also (sadly) a workload that frequently exposes these problems, but
I'm not used to seeing the MDS daemon get stuck quite that quickly.
How frequently is it actually getting swapped?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
