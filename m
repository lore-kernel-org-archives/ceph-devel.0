From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: What will PGs do when the network splits?
Date: Sat, 6 Apr 2013 19:56:42 +0800
Message-ID: <CAAM7YA==3_2F20CXZdNH8Rnua2TzD=gijiS4ObR9x2bwk=zC+A@mail.gmail.com>
References: <CAMm-wcK9TBrR=qgO6__1efeimdN1uHGZsYk_Rfs2VO47U7JqvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:38001 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163315Ab3DFL4o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Apr 2013 07:56:44 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so4200180lab.10
        for <ceph-devel@vger.kernel.org>; Sat, 06 Apr 2013 04:56:42 -0700 (PDT)
In-Reply-To: <CAMm-wcK9TBrR=qgO6__1efeimdN1uHGZsYk_Rfs2VO47U7JqvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Apr 6, 2013 at 1:22 PM, =D4=AC=B6=AC <yuandong1222@gmail.com> w=
rote:
>
> Hi guys.
>
> I have a problem when reading the codes of the ceph.
>
> In the osd.cc, the tick method will check if the mon is timeout by
> compare "now - g_conf->osd_mon_ack_timeout" with last_pg_stats_ack, i=
f
> it's timeout, then monc->reopen_session() will be called to try to
> re-connect to the mon.
>
> The question is that, if the network has splited so that the osd will
> never be able to connect to any mon, how do the PGs on the osd know
> that? I think the PGs may still believe they are heathly with the
> current OSDMap even the mons have already mark their osd down & out
> (but couldn't tell them for the network problem), Then they continue
> to sevice clients who have the same OSDMap with them. So two primary
> PG may exist in the cluster at the same time which is terrible.
>

When OSDs communicate, they check if their OSDMaps match. If not, ODS t=
hat has
newer OSDMap sends OSDMap to ODSs that have old map. To migrate a PG to=
 new
OSDs, the new OSDs need communicate with the old OSDs, so it's
impossible to have
two active PG primaries exist at the same time.

> I want to knwon any code work with this issue or is there some wrong
> with my opinion?
>
> Thanks for any help!
>
>
> --
> =D4=AC=B6=AC
> Email:yuandong1222@gmail.com
> QQ:10200230
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
