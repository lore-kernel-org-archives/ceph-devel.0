From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 14:35:16 +0200
Message-ID: <50474704.2000800@widodh.nl>
References: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58857 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251Ab2IEMfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 08:35:20 -0400
In-Reply-To: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 09/05/2012 11:30 AM, Alexandre DERUMIER wrote:
>>> Proxmox doesn't use libvirt, does it?
> Yes, we don't use libvirt.
>
>>> Any plans to implement the RBD caching?
>
> It's already implemented (cache=3Dwriteback), patched qemu-kvm 1.1. (=
and qemu-kvm 1.2 is coming in the next days)
>
> Tunning of cache size can be done with a /etc/ceph.conf file
>

That is kind of dangerous imho and for a couple of reasons.

=46or configuring the storage you have /etc/pve/storage.cfg where you c=
an=20
add the RBD pool, configure the monitors and cephx, but for caching you=
=20
rely in librbd reading ceph.conf?

That is hidden from the user, reading /etc/ceph/ceph.conf will go=20
without your knowledge. I'd opt for passing down all the options to Qem=
u=20
and being able to run without a ceph.conf

I've ran into the same problems with libvirt and CloudStack. I couldn't=
=20
figure out why libvirt was still able to connect to a specific cluster=20
until I found out my ceph.conf was still in place.

I also thought it is on the roadmap to not read /etc/ceph/ceph.conf by=20
default with librbd/librados to take away these kind of issues.

And you would also have this weird situation where the ceph.conf could=20
have a couple of monitor entries and your "storage.cfg", how will that=20
work out?

I would try not to rely on the ceph.conf at all and have Proxmox pass=20
all the configuration options down to Qemu.

Wido

>
>
> ----- Mail original -----
>
> De: "Wido den Hollander" <wido@widodh.nl>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 5 Septembre 2012 11:11:27
> Objet: Re: rbd 0.48 storage support for kvm proxmox distribution avai=
lable
>
> On 09/05/2012 06:31 AM, Alexandre DERUMIER wrote:
>> Hi List,
>>
>> We have added rbd 0.48 support to the proxmox 2.1 kvm distribution
>> http://www.proxmox.com/products/proxmox-ve
>>
>>
>> Proxmox setup:
>>
>> edit the /etc/pve/storage.cfg and add the configuration (gui creatio=
n is not available yet)
>>
>> rbd: mycephcluster
>> monhost 192.168.0.1:6789;192.168.0.2:6789;192.168.0.3:6789
>> pool rbd
>> username admin
>> authsupported cephx;none
>> content images
>>
>
> Proxmox doesn't use libvirt, does it?
>
> Any plans to implement the RBD caching?
>
> Nice work though!
>
> Wido
>
>>
>> then you need to copy the keyring file from ceph to proxmox
>>
>> scp cephserver1:/etc/ceph/client.admin.keyring /etc/pve/priv/ceph/my=
cephcluster.keyring
>>
>>
>>
>> For now, you can add/delete/resize rbd volumes from gui.
>> Snapshots/cloning will be added soon (when layering will be availabl=
e)
>>
>>
>> Regards,
>>
>> Alexandre Derumier
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
