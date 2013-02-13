From: Daniel Hoang <daniel_m_hoang@yahoo.com>
Subject: Questions on some minor issues when upgrading from 0.48 to 0.56
Date: Wed, 13 Feb 2013 11:26:01 -0800 (PST)
Message-ID: <1360783561.14929.YahooMailNeo@web162602.mail.bf1.yahoo.com>
Reply-To: Daniel Hoang <daniel_m_hoang@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm12-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.140]:42207 "HELO
	nm12-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754606Ab3BMTcg convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Feb 2013 14:32:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Hi All,

Just in case these issues have not been reported yet, I am on=A0ubuntu =
12.04, upgrade librados2/librados-dev from 0.48 to 0.56, and I notice t=
he following issues:

1. librados2 / librados-dev still reports minor version as 48

Should minor version changed to 56?

2. In 0.48, rados_pool_list(cluster, NULL, 0) can be used like a buffer=
 size query, and it would return the buffer size required for the pool =
list buffer string. In 0.56, this call now returns=A0error -22 instead,=
 and=A0I have to pass in a tmp_buf[32] and len =3D 32 in order for the =
call to return successfully. I check the current rados_pool_list API, a=
nd it does not mention anything about buffer and len should not be NULL=
, 0.=A0

May be this was a bug in 0.48, that we should not pass in NULL, 0 ?

Thanks for your help,
DanielH

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
