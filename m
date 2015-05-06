From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: [ceph-users] The first infernalis dev release will be v9.0.0
Date: Wed, 06 May 2015 09:29:05 +0100
Message-ID: <5549D0D1.8020009@suse.de>
References: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>	<5548D1C0.30204@suse.de>	<alpine.DEB.2.00.1505050945230.13336@cobra.newdream.net>	<CADA4hP+aeXmLqv2YGQsG7Hh72ZM8S9D8YTsvVktt22jGdYqTAg@mail.gmail.com>	<alpine.DEB.2.00.1505050951540.13336@cobra.newdream.net> <5ABDA982-178E-4CD0-AF35-D79D064A5D49@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35943 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbbEFI3H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 04:29:07 -0400
In-Reply-To: <5ABDA982-178E-4CD0-AF35-D79D064A5D49@me.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U3RlZmZlbiBXIFPDuHJlbnNlbg==?= <stefws@me.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On 05/05/2015 08:54 PM, Steffen W S=C3=B8rensen wrote:
>=20
>> On 05/05/2015, at 18.52, Sage Weil <sweil@redhat.com> wrote:
>>
>> On Tue, 5 May 2015, Tony Harris wrote:
>>> So with this, will even numbers then be LTS?  Since 9.0.0 is follow=
ing
>>> 0.94.x/Hammer, and every other release is normally LTS, I'm guessin=
g 10.x.x,
>>> 12.x.x, etc. will be LTS...
>>
>> It looks that way now, although I can't promise the pattern will hol=
d!
> I read it like major version is the release ie. Infernails, Jewel etc=
=2E following the letter position in the alfabet, I =3D 9th. letter, so=
 we see all numbers 10,11,12,13=E2=80=A625
> minor numbers =3D 2 will denote LTS eg. <major release>.2.<patch leve=
l>

minor number '2' will denote 'stable', as oposed to 'dev' (minor =3D 0)=
 or
'release candidate' (minor =3D 1).  LTS has been every other major
version; so given Hammer is an LTS and Infernallis is not, then Jewel
would likely be a long term stable.

The point Tony was making is that this cadence, should it be kept as is=
,
would match perfectly with even major versions (jewel 10.x, L-release
12.x, ...).

  -Joao

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
