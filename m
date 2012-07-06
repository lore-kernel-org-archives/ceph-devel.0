From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] librados: Bump the version to 0.48
Date: Fri, 06 Jul 2012 10:52:49 +0200
Message-ID: <4FF6A761.8090002@widodh.nl>
References: <1341409564-26660-1-git-send-email-wido@widodh.nl> <6ED535BAF3394911BDF4F16441761D6A@inktank.com> <Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net> <CAPYLRzjNhhWzmFyOkz+cDsFsZbZA4iP9bVG8ACWY5LP20wMYtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:35767 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2GFJTL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 05:19:11 -0400
In-Reply-To: <CAPYLRzjNhhWzmFyOkz+cDsFsZbZA4iP9bVG8ACWY5LP20wMYtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org



On 07/06/2012 12:33 AM, Gregory Farnum wrote:
> On Wed, Jul 4, 2012 at 9:33 AM, Sage Weil <sage@inktank.com> wrote:
>> On Wed, 4 Jul 2012, Gregory Farnum wrote:
>>> Hmmm =FF=FF we generally try to modify these versions when the API =
changes,
>>> not on every sprint. It looks to me like Sage added one function in=
 0.45
>>> where we maybe should have bumped it, but that was a long time ago =
and
>>> at this point we should maybe just eat it?
>>
>> Yeah, I went ahead and applied this to stable (argonaut) since it's =
as
>> good a reference point as any.  Moving forward, we should try to syn=
c
>> this up with API changes as they happen.  Hmm, like that assert
>> ObjectOperation that just went into master...
>
> Yep, should probably bump it to .49 then! (Since that's the version i=
t
> will be part of, and nobody will get confused and try to bump it agai=
n
> before that release.)
>
>
> On Thu, Jul 5, 2012 at 12:26 AM, Wido den Hollander <wido@widodh.nl> =
wrote:
>> That was my reasoning. I compiled phprados against 0.48 and saw that
>> librados was reporting 0.44 as version.
>>
>> That could confuse users and they might think they still have an old=
 library
>> in place.
>>
>> Imho the version numbering should be totally different from Ceph if =
you only
>> want to bump the version on an API change.
>
> Well, the problem with bumping it on every Ceph version is that it
> becomes a lot harder for tools to sync up to a known version of the
> API. Perhaps we should have divorced it from the Ceph versioning
> completely, but I don't know if we can still do that in a reasonable
> way or not. :/

You could always say: 0.48 was the "stable" release, from here on we ar=
e=20
only going to bump the librados version if any API change happends.

Sent out an e-mail on the devel list and write a blogpost? I don't thin=
k=20
we have a lot of developers using native librados at the moment.

Wido

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
