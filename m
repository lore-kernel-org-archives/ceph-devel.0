From: Loic Dachary <loic@dachary.org>
Subject: Re: Backporting stability fixes for ceph-disk
Date: Thu, 4 Feb 2016 12:18:01 +0700
Message-ID: <56B2DF09.30107@dachary.org>
References: <56B04476.5020203@redhat.com>
 <CALqRxCyTk5NPQJE7PTX4txbCPB2eagMBvH+V9HLHXkir4hij4g@mail.gmail.com>
 <56B2509A.6090709@dachary.org>
 <CALqRxCwsz5527AFZw9sPT+W0fW66p58iToz_x7Syc8H1C38O_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33268 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719AbcBDFSK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 00:18:10 -0500
In-Reply-To: <CALqRxCwsz5527AFZw9sPT+W0fW66p58iToz_x7Syc8H1C38O_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/02/2016 10:13, Ken Dreyer wrote:
> On Wed, Feb 3, 2016 at 12:10 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> On 04/02/2016 00:56, Ken Dreyer wrote:
>>> What's the procedure for deactivating the Hammer udev rules, for ex=
ample?
>>
>> rm /lib/udev/rules.d/*ceph*
>> udevadm control --reload # maybe superfluous
>>
>=20
> I am surprised to see that we'd want to delete files from /lib. How
> would the user restore them afterwards?=20

re-installing the ceph package that contains them will restore them.

> Sorry if this sounds dense;
> I'm definitely a udev noob. Could you provide a "starting from
> scratch" procedure for how to handle ceph-disk failures in Hammer?

My own bias is to understand why things go wrong before fixing them, wh=
ich can be complicated when udev / initsystem / ceph-disk are involved.=
 To this date I would still not be able to write a guide explaining how=
 to do that reliably. Only recently did I discover that messages that s=
hould be in syslog could be discarded entirely on RHEL, unless the abrt=
 package is installed. After which you have to know to collect the outp=
ut from a file that is referenced in the syslog messages but not in the=
 messages themselves.

If there is a suspicion that udev / initsystem / ceph-disk is not doing=
 the right thing with hammer and understanding why is secondary, I woul=
d recommend removing the udev rules and doing things manually as sugges=
ted in the previous mail. Whenever there is a problem, it's usually not=
 because individual components are at fault, it's because they race wit=
h each other in ways that were not fully understood back in hammer.

The most frequent mistake is thinking that more partprobe / partx is be=
tter and fixes things. It's actually the opposite: when the udev rules =
are in play, running more partprobe / partx will create new udev events=
 that will race with those already in flight (see http://tracker.ceph.c=
om/issues/14099 for instance). It can do even worse: partprobe /dev/sdb=
 will remove existing partitions before adding them again, to be extra =
sure the kernel has an accurate view of the partition table. I let you =
imagine what that can do on a live system. partx does not have that pro=
blem but that's because it assumes the caller knows exactly what inform=
ation the kernel has about the partition table. That leads to confusing=
 situations when, for instance, a partition is added, partx called to n=
otify the kernel which fires a udev event, partition is deleted and the=
 caller fails to notify the kernel. If the same partition is added agai=
n, partx notifies the kernel which does nothing instead of firing a ude=
v ev
 e
nt because the partition still exists from its point of view.

In hammer partprobe was not consistently guarded against such races (it=
's enough to udevadm settle ; partprobe ; udevadm settle but that was n=
ot done consistently) and had to call partprobe / partx more than once,=
 for instance right after a journal partition was created and before cr=
eating the data partition. Calls to partprobe and udevadm settle also n=
eed to be more patient than the default, specially when dmcrypt is in p=
lay. What it means in practice is that ceph-disk must call udevadm sett=
le --timeout=3D600 and call partprobe a few times before declaring fail=
ure (there is no user control over the partprobe timeout). The ceph-dis=
k suite routinely shows partprobe try two or three times at 60 seconds =
intervals before succeeding (this is extreme because it happens in a cl=
oud environment where performances vary a lot).

All these trouble go away if udev is deactivated because partprobe won'=
t run ceph-disk indirectly. The timeout issue may still be a concern bu=
t I think that in real life situations, if ceph-disk prepare is done fi=
rst and a separate script does the ceph-disk activate-all, the odds tha=
t ceph-disk activate fails because a partprobe run by ceph-disk prepare=
 did not complete are very low. An automated script could do:

ceph-disk prepare /dev/sdb
ceph-disk prepare /dev/sdc
ceph-disk prepare /dev/sdd
=2E..
udevadm settle --timeout=3D600
ceph-disk activate /dev/sdb1
ceph-disk activate /dev/sdc1
ceph-disk activate /dev/sdd1
=2E..

I hope that clarifies the situation ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
