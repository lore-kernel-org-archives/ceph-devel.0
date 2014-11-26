From: Wenjunh <huangwenjun310@gmail.com>
Subject: OSD Crash for xattr "_" absent issue.
Date: Wed, 26 Nov 2014 20:47:36 +0800
Message-ID: <F02A2640-E908-4025-BB2F-7C34C87A3B66@gmail.com>
References: <0F08B7A5-1669-4B6F-B7C1-F53478D409D4@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:56078 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaKZMrm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Nov 2014 07:47:42 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so2745531pdj.35
        for <ceph-devel@vger.kernel.org>; Wed, 26 Nov 2014 04:47:41 -0800 (PST)
Received: from seawatermine-lm.peking.corp.yahoo.com (corp-nat.peking.corp.yahoo.com. [117.104.188.144])
        by mx.google.com with ESMTPSA id yp5sm3407852pbb.16.2014.11.26.04.47.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 04:47:41 -0800 (PST)
In-Reply-To: <0F08B7A5-1669-4B6F-B7C1-F53478D409D4@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> Hi, Samuel & Sage
>=20
> In our current production environment, there exists osd crash because=
 of the inconsistence of data, when reading the =E2=80=9C_=E2=80=9D xat=
tr. Which is described in the issue:
>=20
> http://tracker.ceph.com/issues/10117.
>=20
> And I also find a two year=E2=80=99s old issue, which also describes =
the same bug:
>=20
> http://tracker.ceph.com/issues/3676.
>=20
> I think there is a apparent flaw in the related code. Could you help =
to review my last comment describing the way to fix the bug.
>=20
> I prefer the second way, we just delete the object if we can=E2=80=99=
t get the =E2=80=9C_=E2=80=9D xattr, instead of crashing the osd, and t=
he object has two other replicas, which can serve the client=E2=80=99s =
request.
> And when the next time self-healing process(scrub, deep scrub) occurs=
, the object can recover from its peer.
>=20
> Because I am not so proficient of the source code, I don=E2=80=99t kn=
ow if the repairing way has any other side effects on the ceph cluster.
>=20
> If you have any idea about the bug, please feel free to let me know.
>=20
> Thanks
>=20
> Wenjunh
>=20
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
