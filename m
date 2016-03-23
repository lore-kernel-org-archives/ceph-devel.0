From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Wed, 23 Mar 2016 01:03:06 +0100
Message-ID: <56F1DD3A.4000902@dachary.org>
References: <alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>
 <20160302010625.GA10914@onthe.net.au> <1456913706999.87255@croc.ru>
 <56D6CF42.7080909@dachary.org> <20160310000006.GA14061@onthe.net.au>
 <20160316232029.GA22451@onthe.net.au>
 <011EEA5C-6A6B-489B-AB20-6EDEE2F55AFE@ebay.com>
 <20160317014314.GA25617@onthe.net.au> <20160322224923.GA31017@onthe.net.au>
 <56F1D1D3.8070207@dachary.org> <20160322233932.GA32084@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35914 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcCWADN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 20:03:13 -0400
In-Reply-To: <20160322233932.GA32084@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Nathan Cutler <ncutler@suse.cz>, M Ranga Swami Reddy <swamireddy@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Chris,

On 23/03/2016 00:39, Chris Dunlop wrote:
> Hi Lo=C3=AFc,
>=20
> On Wed, Mar 23, 2016 at 12:14:27AM +0100, Loic Dachary wrote:
>> On 22/03/2016 23:49, Chris Dunlop wrote:
>>> Hi Stable Release Team for v0.94,
>>>
>>> Let's try again... Any news on a release of v0.94.6 for debian whee=
zy (bpo70)?
>>
>> I don't think publishing a debian wheezy backport for v0.94.6 is pla=
nned. Maybe it's a good opportunity to initiate a community effort ? Wo=
uld you like to work with me on this ?
>=20
> It's my understanding, from statements by both Sage and yourself, tha=
t
> existing OS'es would continue to be supported in the stable series, e=
=2Eg.:
>=20
>  On Wed, Mar 02, 2016 at 06:32:18PM +0700, Loic Dachary wrote:
>  > I think you misread what Sage wrote : "The intention was to contin=
ue
>  > building stable releases (0.94.x) on the old list of supported pla=
tforms
>  > (which inclues 12.04 and el6)". In other words, the old OS'es are =
still
>  > supported. Their absence is a glitch in the release process that w=
ill be
>  > fixed.
>=20
> "The old OS'es" that were being supported up to v0.94.5 includes debi=
an
> wheezy. It would be quite surprising and unexpected to drop support f=
or an
> OS in the middle of a stable series.

I'm unsure if wheezy is among the old OS'es. It predates my involvement=
 in the stable releases effort. I know for sure el6 and 12.04 are suppo=
rted for 0.94.x.=20

> If that is indeed what's happening, and it's not just an oversight, I=
'd
> prefer to put my efforts into moving to a supported OS rather than ke=
eping
> the older OS on life support.

That makes sense. Should you change your mind, I'll be around to help.

> Just to be clear, I understand it is quite a burden maintaining relea=
ses for
> old OSes, I'm only voicing mild surprise and a touch of regret: I'm v=
ery
> happy with the Ceph project!

I'm hopefull we'll be able to support more OS in the future, both with =
a lightweight release process and more community support. The Ceph rele=
ases should scale out, just as Ceph does ;-)

Cheers
>=20
> Cheers,
>=20
> Chris,
> OnTheNet
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
