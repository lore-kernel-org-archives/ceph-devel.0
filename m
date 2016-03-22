From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: [ceph-users] v0.94.6 Hammer released
Date: Wed, 23 Mar 2016 10:39:32 +1100
Message-ID: <20160322233932.GA32084@onthe.net.au>
References: <alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>
 <20160302010625.GA10914@onthe.net.au>
 <1456913706999.87255@croc.ru>
 <56D6CF42.7080909@dachary.org>
 <20160310000006.GA14061@onthe.net.au>
 <20160316232029.GA22451@onthe.net.au>
 <011EEA5C-6A6B-489B-AB20-6EDEE2F55AFE@ebay.com>
 <20160317014314.GA25617@onthe.net.au>
 <20160322224923.GA31017@onthe.net.au>
 <56F1D1D3.8070207@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:37000 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcCVXjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 19:39:35 -0400
Content-Disposition: inline
In-Reply-To: <56F1D1D3.8070207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Nathan Cutler <ncutler@suse.cz>, M Ranga Swami Reddy <swamireddy@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Lo=C3=AFc,

On Wed, Mar 23, 2016 at 12:14:27AM +0100, Loic Dachary wrote:
> On 22/03/2016 23:49, Chris Dunlop wrote:
>> Hi Stable Release Team for v0.94,
>>=20
>> Let's try again... Any news on a release of v0.94.6 for debian wheez=
y (bpo70)?
>=20
> I don't think publishing a debian wheezy backport for v0.94.6 is plan=
ned. Maybe it's a good opportunity to initiate a community effort ? Wou=
ld you like to work with me on this ?

It's my understanding, from statements by both Sage and yourself, that
existing OS'es would continue to be supported in the stable series, e.g=
=2E:

 On Wed, Mar 02, 2016 at 06:32:18PM +0700, Loic Dachary wrote:
 > I think you misread what Sage wrote : "The intention was to continue
 > building stable releases (0.94.x) on the old list of supported platf=
orms
 > (which inclues 12.04 and el6)". In other words, the old OS'es are st=
ill
 > supported. Their absence is a glitch in the release process that wil=
l be
 > fixed.

"The old OS'es" that were being supported up to v0.94.5 includes debian
wheezy. It would be quite surprising and unexpected to drop support for=
 an
OS in the middle of a stable series.

If that is indeed what's happening, and it's not just an oversight, I'd
prefer to put my efforts into moving to a supported OS rather than keep=
ing
the older OS on life support.

Just to be clear, I understand it is quite a burden maintaining release=
s for
old OSes, I'm only voicing mild surprise and a touch of regret: I'm ver=
y
happy with the Ceph project!

Cheers,

Chris,
OnTheNet
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
