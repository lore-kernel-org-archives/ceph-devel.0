From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: RBD image name constraints
Date: Fri, 8 Apr 2016 23:29:20 +0300
Message-ID: <20160408202919.GA8043@gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33679 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbcDHU3Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 16:29:25 -0400
Received: by mail-lf0-f41.google.com with SMTP id e190so88885152lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 13:29:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5707A2C4.3030102@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 08, 2016 at 02:23:32PM +0200, Bart=C5=82omiej =C5=9Awi=C4=99=
cki wrote:

> In newer versions there's regex that's parsing image name passed to r=
bd=20
> command (in src/tools/rbd/Utils.cc, function: extract_spec):
>=20
>      "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"
>=20
> It won't parse pool name with '@', image name with '/' nor snapshot n=
ame=20
> with '/', which was allowed in previous implementation based on strch=
r.

And I would leave this limitation (if there were no real complains
from users) because it could be really difficult to understand what a
spec that had e.g. two "@" meant.

You can still bypass the limitation by using --pool, --image, and
--snap options, and I would recommend to always use these in scripts
instead of specs.

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
