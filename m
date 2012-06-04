From: Hannes Reinecke <hare@suse.de>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 10:02:10 +0200
Message-ID: <4FCC6B82.9080609@suse.de>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com> <4FCC5431.6070002@suse.de> <4FCC6328.3020606@profihost.ag> <4FCC6644.8010106@suse.de> <4FCC6963.7090202@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51113 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab2FDICL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jun 2012 04:02:11 -0400
In-Reply-To: <4FCC6963.7090202@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/04/2012 09:53 AM, Stefan Priebe - Profihost AG wrote:
> Am 04.06.2012 09:39, schrieb Hannes Reinecke:
>> On 06/04/2012 09:26 AM, Stefan Priebe - Profihost AG wrote:
>>> Am 04.06.2012 08:22, schrieb Hannes Reinecke:
>>>> Hehe.
>>>> Good luck with that.
>>>>
>>>> We've tried on 10GigE with _disastrous_ results.
>>>> Up to the point where 1GigE was actually _faster_.
>>>
>>> So you mean you've tried 10GBE or 10GB ipoib with Infiniband?
>=20
> Could you please answer this question too? Thx.
>=20
This was plain 10GigE, ie TCP/IP. Not infiniband, I'm afraid.

However, given that our problems have not been related to the actual
transport I'd be very much surprised if they would not occur on
Infiniband.

And I would _definitely_ like to hear if someone managed to get any
decent speed (notably write speed) on fast interconnects.
There's always a chance we've messed things up and were just
measuring our crap setup ...

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
