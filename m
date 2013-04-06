From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Fwd: What will PGs do when the network splits?
Date: Sat, 6 Apr 2013 20:24:35 +0800
Message-ID: <CAMm-wcLyVvHsDNZR6-juO57UqyMVKV4xiMNP4vBKzRFKYGOpQA@mail.gmail.com>
References: <CAMm-wcK9TBrR=qgO6__1efeimdN1uHGZsYk_Rfs2VO47U7JqvA@mail.gmail.com>
	<CAAM7YAk6s9mfQvAH25ddVSA73s76Qhv4g=6C7xnPQBM78G8ouQ@mail.gmail.com>
	<CAMm-wcJX+Tcwr+2XAiVtQMPjOfO7=4HtDg8eMQd39YtmtJxMrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:37103 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422814Ab3DFMYg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Apr 2013 08:24:36 -0400
Received: by mail-vc0-f181.google.com with SMTP id ia10so14492vcb.12
        for <ceph-devel@vger.kernel.org>; Sat, 06 Apr 2013 05:24:35 -0700 (PDT)
In-Reply-To: <CAMm-wcJX+Tcwr+2XAiVtQMPjOfO7=4HtDg8eMQd39YtmtJxMrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for help.

I know that process, but it can't avoid my problem while the new OSDs
can't reach the old OSDs because of the network problem, so there is
actually no one could tell the old PGs that they are not primary
anymore.

Think about the following scene:

There are two rooms A and B with 10 osds for each room, and 3 mons in
room A. The replicas are in the same room with their primay (That can
be implemented by CRUSH). When the network between room A and B is
broken. How does the PGs on OSDs in the room B know about that?

I think when a new PG wants to become primay, it must talk with the
old primay PG, so there will never be two same primay PG at the same
time, but with the network problem, the commucaiton between the old
and new primay PGs is impossible. Under this situation what will the
new primay do? or they will never become Active?

In other distributed system lease may be used for these issue, but I
don't find any codes about that.

I hope there is something wrong with my opinion.

Thank you again.

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



--
=D4=AC=B6=AC
Email:yuandong1222@gmail.com
QQ:10200230


--
=D4=AC=B6=AC
Email:yuandong1222@gmail.com
QQ:10200230
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
