From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: global backfill reservation?
Date: Sat, 03 Jun 2017 05:44:33 +0800
Message-ID: <EDDE2F49-5651-4518-B9A0-3A1F7ECF7F90@alibaba-inc.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <CALZt5jxT8WvD9hiPVf_YUy3pxWR3pgHW0ZiQo2+YyeiB=Jya_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-250.mail.aliyun.com ([140.205.0.250]:54904 "EHLO
        out0-250.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBVo5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 17:44:57 -0400
In-Reply-To: <CALZt5jxT8WvD9hiPVf_YUy3pxWR3pgHW0ZiQo2+YyeiB=Jya_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Agree with what Ning said in terms of Ceph cluster=E2=80=99s user expectation. Th=
e recovery/backfill even scrub should be scheduled dynamically based on SLA =
and cluster resources.

Regards,
James

On 5/20/17, 7:24 AM, "Ning Yao" <ceph-devel-owner@vger.kernel.org on behalf=
 of zay11022@gmail.com> wrote:

    I think the most efficient way to solve this problem is not to
    restrict the number of backfilling pgs.  The reason why they want to
    reduce backfilling pgs at the same time is because this is the only
    thing we can do in Ceph currently. As David mentioned above, reducing
    the active backfilling pgs at a time will increase the total recovery
    time, which in turn leads to lower reliability and increase the data
    loss probability.
   =20
    Actually, for end-users, they do not care what happens in the ceph
    backend. They wanna if there is enough bandwidth, then recover my data
    as fast as possible. But at the same time, they want the user IO is
    served first. That means if the cluster has 10GB/s, 100k iops IO
    bandwidth, at night, user IO cost 20% bandwidth so that 80% bandwidth
    for recovery, while at daytime, user IO cost 80% bandwidth  so that
    20% bandwidth for recovery. so it seems pretty reasonable to do it
    with dynamic QoS strategy and serve the user IO first at anytime. Only
    in this way, it can achieve the final goal for this issue.
   =20
    Therefore
    Regards
    Ning Yao
   =20
   =20
    2017-05-13 2:53 GMT+08:00 Sage Weil <sweil@redhat.com>:
    > A common complaint is that recovery/backfill/rebalancing has a high
    > impact.  That isn't news.  What I realized this week after hearing mo=
re
    > operators describe their workaround is that everybody's workaround is
    > roughly the same: make small changes to the crush map so that only a =
small
    > number of PGs are backfilling at a time.  In retrospect it seems obvi=
ous,
    > but the problem is that our backfill throttling is per-OSD: the "slow=
est"
    > we can go is 1 backfilling PG per OSD.  (Actually, 2.. one primary an=
d one
    > replica due to separate reservation thresholds to avoid deadlock.)  T=
hat
    > means that every OSD is impacted.  Doing fewer PGs doesn't make the
    > recovery vs client scheduling better, but it means it affects fewer P=
Gs
    > and fewer client IOs and the net observed impact is smaller.
    >
    > Anyway, in short, I think we need to be able to set a *global* thresh=
old
    > of "no more than X % of OSDs should be backfilling at a time," which =
is
    > impossible given the current reservation appoach.
    >
    > This could be done naively by having OSDs reserve a slot via the mon =
or
    > mgr.  If we only did it for backfill the impact should be minimal (th=
ose
    > are big slow long-running operations already).
    >
    > I think you can *almost* do it cleverly by inferring the set of PGs t=
hat
    > have to backfill by pg_temp.  However, that doesn't take any priority=
 or
    > stuck PGs into consideration.
    >
    > Anyway, the naive thing probably isn't so bad...
    >
    > 1) PGMap counts backfilling PGs per OSD (and then the number of OSDs =
with
    > one or more backfilling PGs).
    >
    > 2) For the first step of the backfill (recovery?) reservation, OSDs a=
sk
    > the mgr for a reservation slot.  The reservation is (pgid,interval ep=
och)
    > so that the mgr can throw out the reservation require without needing=
 an
    > explicit cancellation if there is an interval change.
    >
    > 3) mgr grants as many reservations as it can without (backfilling +
    > grants) > whatever the max is.
    >
    > We can set the max with a global tunable like
    >
    >  max_osd_backfilling_ratio =3D .3
    >
    > so that only 30% of the osds can be backfilling at once?
    >
    > sage
    > --
    > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
    > the body of a message to majordomo@vger.kernel.org
    > More majordomo info at  http://vger.kernel.org/majordomo-info.html
    --
    To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
   =20


