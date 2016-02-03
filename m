From: Loic Dachary <loic@dachary.org>
Subject: Re: Backporting stability fixes for ceph-disk
Date: Thu, 4 Feb 2016 02:10:18 +0700
Message-ID: <56B2509A.6090709@dachary.org>
References: <56B04476.5020203@redhat.com>
 <CALqRxCyTk5NPQJE7PTX4txbCPB2eagMBvH+V9HLHXkir4hij4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35167 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955AbcBCTK1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 14:10:27 -0500
In-Reply-To: <CALqRxCyTk5NPQJE7PTX4txbCPB2eagMBvH+V9HLHXkir4hij4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/02/2016 00:56, Ken Dreyer wrote:
> Hi Loic,
>=20
> Thanks for explaining the differences between Hammer's disk
> activations and Jewel's. I think I understand the problem better now.
>=20
> On Mon, Feb 1, 2016 at 10:53 PM, Loic Dachary <ldachary@redhat.com> w=
rote:
>> The conservative approach to the problem would be to cherry-pick wha=
t
>> we can (
>> https://github.com/dachary/ceph/commit/9dce05a8cdfc564c5162885bbb67a=
04ad7b95c5a
>> for instance ) and document known side effects of ceph-disk
>> instability so people know it's an annoyance but nothing destructive
>> or blocking. In the worst case scenario, deactivating the udev rules
>> and running ceph-disk prepare + ceph-disk activate manually or by
>> writing a script that does things sequentially is a viable workaroun=
d.
>=20
> This approach (documentation) sounds reasonable to me, and it makes
> sense that the larger re-architecture of running "ceph-disk activate"
> outside udev is only something that can happen in a major release
> boundary (in this case Infernalis / Jewel). Once we're happy that the
> docs for manually recovering are solid, we can possibly address it
> with a script as you suggest.

The script really is just adding a call to ceph-disk activate-all at bo=
ot time somewhere (/etc/rc.local maybe ?).

> If we can document the worst case scenario and what to do when
> ceph-disk-in-udev fails, that would really improve the user
> experience.
>=20
> What's the procedure for deactivating the Hammer udev rules, for exam=
ple?

rm /lib/udev/rules.d/*ceph*
udevadm control --reload # maybe superfluous

>=20
> - Ken
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
