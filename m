From: David Zafman <david.zafman@inktank.com>
Subject: Re: Can pid be reused ?
Date: Wed, 22 Oct 2014 15:51:29 -0700
Message-ID: <87747DD3-21F2-480E-B61D-91B97237E510@inktank.com>
References: <54471CA6.5040807@dachary.org> <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com> <alpine.DEB.2.00.1410221542450.29946@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60062 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743AbaJVWve convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 18:51:34 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so138732pde.4
        for <ceph-devel@vger.kernel.org>; Wed, 22 Oct 2014 15:51:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410221542450.29946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>


> On Oct 22, 2014, at 3:43 PM, Sage Weil <sage@newdream.net> wrote:
>=20
> On Wed, 22 Oct 2014, David Zafman wrote:
>> I just realized what it is.  The way killall is used when stopping a=
=20
>> vstart cluster, is to kill all processes by name!  You can't stop=20
>> vstarted tests running in parallel.
>=20
> Ah.  FWIW I think we should avoid using stop.sh whenever possible and=
=20
> instead do ./init-ceph stop (which does an orderly shutdown via pid=20
> files).
>=20
> sage

Actually, vstart.sh can=E2=80=99t create 2 independent clusters anyway,=
 so it kills any existing processes.  Probably vstart.sh is what would =
have killed the processes in a parallel make check.

David--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
