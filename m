From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 18 Jan 2016 13:21:16 +0100
Message-ID: <20160118122116.GH26972@suse.de>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
 <20151215142304.GI31644@suse.de>
 <CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
 <alpine.DEB.2.00.1512161431530.10312@cobra.newdream.net>
 <CAHMeWhHfiakLOJ6BDosXm1P1GDA0TR-pYt+UpZOeQJv4LFYtXA@mail.gmail.com>
 <CAHMeWhHn-8dD_5+1zDizBijwwMZNS7K9ukHk_y_EQQxjKgM88g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48705 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbcARMVS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jan 2016 07:21:18 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 4230BAD8D
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 12:21:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHMeWhHn-8dD_5+1zDizBijwwMZNS7K9ukHk_y_EQQxjKgM88g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-01-18T09:05:58, Adam Kupczyk <akupczyk@mirantis.com> wrote:

Hi Adam,

> Plugging this into calculations I was using previously, gives us:
> 1) Dmcrypt:
> 1*0.36+2.5*0.64*3 =3D 5.16 bytes of crypto operations per byte of io =
data.
> 2) potential inside OSD encryption
> 1*0.36+1*0.64 =3D 1 byte of crypto operations per byte of io data.
>=20
> This further deepens my concern that crypto transformations may be
> limit for performance.

I see your concern, but my primary concern is not about performance,
rather security.

By not encrypting the entire OSD device, one becomes susceptible to
metadata analysis (on the file store), data exposure, etc. (Plus,
obviously, that the system devices need to be encrypted to avoid data
leaks via logs, swap, coredumps etc.)

It doesn't help my use case that your implementation is theoretically
faster if it doesn't fit the threat scenario.

I'd obviously be delighted to see this all sped up (and consume less
power), but as long as the system is fast enough to encrypt at
near-device speeds, this seems preferable.

I'm not opposed to your implementation - I just couldn't sell it to my
customers for data-at-rest encryption.


Regards,
    Lars

--=20
Architect Storage/HA
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,=
 HRB 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wil=
de

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
