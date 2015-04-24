From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH 0/3] rbd: header read/refresh improvements
Date: Fri, 24 Apr 2015 10:40:49 -0400
Message-ID: <9D2825F1-BA75-433E-9B92-63D405339F0E@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com> <553A411A.8060902@ieee.org> <CAOi1vP85mJS3_e1PS-2zNzT3BDVmwV75qquo_sRiUrK2Whw5kQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37560 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbbDXOkv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 10:40:51 -0400
In-Reply-To: <CAOi1vP85mJS3_e1PS-2zNzT3BDVmwV75qquo_sRiUrK2Whw5kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>


> On Apr 24, 2015, at 10:17 AM, Ilya Dryomov <idryomov@gmail.com> wrote=
:
>=20
> On Fri, Apr 24, 2015 at 4:11 PM, Alex Elder <elder@ieee.org> wrote:
>> On 04/23/2015 02:06 PM, Douglas Fuller wrote:
>>>=20
>>> Support multiple class op calls in one ceph_msg and consolidate rbd=
 header
>>> read and refresh processes to use this feature to reduce the number=
 of
>>> ceph_msgs sent for that process. Refresh features on header refresh=
 and
>>> begin returning EIO if features have changed since mapping.
>>>=20
>>> Douglas Fuller (3):
>>>   ceph: support multiple class method calls in one ceph_msg
>>>   rbd: combine object method calls in header refresh using fewer
>>>     ceph_msgs
>>>   rbd: re-read features during header refresh and detect changes.
>>>=20
>>>  drivers/block/rbd.c             | 518
>>> +++++++++++++++++++++++++++++-----------
>>>  include/linux/ceph/osd_client.h |   3 +-
>>>  net/ceph/messenger.c            |   4 +
>>>  net/ceph/osd_client.c           |  92 ++++++-
>>>  4 files changed, 470 insertions(+), 147 deletions(-)
>>>=20
>>=20
>> In case Ilya or others don't get to it soon, I plan to review this
>> series tomorrow.
>=20
> I was planning take a look while I'm the road during the weekend.
>=20
> Doug, from a quick look this revision still has a bunch of style
> issues, most notably the alignment of function parameters and braces
> around if / else.  See Documentation/CodingStyle in the kernel tree f=
or
> examples.

I needed to put out v2 in part because I squashed a couple fixup commit=
s in the wrong place, leaving some things behind in #2 that were correc=
ted in #3.

I changed the braces in that version, but the function parameter indent=
s are inconsistent throughout the code. I=E2=80=99ll try to come up wit=
h a compromise.

>=20
> You might also want to run your patches through scripts/checkpatch.pl=
,
> but take it with a grain of salt - it can be a bit too extreme at
> times.  No need to post v3 with just style fixes, wait for more feedb=
ack.

Thanks again for all feedback.

>=20
> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
