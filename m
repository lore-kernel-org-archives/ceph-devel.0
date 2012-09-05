From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 07:47:27 -0700
Message-ID: <98d1cf0435798ed2bd11fa95c406766b@hq.newdream.net>
References: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro>
 <50474704.2000800@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:36141 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2IEOrA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 10:47:00 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 8A17B78310
	for <ceph-devel@vger.kernel.org>; Wed,  5 Sep 2012 07:47:00 -0700 (PDT)
In-Reply-To: <50474704.2000800@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Wed, 05 Sep 2012 14:35:16 +0200, Wido den Hollander <wido@widodh.nl>
wrote:
> On 09/05/2012 11:30 AM, Alexandre DERUMIER wrote:
>>>> Proxmox doesn't use libvirt, does it?
>> Yes, we don't use libvirt.
>>
>>>> Any plans to implement the RBD caching?
>>
>> It's already implemented (cache=3Dwriteback), patched qemu-kvm 1.1. =
(and qemu-kvm 1.2 is coming in the next days)
>>
>> Tunning of cache size can be done with a /etc/ceph.conf file
>>
>=20
> That is kind of dangerous imho and for a couple of reasons.
>=20
> For configuring the storage you have /etc/pve/storage.cfg where you
> can add the RBD pool, configure the monitors and cephx, but for
> caching you rely in librbd reading ceph.conf?
>=20
> That is hidden from the user, reading /etc/ceph/ceph.conf will go
> without your knowledge. I'd opt for passing down all the options to
> Qemu and being able to run without a ceph.conf
>=20
> I've ran into the same problems with libvirt and CloudStack. I
> couldn't figure out why libvirt was still able to connect to a
> specific cluster until I found out my ceph.conf was still in place.
>=20
> I also thought it is on the roadmap to not read /etc/ceph/ceph.conf
> by default with librbd/librados to take away these kind of issues.

I don't think we'll want to change the default behavior (qemu reading
/etc/ceph/ceph.conf) for backwards compatibility, but I agree that we
should avoid relying on it in the future.

Josh

> And you would also have this weird situation where the ceph.conf
> could have a couple of monitor entries and your "storage.cfg", how
> will that work out?
>=20
> I would try not to rely on the ceph.conf at all and have Proxmox pass
> all the configuration options down to Qemu.
>=20
> Wido
>=20
>>
>>
>> ----- Mail original -----
>>
>> De: "Wido den Hollander" <wido@widodh.nl>
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Mercredi 5 Septembre 2012 11:11:27
>> Objet: Re: rbd 0.48 storage support for kvm proxmox distribution ava=
ilable
>>
>> On 09/05/2012 06:31 AM, Alexandre DERUMIER wrote:
>>> Hi List,
>>>
>>> We have added rbd 0.48 support to the proxmox 2.1 kvm distribution
>>> http://www.proxmox.com/products/proxmox-ve
>>>
>>>
>>> Proxmox setup:
>>>
>>> edit the /etc/pve/storage.cfg and add the configuration (gui creati=
on is not available yet)
>>>
>>> rbd: mycephcluster
>>> monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789
>>> pool rbd
>>> username admin
>>> authsupported cephx;none
>>> content images
>>>
>>
>> Proxmox doesn't use libvirt, does it?
>>
>> Any plans to implement the RBD caching?
>>
>> Nice work though!
>>
>> Wido
>>
>>>
>>> then you need to copy the keyring file from ceph to proxmox
>>>
>>> scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/m=
ycephcluster.keyring
>>>
>>>
>>>
>>> For now, you can add/delete/resize rbd volumes from gui.
>>> Snapshots/cloning will be added soon (when layering will be availab=
le)
>>>
>>>
>>> Regards,
>>>
>>> Alexandre Derumier
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
