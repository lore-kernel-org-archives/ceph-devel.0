From: Kang Wang <beijingwangkang@gmail.com>
Subject: Re: Question about ceph paxos implementation
Date: Tue, 28 Nov 2017 11:20:39 +0800
Message-ID: <A3CDC94E-4353-45F1-86BF-9F334D499EB6@gmail.com>
References: <C3CABE81-22E1-4B8E-AA5A-22CEBF5D45A9@gmail.com>
 <alpine.DEB.2.11.1711271426100.28240@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:46805 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdK1DUr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 22:20:47 -0500
Received: by mail-pf0-f182.google.com with SMTP id q4so18317501pfg.13
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 19:20:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711271426100.28240@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

You mean value =E2=80=982=E2=80=99 wouldn=E2=80=99t be used at the 3rd =
step?

3, Then m2 goes down before send anything to others, then m1, m3 =
recovered and commit value =E2=80=982=E2=80=99 with the quorum m1, m3, =
m4
m1:   1 2
m2:   1 3  down
m3:   1 2
m4:   1 2
m5:   1=09


but as I assume that m2 goes down before it could send  =
MMonPaxos::OP_BEGIN message to others,
so the new leader m1 has no chance to know there exists a newer =
uncommited value =E2=80=983'



Thanks
WANG KANG












> On 27 Nov 2017, at 10:27 PM, Sage Weil <sage@newdream.net> wrote:
>=20
> On Mon, 27 Nov 2017, Kang Wang wrote:
>> hi
>>=20
>> I read the code of ceph paxos recently, and have a question about it, =
which, in my opinion, may violate the consistency.
>>=20
>> Assume we have five monitor node m1, m2, m3, m4, m5, the prior one =
has larger rank than the back one.=20
>>=20
>> Consider the situation as below:
>>=20
>> 1, m1 as the leader, and all node have the same last_commited at =
begin, then m1 propose a new value =E2=80=982', which then be accept by =
m1 and m3:
>> m1:   1 2
>> m2:   1
>> m3:   1 2
>> m4:   1
>> m5:   1=09
>>=20
>> 2, Unfortunatly, both m1 and m3 go down, and m2 become leader without =
knowledge about the propse, and it propose a new value =E2=80=983'=20
>> m1:   1 2  down=20
>> m2:   1 3
>> m3:   1 2  down
>> m4:   1
>> m5:   1=09
>>=20
>> 3, Then m2 goes down before send anything to others, then m1, m3 =
recovered and commit value =E2=80=982=E2=80=99 with the quorum m1, m3, =
m4
>> m1:   1 2
>> m2:   1 3  down
>> m3:   1 2
>> m4:   1 2
>> m5:   1=09
>>=20
>> 4, Before the commit message sent to others, m1 and m3 go down again. =
So value =E2=80=983=E2=80=99 only commit on m1. Then m2 become leader =
once more.
>> m1:   1 2  down
>> m2:   1 3
>> m3:   1 2  down
>> m4:   1 2
>> m5:   1
>>=20
>> 5, Leader m2 see the uncommited value =E2=80=982=E2=80=99, but =
discard it by compare uncommitted_pn in function handle_last, so it =
commit value =E2=80=983=E2=80=99 with the quorum m2, m4, m5
>> m1:   1 2  down
>> m2:   1 3
>> m3:   1 2  down
>> m4:   1 3
>> m5:   1 3
>=20
> This is what the last->uncommitted_pn value is for.  I believe this=20
> prevents us from using 2's pn (and uncommitted value) because 3's pn =
is=20
> larger.  Can you verify?
>=20
> Thanks!
> sage
>=20
>=20
>>=20
>> Now we see the value =E2=80=982=E2=80=99 has been commited, but lost =
soon. Am I right on it?
>>=20
>>=20
>> Thanks
>> WANG KANG
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20

