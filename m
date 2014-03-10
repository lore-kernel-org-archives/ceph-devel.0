From: David Moreau Simard <dmsimard@iweb.com>
Subject: Re: Ceph Puppet modules (again)
Date: Mon, 10 Mar 2014 18:27:05 +0000
Message-ID: <8DCDD03F-3796-4D2D-813D-A4338C921C68@iweb.com>
References: <CAPUexz9vuQ7Z91i8wwR1d9heuvkmTp9=q4GSRkNZaMV2M4Tz1Q@mail.gmail.com>
 <62443690-E16C-4322-A5D7-6C91C84CED6C@iweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmx1.iweb.com ([70.38.127.135]:36871 "EHLO bmx1.iweb.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbaCJS1H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 14:27:07 -0400
In-Reply-To: <62443690-E16C-4322-A5D7-6C91C84CED6C@iweb.com>
Content-Language: en-US
Content-ID: <FB6B42B43843A847BD6D09D6517DF252@corp.iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The initial plan was to stop the fragmentation and centralize efforts i=
n the stackforge module. I think we were all able to agree on that.
We=92ve had rather long discussions on the mailing list (https://groups=
=2Egoogle.com/a/puppetlabs.com/forum/#!topic/puppet-openstack/ibnrmXBAx=
Vg) and eventually drafted a blueprint:https://wiki.openstack.org/wiki/=
Puppet-openstack/ceph-blueprint

As far as licensing goes, Enovance=92s puppet-ceph was told to become A=
pache2 to make it easier to pull code from their version of puppet-ceph=
 and it=92s many forks and branches (including DTAG=92s).
As far as I can remember, Sebastien Han told me they had agreed with th=
eir contributors to change the license to Apache2 but I have not seen t=
hat happening.

I for one welcomed the stackforge initiative but have had limited resou=
rces to actually contribute new code only recently.
I provide insight and reviews currently.

David Moreau Simard

> On Mar 10, 2014, at 12:21 PM, Florian Haas <florian@hastexo.com> wrot=
e:
>=20
>> Hi,
>>=20
>> Somehow I'm thinking I'm opening a can of worms, but here it goes
>> anyway. I saw some discussion about this here on this list last
>> (Northern Hemisphere) autumn, but not much since.
>>=20
>> I'd like to ask for some clarification on the current state of the
>> Ceph Puppet modules. Currently there are several: one on StackForge
>> (http://git.openstack.org/cgit/stackforge/puppet-ceph/), primarily
>> written by Lo=EFc Dachary, and one on the eNovance GitHub repo
>> (https://github.com/enovance/puppet-ceph), written by S=E9bastien Ha=
n
>> and Fran=E7ois Charlier. The eNovance repo is AGPL licensed, which I
>> find rather incomprehensible =97 the only thing this would make sens=
e
>> for would be to force providers of *public* Puppet hosts to contribu=
te
>> back upstream, but that's a really far fetched use case. The
>> StackForge repo is ASL licensed, which looks a bit saner.
>>=20
>> Then there is a TelekomCloud fork of the eNovance repo at
>> https://github.com/TelekomCloud/puppet-ceph/tree/rc/eisbrecher, with
>> 55 unmerged patches. Also AGPL, as far as I can tell.
>>=20
>> And finally there's puppet-cephdeploy
>> (https://github.com/dontalton/puppet-cephdeploy) where I like that i=
t
>> builds upon ceph-deploy, but rather dislike that it's rather closely
>> interwoven with OpenStack. ASL.
>>=20
>> Finally, after the discussion that Lo=EFc kicked off in
>> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg16673.htm=
l,
>> there's https://github.com/ceph/puppet-ceph which hasn't seen any
>> updates in 2 months. This is a mirror of the StackForge module, as f=
ar
>> as I can tell, is ASL licensed and has seen neither the eNovance wor=
k
>> nor the TelekomCloud updates, presumably on account of the license
>> issue.
>>=20
>> Neither repo seems to be universally accepted and fully complete
>> (StackForge only supports mon deployment; eNovance doesn't do radosg=
w,
>> for example), so I'm trying to understand where people should best
>> direct their efforts to get things to a working state.
>>=20
>> All thoughts and comments appreciated. Thanks!
>>=20
>> Cheers,
>> Florian
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
