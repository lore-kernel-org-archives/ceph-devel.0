From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: What will PGs do when the network splits?
Date: Sat, 6 Apr 2013 20:44:08 +0800
Message-ID: <CAMm-wc+voaekO8D=6rPks3dgSMxsNcdWwOO+xx589XS5YQ_nqw@mail.gmail.com>
References: <CAMm-wcK9TBrR=qgO6__1efeimdN1uHGZsYk_Rfs2VO47U7JqvA@mail.gmail.com>
	<CAAM7YAk6s9mfQvAH25ddVSA73s76Qhv4g=6C7xnPQBM78G8ouQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:61995 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422842Ab3DFMoJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Apr 2013 08:44:09 -0400
Received: by mail-ve0-f179.google.com with SMTP id cz11so4204484veb.24
        for <ceph-devel@vger.kernel.org>; Sat, 06 Apr 2013 05:44:08 -0700 (PDT)
In-Reply-To: <CAAM7YAk6s9mfQvAH25ddVSA73s76Qhv4g=6C7xnPQBM78G8ouQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Oh... I think I find the answer.

New primay can't become Active without communcating with the old
primay or at least one old replica. Instead, the new primay will enter
InComplete state which does not provide service. so the old primary
can provide services safely because it can still reach all its
replicas.

On the other hand if the network splits between the primary and its
replicas, new primary could become Active. But the old primary
couldn't provide service anymore for it has lost its replicas, so the
new primary can become Active safely.

That is, for the following two scene:
1, the primay is partitioned from its replicas
2, the primay and all its replicas are partitioned from the mons
There will alway be only one Active primay for the same PG.

Am I right?


On 6 April 2013 19:54, Yan, Zheng <ukernel@gmail.com> wrote:
> On Sat, Apr 6, 2013 at 1:22 PM, =D4=AC=B6=AC <yuandong1222@gmail.com>=
 wrote:
>>
>> Hi guys.
>>
>> I have a problem when reading the codes of the ceph.
>>
>> In the osd.cc, the tick method will check if the mon is timeout by
>> compare "now - g_conf->osd_mon_ack_timeout" with last_pg_stats_ack, =
if
>> it's timeout, then monc->reopen_session() will be called to try to
>> re-connect to the mon.
>>
>> The question is that, if the network has splited so that the osd wil=
l
>> never be able to connect to any mon, how do the PGs on the osd know
>> that? I think the PGs may still believe they are heathly with the
>> current OSDMap even the mons have already mark their osd down & out
>> (but couldn't tell them for the network problem), Then they continue
>> to sevice clients who have the same OSDMap with them. So two primary
>> PG may exist in the cluster at the same time which is terrible.
>
>
> When OSDs communicate, they check if their OSDMaps match. If not, ODS=
 that
> has
> newer OSDMap sends OSDMap to ODSs that have old map. To migrate a PG =
to new
> OSDs, the new OSDs need communicate with the old OSDs, so it's imposs=
ible to
> have
> two active PG primaries exist at the same time.
>
>
>>
>>
>> I want to knwon any code work with this issue or is there some wrong
>> with my opinion?
>>
>> Thanks for any help!
>>
>>
>> --
>> =D4=AC=B6=AC
>> Email:yuandong1222@gmail.com
>> QQ:10200230
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



--=20
=D4=AC=B6=AC
Email:yuandong1222@gmail.com
QQ:10200230
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
