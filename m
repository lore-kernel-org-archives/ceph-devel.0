From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD image name constraints
Date: Fri, 8 Apr 2016 18:13:58 +0200
Message-ID: <CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36750 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144AbcDHQOA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 12:14:00 -0400
Received: by mail-lf0-f46.google.com with SMTP id g184so82915191lfb.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 09:13:59 -0700 (PDT)
In-Reply-To: <5707A2C4.3030102@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 8, 2016 at 2:23 PM, Bart=C5=82omiej =C5=9Awi=C4=99cki
<bartlomiej.swiecki@corp.ovh.com> wrote:
> Hi,
>
> What are constraints regarding names of RBD images? I tried to look i=
t up
> but without success.

I'm afraid this is something nobody ever paid enough attention to.

>
> My tests show that maximum length is about 4089 bytes and the only fo=
rbidden
> characters are '\0' and '@' but didn't get deep enough into the code =
to
> figure out the length limit. Are my findings correct?

There is an old define in the code base, but it's not enforced:

    #define RBD_MAX_IMAGE_NAME_SIZE 96

The kernel client, however, won't process object requests with names
bigger than 100 chars.  Lifting this limitation wouldn't be hard, but
so far I've only seen this raised once, by Jean-Tiare Le Bigot, also
from OVH.

Currently, with no enforcement from librbd, this comes down to how big
RADOS object names can be, which depends on config options and even the
choice of the data store - in case of ext4, you wouldn't get ~4k, for
example.

>
> I also think I've found a regression introduced in v10.0.1 regarding =
pool /
> image name constraints (introduced in
> fa4e00f8c85603ed202bfef2f3be6086482fbbb2).
>
> In newer versions there's regex that's parsing image name passed to r=
bd
> command (in src/tools/rbd/Utils.cc, function: extract_spec):
>
>     "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"
>
> It won't parse pool name with '@', image name with '/' nor snapshot n=
ame
> with '/', which was allowed in previous implementation based on strch=
r.

"spec" is a combination of pool, image and snapshot names:

    [pool/]image[@snap] # pool and snap are optional

I haven't looked at either of the versions in detail, but you can see
how an image name with a '/' in it is a problem.

Would you mind sharing some details on what you are doing?  If you have
a layer of management software on top, it wouldn't be a bad idea to
restrict things to a basic A-Za-z0-9+=3D or so and 96 chars in length.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
