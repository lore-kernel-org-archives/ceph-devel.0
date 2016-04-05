From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk improvements
Date: Tue, 5 Apr 2016 12:21:41 +0200
Message-ID: <570391B5.1050207@dachary.org>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com>
 <1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
 <CAOi1vP_mnMP_n7xSPXgEycYRifja0k4LE7PBG7epL1uUNWjaJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35261 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbcDEKVr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 06:21:47 -0400
In-Reply-To: <CAOi1vP_mnMP_n7xSPXgEycYRifja0k4LE7PBG7epL1uUNWjaJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Sebastien Han <shan@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Samuel Yaple <sam@yaple.net>

Hi Ilya,

On 05/04/2016 11:26, Ilya Dryomov wrote:
> On Tue, Apr 5, 2016 at 10:30 AM, Sebastien Han <shan@redhat.com> wrot=
e:
>> Wido, I just discussed that with Sam last week and it seems that
>> bcache allocates a minor of 1 when creating the device.
>> Sam ended up writing this:
>> https://yaple.net/2016/03/31/bcache-partitions-and-dkms/
>> The fix is not complex not sure why it is not part of bcache yet...
>=20
> I think it's just that no one complained loud enough.
>=20
>>
>> Not sure if it's ceph-disk's job to do all of this with bcache thoug=
h...
>> We might need to check with the bache guys what are their plans abou=
t this.
>> If this will go through at some point we might just wait, if not we
>> could implement the partition trick on ceph-disk.
>=20
> Making something like this go through shouldn't be a problem.  Sam's
> patch is a bit of quick hack though - it messes up bcache device IDs
> and also limits the number of partitions to 16.  Better to avoid
> another hard-coded constant, if possible.
>=20
>     # ls -lh /dev/bcache*
>     brw-rw---- 1 root disk 254,  0 Mar 31 20:17 /dev/bcache0
>     brw-rw---- 1 root disk 254,  1 Mar 31 20:17 /dev/bcache0p1
>     brw-rw---- 1 root disk 254, 16 Mar 31 20:17 /dev/bcache16
>     brw-rw---- 1 root disk 254, 17 Mar 31 20:17 /dev/bcache16p1
>     brw-rw---- 1 root disk 254, 32 Mar 31 20:17 /dev/bcache32
>     brw-rw---- 1 root disk 254, 33 Mar 31 20:17 /dev/bcache32p1
>=20
> We had to solve almost exactly this problem in rbd.  I can submit
> a patch for bcache if it helps ceph-disk in the long run.

It would help. Implementing a workaround in ceph-disk to compensate for=
 the fact that bcache does not support partitioning feels much better w=
hen there is hope it will eventually be removed :-)

Cheers

>=20
> Thanks,
>=20
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
