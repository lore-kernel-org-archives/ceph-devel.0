From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 13:48:42 +0200
Message-ID: <50585F9A.7030301@smart-weblications.de>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com> <5057BAD0.8080201@smart-weblications.de> <CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com> <alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:52658 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757311Ab2IRLtP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Sep 2012 07:49:15 -0400
In-Reply-To: <alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tren Blackburn <tren@eotnetworks.com>, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 18.09.2012 04:32, schrieb Sage Weil:
> On Mon, 17 Sep 2012, Tren Blackburn wrote:
>> On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
>> Wiessner <f.wiessner@smart-weblications.de> wrote:
>>>
>>> Hi,
>>>
>>> i use ceph to provide storage via rbd for our virtualization cluste=
r delivering
>>> KVM based high availability Virtual Machines to my customers. I als=
o use it
>>> as rbd device with ocfs2 on top of it for a 4 node webserver cluste=
r as shared
>>> storage - i do this, because unfortunatelly cephfs is not ready yet=
 ;)
>>>
>> Hi Florian;
>>
>> When you say "cephfs is not ready yet", what parts about it are not
>> ready? There are vague rumblings about that in general, but I'd love
>> to see specific issues. I understand multiple *active* mds's are not
>> supported, but what other issues are you aware of?
>=20
> Inktank is not yet supporting it because we do not have the QA in pla=
ce=20
> and general hardening that will make us feel comfortable recommending=
 it=20
> for customers.  That said, it works pretty well for most workloads.  =
In=20
> particular, if you stay away from the snapshots and multi-mds, you sh=
ould=20
> be quite stable.
>=20
> The engineering team here is about to do a bit of a pivot and refocus=
 on=20
> the file system now that the object store and RBD are in pretty good=20
> shape.  That will mean both core fs/mds stability and features as wel=
l as=20
> integration efforts (NFS/CIFS/Hadoop).
>=20
> 'Ready' is in the eye of the beholder.  There are a few people using =
the=20
> fs successfully in production, but not too many.
>=20

I tried it using multiple mds, because without multiple mds there is no
redundancy and the single mds will be SPOF. I noticed things like empty
directories which could not be deleted. It said directory not empty, bu=
t it was
empty and could not be deleted. I also noticed kernel panic on 3.2 kern=
els using
kernel ceph client, or crashes with ceph-fuse. It is somewhat unstable =
so that i
always had to reboot a node after a while of usage for various reasons
(ceph-fuse crashed and messed up fuse, kernel panic using kernel ceph c=
lient,
unable to delete files/dirs, no fsck for fixing things).

Last time i tried was simple untarring kernel tree in cephfs mountpoint=
 - a new
created cephfs and after 10 minutes there where errors like unable to d=
elete
dirs etc. Since i do not know how to reset/reformat only the cephfs par=
t
(without touching rbd!), i stopped testing for now. The last time i tri=
ed it i
lost data - the data was not important and i had backups, but i was fee=
ling
uncomfortable now with using cephfs...

I also did not have tried btrfs with ceph since 11/2011 again, because =
of losing
data after reboots when btrfs dies, the btrfs was unmountable and there=
 was no
fsck so i only could reformat and wait for ceph to rebuild. After a
powerfailure, no btrfs partitions survived and i lost all test data :/


So i think the first thing to be done to cephfs would be to integrate s=
ome sort
of fsck and the ability to format only cephfs without losing other rbd
images/data o rados data...



--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
