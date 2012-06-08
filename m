From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 15:36:18 +0200
Message-ID: <4FD1FFD2.6050707@filoo.de>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com> <6535521.l6e0muMKBm@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:37129 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2FHNgU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 09:36:20 -0400
In-Reply-To: <6535521.l6e0muMKBm@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Hi Guido,

yeah, there is something weird going on. I just started to establish=20
some test-VM's. Freshly imported from running *.qcow2 images.
Kernel panic with INIT, seg-faults and other "funny" stuff.

Just added the rbd_cache=3Dtrue in my config, voila. All is=20
fast-n-up-n-running...
All my testing was done with cache enabled... Since our errors all came=
=20
from rbd_writeback from former ceph-versions...

Josh? Sage? Help?!

Oliver.

On 06/08/2012 02:55 PM, Guido Winkelmann wrote:
> Am Donnerstag, 7. Juni 2012, 12:48:05 schrieben Sie:
>> On 06/07/2012 11:04 AM, Guido Winkelmann wrote:
>>> Hi,
>>>
>>> I'm using Ceph with RBD to provide network-transparent disk images =
for
>>> KVM-
>>> based virtual servers. The last two days, I've been hunting some we=
ird
>>> elusive bug where data in the virtual machines would be corrupted i=
n
>>> weird ways. It usually manifests in files having some random data -
>>> usually zeroes - at the start before the actual contents that shoul=
d be
>>> in there start.
>> I definitely want to figure out what's going on with this.
>> A few questions:
>>
>> Are you using rbd caching? If so, what settings?
>>
>> In either case, does the corruption still occur if you
>> switch caching on/off? There are different I/O paths here,
>> and this might tell us if the problem is on the client side.
> Okay, I've tried enabling rbd caching now, and so far, the problem ap=
pears to
> be gone.
>
> I am using libvirt for starting and managing the virtual machines, an=
d what I
> did was change the<source>  element for the virtual disk from
>
> <source protocol=3D'rbd' name=3D'rbd/name_of_image'>
>
> to
>
> <source protocol=3D'rbd' name=3D'rbd/name_of_image:rbd_cache=3Dtrue'>
>
> and then restart the VM.
> (I found that in one of your mails on this list; there does not appea=
r to be
> any proper documentation on this...)
>
> The iotester does not find any corruptions with these settings.
>
> The VM ist still horribly broken, but that's probably lingering files=
ystem
> damage from yesterday. I'll try with a fresh image next.
>
> I did not change anything else in the setup. In particular, the OSDs =
still use
> btrfs. One of the OSD has been restarted, though. I will run another =
test with
> a VM without rbd caching, to make sure it wasn't by random chance res=
tarting
> that one osd that made the real difference.
>
> Enabling btrfs did not appear to make any difference wrt performance,=
 but
> that's probably because my tests mostly create sustained sequential I=
O, for
> which caches are generally not very helpful.
>
> Enabling rbd caching is not a solution I particularly like, for two r=
easons:
>
> 1. In my setup, migrating VMs from one host to another is a normal pa=
rt of
> operation, and I still don't know ho to prevent data corruption (in t=
he form
> of silently lost writes) when combining rbd caching and migration.
>
> 2. I'm not really looking into speeding up single VM, I'm really more
> interested in just how many VMs I can run before performance starts d=
egrading
> for everyone, and I don't think rbd caching will help with that.
>
> Regards,
> 	Guido
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
