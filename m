From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Ceph & Cinder & HA
Date: Fri, 7 Nov 2014 11:08:45 +0100
Message-ID: <3373FCF2-0D72-431F-8627-63AFA8B44527@enovance.com>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com> <A6E8431B-9D66-4545-96A9-56E2C27AB9ED@iweb.com> <545C974A.2090609@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:45486 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaKGKIi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 05:08:38 -0500
In-Reply-To: <545C974A.2090609@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giulio Fidente <gfidente@redhat.com>
Cc: David Moreau Simard <dmsimard@iweb.com>, Loic Dachary <loic@dachary.org>, Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

How do you envision the HAProxy setup?
I=92m in the dev room, we can discuss that.

HAProxy is a good idea but you need to be careful on how you monitor th=
e ceph-mon.

> On 07 Nov 2014, at 10:56, Giulio Fidente <gfidente@redhat.com> wrote:
>=20
> On 11/07/2014 10:50 AM, David Moreau Simard wrote:
>> Giulio,
>>=20
>> Right. The volume part is tricky because the volume is ultimately ti=
ed to one cinder-volume instance.
>> I don't have a magic solution for that yet.
>=20
> yep but this can be worked around by customizing the host=3D setting =
in Cinder so all instances of cinder-volume look like a single 'host'
>=20
> this was discussed with Cinder guy here, which I am in touch with too=
, and is known to expose some issues due to multiple cinder-volume inst=
ances potentially trying to get access to the same volume when multiple=
 tasks are queued ... yet this is 'known stuff' and they are already wo=
rking on a 'state machine' for Cinder which will fix the a/a scenario
>=20
> until then, the idea is to deploy cinder-volume in a a/p scenario, ye=
t customizing the host=3D setting
> --=20
> Giulio Fidente
> GPG KEY: 08D733BA | IRC: giulivo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers.
=96=96=96=96=20
S=E9bastien Han=20
Cloud Architect=20

"Always give 100%. Unless you're giving blood."

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
