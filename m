From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] librados: Bump the version to 0.48
Date: Thu, 5 Jul 2012 15:33:39 -0700
Message-ID: <CAPYLRzjNhhWzmFyOkz+cDsFsZbZA4iP9bVG8ACWY5LP20wMYtQ@mail.gmail.com>
References: <1341409564-26660-1-git-send-email-wido@widodh.nl>
	<6ED535BAF3394911BDF4F16441761D6A@inktank.com>
	<Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39115 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab2GEWdk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 18:33:40 -0400
Received: by lbbgm6 with SMTP id gm6so13657256lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 15:33:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, Jul 4, 2012 at 9:33 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 4 Jul 2012, Gregory Farnum wrote:
>> Hmmm =FF=FF we generally try to modify these versions when the API c=
hanges,
>> not on every sprint. It looks to me like Sage added one function in =
0.45
>> where we maybe should have bumped it, but that was a long time ago a=
nd
>> at this point we should maybe just eat it?
>
> Yeah, I went ahead and applied this to stable (argonaut) since it's a=
s
> good a reference point as any. =A0Moving forward, we should try to sy=
nc
> this up with API changes as they happen. =A0Hmm, like that assert
> ObjectOperation that just went into master...

Yep, should probably bump it to .49 then! (Since that's the version it
will be part of, and nobody will get confused and try to bump it again
before that release.)


On Thu, Jul 5, 2012 at 12:26 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> That was my reasoning. I compiled phprados against 0.48 and saw that
> librados was reporting 0.44 as version.
>
> That could confuse users and they might think they still have an old =
library
> in place.
>
> Imho the version numbering should be totally different from Ceph if y=
ou only
> want to bump the version on an API change.

Well, the problem with bumping it on every Ceph version is that it
becomes a lot harder for tools to sync up to a known version of the
API. Perhaps we should have divorced it from the Ceph versioning
completely, but I don't know if we can still do that in a reasonable
way or not. :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
