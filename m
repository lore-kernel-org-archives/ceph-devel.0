From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Just noticed this with ceph-0.43 - ceph-0.39 does not have this
 issue. I'm trying to use Ceph on multiple platforms, one of which is CentOS
 5. CentOS 5 still uses Python 2.4, and byte-compilation o
Date: Tue, 20 Mar 2012 15:38:02 -0700
Message-ID: <CACLRD_1drOhMwMYe-6SFGF9MU8VHSR5rk3zz8b=HnSy6fNnpAA@mail.gmail.com>
References: <4F68A57802000099000DD35F@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52289 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758901Ab2CTWiE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 18:38:04 -0400
Received: by wejx9 with SMTP id x9so472369wej.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 15:38:03 -0700 (PDT)
In-Reply-To: <4F68A57802000099000DD35F@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I believe the with statement came in python 2.5.  It would need to be
converted to use the older style.
-Sam

On Tue, Mar 20, 2012 at 2:42 PM, Nick Couchman <Nick.Couchman@seakr.com=
> wrote:
> Just noticed this with ceph-0.43 - ceph-0.39 does not have this issue=
=2E =C2=A0I'm trying to use Ceph on multiple platforms, one of which is=
 CentOS 5. =C2=A0CentOS 5 still uses Python 2.4, and byte-compilation o=
f the rados.py file fails during the build of ceph 0.43 with the follow=
ing error:
>
> Byte-compiling python modules...
> rados.py =C2=A0File "/usr/lib/python2.4/site-packages/rados.py", line=
 422
> =C2=A0 =C2=A0with self.lock:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
> SyntaxError: invalid syntax
>
> A quick Google search doesn't turn up anything obviously wrong with t=
his statement - just that Python 2.4 may not support this? =C2=A0Is the=
re anything that can be done to make this block of code (Ioctx, some of=
 the aio stuff) compatible with Python 2.4?
>
> Thanks - Nick
>
>
>
> --------
> This e-mail may contain confidential and privileged material for the =
sole use of the intended recipient. =C2=A0If this email is not intended=
 for you, or you are not responsible for the delivery of this message t=
o the intended recipient, please note that this message may contain SEA=
KR Engineering (SEAKR) Privileged/Proprietary Information. =C2=A0In suc=
h a case, you are strictly prohibited from downloading, photocopying, d=
istributing or otherwise using this message, its contents or attachment=
s in any way. =C2=A0If you have received this message in error, please =
notify us immediately by replying to this e-mail and delete the message=
 from your mailbox. =C2=A0Information contained in this message that do=
es not relate to the business of SEAKR is neither endorsed by nor attri=
butable to SEAKR.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
