From: Stephen Hoogendijk <stephen@tca0.nl>
Subject: Re: problem with ceph admin api
Date: Thu, 01 Oct 2015 09:43:01 +0200
Message-ID: <dc34607fc0b35c46a6cb0834d08d1d56@tca0.nl>
References: <82417e87a21e28acb03e9f352088aaed@tca0.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from s03.tca0.nl ([62.212.93.253]:54243 "EHLO s03.tca0.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbbJAHnC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Oct 2015 03:43:02 -0400
Received: from www-data by s03.tca0.nl with local (Exim 4.82)
	(envelope-from <stephen@tca0.nl>)
	id 1ZhYW5-00036D-6f
	for ceph-devel@vger.kernel.org; Thu, 01 Oct 2015 07:43:01 +0000
In-Reply-To: <82417e87a21e28acb03e9f352088aaed@tca0.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey all,

We are having some problems with the rados gw admin API. We are trying
to list accounts but the API won=E2=80=99t let us.

According to the documentation:
http://docs.ceph.com/docs/master/radosgw/adminops/#get-user-info

A call to /admin/user?format=3Djson should return a list of all the
users. However it will throw a 403 Unauthorized message.

We currently have no way to get a list of all the accounts from the
radosgw-api. Currently there are two options:

"user info --uid=3D<something>"
or
"metadata list user"

The latter will only return the names of the users and the first
doesn=E2=80=99t work unless you provide a uid (even though the document=
ation
tells you something else).

Best regards,
Stephen Hoogendijk

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
