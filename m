From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next hammer release v0.94.6
Date: Fri, 5 Feb 2016 12:48:49 +0700
Message-ID: <56B437C1.2020106@dachary.org>
References: <56B185DD.3050905@dachary.org>
 <CADRKj5Qm-gQEnPsgYXjDxVrDUhQ8cOoXuuUJnPWRNm7MoF6d9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49415 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcBEFs7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 00:48:59 -0500
In-Reply-To: <CADRKj5Qm-gQEnPsgYXjDxVrDUhQ8cOoXuuUJnPWRNm7MoF6d9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, Odintsov Vladislav <VlOdintsov@croc.ru>



On 05/02/2016 08:46, Yehuda Sadeh-Weinraub wrote:
> On Tue, Feb 2, 2016 at 8:45 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Yehuda,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed the rgw suite (http://tracker.ceph.com/issues/13356#not=
e-45). Do you think the hammer branch is ready for QE to start their ow=
n round of testing ?
>>
>=20
> Looks ok. There are also the two commits mentioned in this thread,
> which I'm fine with, but it's your call with regard to the timing.

I merged them. They have not been tested with a rgw suite but QE will r=
un additional tests so the worst that can happen is that they fail ther=
e.

Thanks !

>=20
> Thanks,
> Yehuda
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
