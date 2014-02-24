From: Jean-Charles LOPEZ <jc.lopez@inktank.com>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 13:42:50 -0800
Message-ID: <187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net> <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com> <F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44979 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaBXVm4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 16:42:56 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so7117567pbb.17
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 13:42:54 -0800 (PST)
In-Reply-To: <F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: LOPEZ Jean-Charles <jc.lopez@inktank.com>, Weil Sage <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sebastien,

so that=92s great. It=92s already almost done. Let us know when you hav=
e managed updating it.=20

I suppose it would be best if we could offer one image each of the last=
 3 Ceph versions (dumpling, emperor and firefly) so people can then pla=
y with the expected level they are looking for in either test environme=
nt or production environment.

Each of the images would be maintained up to date for the last stable c=
ode base of each version only to reduce time consuming.

What about this?
JC



On Feb 24, 2014, at 13:35, Sebastien Han <sebastien.han@enovance.com> w=
rote:

> FYI I already have a vagrant box ready.
>=20
> http://www.sebastien-han.fr/blog/2013/04/22/play-with-ceph-vagrant-bo=
x/
>=20
> The box just needs to be updated with the last version.
>=20
> Cheers.
> =96=96=96=96=20
> S=E9bastien Han=20
> Cloud Engineer=20
>=20
> "Always give 100%. Unless you're giving blood.=94=20
>=20
> Phone: +33 (0)1 49 70 99 72=20
> Mail: sebastien.han@enovance.com=20
> Address : 10, rue de la Victoire - 75009 Paris=20
> Web : www.enovance.com - Twitter : @enovance=20
>=20
> On 24 Feb 2014, at 21:59, Jean-Charles LOPEZ <jc.lopez@inktank.com> w=
rote:
>=20
>> Hi Sage,
>>=20
>> I think this is a great idea.
>>=20
>> However, I would recommend that two options to be available:
>> 1) First options is a standalone package as you describe it
>> 2) Second option is a prepackaged VM in OVA format people can just d=
ownload and import using VirtualBox, Fusion or VMWarePlayer.
>>=20
>> I can take care of the second option and prepare an OVA for you usin=
g the base I already have.
>>=20
>> JC
>> jc.lopez@inktank.com
>>=20
>>=20
>> On Feb 23, 2014, at 12:30, Sage Weil <sage@inktank.com> wrote:
>>=20
>>> One idea kicking around is to create a simple ceph-standalone packa=
ge that=20
>>> is meant to make it really easy to play around with Ceph.  It would=
:
>>>=20
>>> - depend on all the relevant ceph packages
>>> - install a simple, generic ceph.conf for use on localhost (or perh=
aps=20
>>> whatever /etc/hosts has for our hostname)
>>> - mkfs and start up a mon
>>> - start up an osd (or two?) in /var/lib/ceph (no dedicated disk/vol=
ume)
>>> - start an mds
>>> - add an apache2 site in /etc/apache2/sites-available (or whatever)
>>>=20
>>> The idea would be to do
>>>=20
>>> $ sudo apt-get install ceph-standalone
>>> $ ceph -s
>>> [...]
>>>=20
>>> and have a usable mini-cluster.  That makes it really easy for user=
s to=20
>>> play with the basics, like:
>>>=20
>>> $ mkdir /mnt/ceph
>>> $ sudo ceph-fuse /mnt/ceph
>>>=20
>>> $ rbd create ...
>>> $ rbd map ...
>>>=20
>>> $ curl http://localhost:8000/
>>> <more rgw stuff>
>>>=20
>>> Does this sound useful?  Any takers?
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
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
