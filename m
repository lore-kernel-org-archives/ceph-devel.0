From: Marek Dohojda <mdohojda@altitudedigital.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Tue, 4 Aug 2015 10:52:35 -0600
Message-ID: <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com> <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38682 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbHDQwg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:52:36 -0400
Received: by iggf3 with SMTP id f3so15317995igg.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 09:52:36 -0700 (PDT)
In-Reply-To: <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: =?utf-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

I have done this not that long ago.  My original PG estimates were wron=
g and I had to increase them. =20

After increasing the PG numbers the Ceph rebalanced, and that took a wh=
ile.  To be honest in my case the slowdown wasn=E2=80=99t really visibl=
e, but it took a while. =20

My strong suggestion to you would be to do it in a long IO time, and be=
 prepared that this willl take quite a long time to accomplish.  Do it =
slowly  and do not increase multiple pools at once.=20

It isn=E2=80=99t recommended practice but doable.



> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust@redhat.com> wrote:
>=20
> It will cause a large amount of data movement.  Each new pg after the
> split will relocate.  It might be ok if you do it slowly.  Experiment
> on a test cluster.
> -Sam
>=20
> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleqi=
ao@gmail.com> wrote:
>> Hi Cephers,
>>=20
>> This is a greeting from Jevon. Currently, I'm experiencing an issue =
which
>> suffers me a lot, so I'm writing to ask for your comments/help/sugge=
stions.
>> More details are provided bellow.
>>=20
>> Issue:
>> I set up a cluster having 24 OSDs and created one pool with 1024 pla=
cement
>> groups on it for a small startup company. The number 1024 was calcul=
ated per
>> the equation 'OSDs * 100'/pool size. The cluster have been running q=
uite
>> well for a long time. But recently, our monitoring system always com=
plains
>> that some disks' usage exceed 85%. I log into the system and find ou=
t that
>> some disks' usage are really very high, but some are not(less than 6=
0%).
>> Each time when the issue happens, I have to manually re-balance the
>> distribution. This is a short-term solution, I'm not willing to do i=
t all
>> the time.
>>=20
>> Two long-term solutions come in my mind,
>> 1) Ask the customers to expand their clusters by adding more OSDs. B=
ut I
>> think they will ask me to explain the reason of the imbalance data
>> distribution. We've already done some analysis on the environment, w=
e
>> learned that the most imbalance part in the CRUSH is the mapping bet=
ween
>> object and pg. The biggest pg has 613 objects, while the smallest pg=
 only
>> has 226 objects.
>>=20
>> 2) Increase the number of placement groups. It can be of great help =
for
>> statistically uniform data distribution, but it can also incur signi=
ficant
>> data movement as PGs are effective being split. I just cannot do it =
in our
>> customers' environment before we 100% understand the consequence. So=
 anyone
>> did this under a production environment? How much does this operatio=
n affect
>> the performance of Clients?
>>=20
>> Any comments/help/suggestions will be highly appreciated.
>>=20
>> --
>> Best Regards
>> Jevon
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
