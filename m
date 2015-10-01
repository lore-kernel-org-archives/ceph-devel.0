From: Stephen Hoogendijk <stephen@tca0.nl>
Subject: problem with ceph admin api
Date: Thu, 01 Oct 2015 09:30:17 +0200
Message-ID: <82417e87a21e28acb03e9f352088aaed@tca0.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from s03.tca0.nl ([62.212.93.253]:54330 "EHLO s03.tca0.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbbJAIJN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Oct 2015 04:09:13 -0400
Received: from www-data by s03.tca0.nl with local (Exim 4.82)
	(envelope-from <stephen@tca0.nl>)
	id 1ZhYJl-0002uK-MS
	for ceph-devel@vger.kernel.org; Thu, 01 Oct 2015 07:30:17 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey all,

We are having some problems with the rados gw admin API. We are trying=20
to list accounts but the API won=E2=80=99t let us.

According to the documentation:
http://docs.ceph.com/docs/master/radosgw/adminops/#get-user-info

A call to /admin/user?format=3Djson should return a list of all the use=
rs.=20
However it will throw a 403 Unauthorized message.

We currently have no way to get a list of all the accounts from the=20
radosgw-api. Currently there are two options:

"user info --uid=3D<something>"
or
"metadata list user"

The latter will only return the names of the users and the first doesn=E2=
=80=99t=20
work unless you provide a uid (even though the documentation tells you=20
something else).


--=20
Best regards,
Stephen Hoogendijk
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
