From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: Ceph & Cinder & HA
Date: Mon, 10 Nov 2014 11:34:42 +0100
Message-ID: <11F50ACF-55E9-4D2F-AD08-814FE5998089@enovance.com>
References: <545B9A53.4040502@dachary.org> <DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com> <545C927E.9010807@redhat.com> <CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:41633 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbaKJKeq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 05:34:46 -0500
In-Reply-To: <CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Justin Erenkrantz <justin@erenkrantz.com>
Cc: Giulio Fidente <gfidente@redhat.com>, David Moreau Simard <dmsimard@iweb.com>, Loic Dachary <loic@dachary.org>, Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Indeed, that=E2=80=99s what we discussed with Giulio, using HAProxy for=
 the Monitors is a bit overkill since the client is natively able to sw=
itch between different monitor source.

Loic, maybe you can elaborate a bit more on the usage of HAProxy for th=
e monitors?

> On 09 Nov 2014, at 22:54, Justin Erenkrantz <justin@erenkrantz.com> w=
rote:
>=20
> On Fri, Nov 7, 2014 at 4:35 AM, Giulio Fidente <gfidente@redhat.com> =
wrote:
>> The architecture we're considering is as follows:
>>=20
>>  keepalived
>>    haproxy
>>      ceph-mon
>>=20
>> where haproxy and ceph-mon are always up on all openstack 'controlle=
r' nodes
>> (also running cinder) and keepalived is taking care of managing a vi=
rtual ip
>> hosted on one of those
>=20
> For Ceph, you almost certainly don't need to use keepalived or haprox=
y
> as all Ceph clients will fail over to the full set of monitor IPs (yo=
u
> need a way of distributing those IPs to the cluster -
> chef/puppet/ansible/etc/etc can handle that).  Having
> keepalived/haproxy in the loop for ceph-mon is one more thing that
> could break.
>=20
> We do run cinder services behind the controller/headnodes nodes via
> keepalived/haproxy - the "trick" such as it is for Ceph is to set all
> the hostnames in cinder to being the same and it works okay.  See:
>=20
> https://github.com/bloomberg/chef-bcpc/blob/master/cookbooks/bcpc/tem=
plates/default/cinder.conf.erb
>=20
> We haven't seen any issues in an active/active configuration; though
> there are some MySQL schema deadlocks that aren't necessarily related
> to Ceph sitting in Cinder.
>=20
> Cheers.  -- justin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93=20
S=C3=A9bastien Han=20
Cloud Architect=20

"Always give 100%. Unless you're giving blood."

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=C3=A9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
