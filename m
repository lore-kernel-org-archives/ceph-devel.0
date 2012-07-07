From: Alex Elder <elder@inktank.com>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Fri, 06 Jul 2012 19:16:40 -0500
Message-ID: <4FF77FE8.9040408@inktank.com>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50867 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab2GGAQn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 20:16:43 -0400
Received: by obbuo13 with SMTP id uo13so15921257obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 17:16:43 -0700 (PDT)
In-Reply-To: <4FF705BA.4080501@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 07/06/2012 10:35 AM, Yann Dupont wrote:
> Le 06/07/2012 10:31, Yann Dupont a =E9crit :
>> Hello.
>>
>> Bug happens in rbd client, at least in Kernel 3.4.4 . I have a
>> completely reproductible bug.
> just a note : 3.2.22 doesn't seems to exhibit the problem. I repeated
> the process 2 times without problems on this kernel.

There are a number of bugs that have been fixed since Linux 3.4,
and the fixes have not made it into the 3.4.y stable releases.

I just sent an announcement about the Ceph stable branch that's
available in the Ceph git repository.  If possible I would
recommend you try using that for 3.4 testing.  The branch is here:

    http://github.com/ceph/ceph-client/tree/linux-3.4.4-ceph

If you do have troubles I would very much like to hear about it.
And if you don't run into the problems you've been seeing that
would be good to know as well.

					-Alex

> I'll launch realistic load on our ceph volume this week end (bacula
> backups). I'll see if 3.2.22 is solid.
>=20
> Then monday or tuesday I'll take the git bisect route to see which pa=
tch
> introduced the problem.
>=20
> Cheers,
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
