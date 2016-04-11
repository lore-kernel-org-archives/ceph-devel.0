From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RBD image name constraints
Date: Mon, 11 Apr 2016 12:37:05 +0300
Message-ID: <20160411093703.GA17959@gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
 <20160408202919.GA8043@gmail.com>
 <570B6436.9040109@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34649 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcDKJhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 05:37:08 -0400
Received: by mail-lf0-f49.google.com with SMTP id j11so148324938lfb.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 02:37:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570B6436.9040109@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>, Josh Durgin <jdurgin@redhat.com>

On Mon, Apr 11, 2016 at 10:45:42AM +0200, Bart=C5=82omiej =C5=9Awi=C4=99=
cki wrote:
>=20
> On 04/08/2016 10:29 PM, Mykola Golub wrote:
> >On Fri, Apr 08, 2016 at 02:23:32PM +0200, Bart=C5=82omiej =C5=9Awi=C4=
=99cki wrote:
> >
> >>In newer versions there's regex that's parsing image name passed to=
 rbd
> >>command (in src/tools/rbd/Utils.cc, function: extract_spec):
> >>
> >>      "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"
> >>
> >>It won't parse pool name with '@', image name with '/' nor snapshot=
 name
> >>with '/', which was allowed in previous implementation based on str=
chr.
> >And I would leave this limitation (if there were no real complains
> >from users) because it could be really difficult to understand what =
a
> >spec that had e.g. two "@" meant.
> Wouldn't that cause backward compatibility issues? I.e. if I've creat=
ed
> image name with '/' inside, I won't be able to do anything with it af=
ter
> upgrading to Jewel, even remove or rename it.
>=20
> >
> >You can still bypass the limitation by using --pool, --image, and
> >--snap options, and I would recommend to always use these in scripts
> >instead of specs.
> >
> True, but even if I specify image name with --image argument it still=
 goes
> through rbd::utils::extract_spec function (or set_pool_image_name in =
old
> code) so there's no way to put there any raw name I want.

Ah, it is rather unfortunate!

I expected that with --image argument you could only specify image
name, but now I see we even have a comment in the code:

    // despite the separate pool and snapshot name options,
    // we can also specify them via the image option

I would prefer if it was possible to specify only image name with
--image argument, but I guess it would cause backward compatibility
issues, so, the simplest solution may be to ease the regexp to:

  "^(?:([^/@]+)/)?([^@]+)(?:@([^@]+))?$" ?

Or may be even:

  "^(?:([^/@]+)/)?([^@]+)(?:@(.+))?$" ?

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
