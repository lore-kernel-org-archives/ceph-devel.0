From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: subuser of radosgw
Date: Thu, 12 Jan 2012 16:39:51 -0800
Message-ID: <CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
References: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47046 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab2AMAjw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 19:39:52 -0500
Received: by ghbg16 with SMTP id g16so647189ghb.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 16:39:52 -0800 (PST)
In-Reply-To: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2012 at 4:27 PM, huang jun <hjwsm1989@gmail.com> wrote:
>
> hi,all
> =A0 when i use radosgw+s3, there are two werid things:
> =A0 1) =A0we can use the command "raodsgw_admin subuser create =A0--s=
ubuser
> =3D"a1" =A0-i 8" to create a subuser named "a1" under a user whoes us=
er_id
> is 8.
> =A0 =A0 =A0 =A0and also can create many subusers under one single use=
r.
> =A0 can we give the specified subuser =A0permission to visit a specif=
ied bucket?

Not at the moment, though we can probably add that easily. You can,
however, give the subuser a reduced access permission to whatever the
main user has (e.g., read-only access, read-write only with no access
control, etc.)

> =A0 so what do subusers do here?

Subuser is used currently for Swift, where you can create a few users
under a single account.

> =A0 2) we can create many access-key and secret-keys for an user, do =
we
> need so many keys?
>
That's up to you. You may want to use a key per service, and if one
key is compromised, or if there's a need to replace it you can revoke
only that key, while other services can continue using their keys.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
