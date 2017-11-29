From: Kang Wang <beijingwangkang@gmail.com>
Subject: Re: Question about ceph paxos implementation
Date: Wed, 29 Nov 2017 14:54:21 +0800
Message-ID: <C6E61660-A60B-4A6B-A4EA-E620D60144AD@gmail.com>
References: <C3CABE81-22E1-4B8E-AA5A-22CEBF5D45A9@gmail.com>
 <alpine.DEB.2.11.1711271426100.28240@piezo.novalocal>
 <A3CDC94E-4353-45F1-86BF-9F334D499EB6@gmail.com>
 <alpine.DEB.2.11.1711281302400.19791@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33099 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdK2Gy2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 01:54:28 -0500
Received: by mail-pg0-f41.google.com with SMTP id g7so1105482pgs.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 22:54:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711281302400.19791@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

You are right, Sage=20

I have lost sight of that the uncommited_pn would be replaced by the new =
accept_pn
when uncommitted_value being re-proposed.

Thanks again and I rewrote the scenario for anyone who may have a same =
question below.
For simplicity, I used a increasing integer indicated pn,
branket for commited value and parens for uncommited.


1, m1 as the leader, and all node have the same last_commited at begin, =
then m1 propose a new value =E2=80=982', which then be accept by m1 and =
m3:
m1:   [1, pn=3D123]   (2, pn=3D123)
m2:   [1, pn=3D123]=20
m3:   [1, pn=3D123]   (2, pn=3D123)
m4:   [1, pn=3D123]=20
m5:   [1, pn=3D123]  =09

2, Unfortunatly, both m1 and m3 go down, and m2 become leader without =
knowledge about the propse, and it propose a new value =E2=80=983'=20
m1:   [1, pn=3D123]   (2, pn=3D123)  down=20
m2:   [1, pn=3D123]   (3, pn=3D124)
m3:   [1, pn=3D123]   (2, pn=3D123)  down
m4:   [1, pn=3D123]=20
m5:   [1, pn=3D123]=09

3, Then m2 goes down before send anything to others, then m1, m3 =
recovered and commit value =E2=80=982=E2=80=99 with the quorum m1, m3, =
m4
m1:   [1, pn=3D123]   [2, pn=3D125]=20
m2:   [1, pn=3D123]   (3, pn=3D124)  down
m3:   [1, pn=3D123]   (2, pn=3D125)=20
m4:   [1, pn=3D123]   (2, pn=3D125)=20
m5:   [1, pn=3D123]

4, Before the commit message sent to others, m1 and m3 go down again. So =
value =E2=80=983=E2=80=99 only commit on m1. Then m2 become leader once =
more.
m1:   [1, pn=3D123]   [2, pn=3D125]   down
m2:   [1, pn=3D123]   (3, pn=3D124)
m3:   [1, pn=3D123]   (2, pn=3D125)  down
m4:   [1, pn=3D123]   (2, pn=3D125)=20
m5:   [1, pn=3D123]

5, Leader m2 see the uncommited value =E2=80=982=E2=80=99, with larger =
pn than =E2=80=983', so it re-propse value =E2=80=982=E2=80=99 with a =
newer pn
m1:   [1, pn=3D123]   [2, pn=3D125]   down
m2:   [1, pn=3D123]   [2, pn=3D126]
m3:   [1, pn=3D123]   (2, pn=3D125)  down
m4:   [1, pn=3D123]   [2, pn=3D126]=20
m5:   [1, pn=3D123]   [2, pn=3D126]


> On 28 Nov 2017, at 9:06 PM, Sage Weil <sage@newdream.net> wrote:
>=20
>=20

