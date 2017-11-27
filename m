From: Kang Wang <beijingwangkang@gmail.com>
Subject: Question about ceph paxos implementation
Date: Mon, 27 Nov 2017 21:14:05 +0800
Message-ID: <C3CABE81-22E1-4B8E-AA5A-22CEBF5D45A9@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41161 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdK0NOO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 08:14:14 -0500
Received: by mail-pl0-f50.google.com with SMTP id u14so8455264plm.8
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 05:14:14 -0800 (PST)
Received: from [10.18.60.96] ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id m3sm44883664pgs.12.2017.11.27.05.14.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 05:14:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

I read the code of ceph paxos recently, and have a question about it, =
which, in my opinion, may violate the consistency.

Assume we have five monitor node m1, m2, m3, m4, m5, the prior one has =
larger rank than the back one.=20

Consider the situation as below:

1, m1 as the leader, and all node have the same last_commited at begin, =
then m1 propose a new value =E2=80=982', which then be accept by m1 and =
m3:
m1:   1 2
m2:   1
m3:   1 2
m4:   1
m5:   1=09

2, Unfortunatly, both m1 and m3 go down, and m2 become leader without =
knowledge about the propse, and it propose a new value =E2=80=983'=20
m1:   1 2  down=20
m2:   1 3
m3:   1 2  down
m4:   1
m5:   1=09

3, Then m2 goes down before send anything to others, then m1, m3 =
recovered and commit value =E2=80=982=E2=80=99 with the quorum m1, m3, =
m4
m1:   1 2
m2:   1 3  down
m3:   1 2
m4:   1 2
m5:   1=09

4, Before the commit message sent to others, m1 and m3 go down again. So =
value =E2=80=983=E2=80=99 only commit on m1. Then m2 become leader once =
more.
m1:   1 2  down
m2:   1 3
m3:   1 2  down
m4:   1 2
m5:   1

5, Leader m2 see the uncommited value =E2=80=982=E2=80=99, but discard =
it by compare uncommitted_pn in function handle_last, so it commit value =
=E2=80=983=E2=80=99 with the quorum m2, m4, m5
m1:   1 2  down
m2:   1 3
m3:   1 2  down
m4:   1 3
m5:   1 3

Now we see the value =E2=80=982=E2=80=99 has been commited, but lost =
soon. Am I right on it?


Thanks
WANG KANG

=20=
