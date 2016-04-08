From: Alex Elder <elder@ieee.org>
Subject: Re: RBD image name constraints
Date: Fri, 8 Apr 2016 12:36:38 -0500
Message-ID: <5707EC26.4000909@ieee.org>
References: <5707A2C4.3030102@corp.ovh.com>
 <CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33087 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbcDHRgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 13:36:43 -0400
Received: by mail-wm0-f45.google.com with SMTP id f198so72979593wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 10:36:42 -0700 (PDT)
In-Reply-To: <CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 04/08/2016 11:13 AM, Ilya Dryomov wrote:
> On Fri, Apr 8, 2016 at 2:23 PM, Bart=C5=82omiej =C5=9Awi=C4=99cki
> <bartlomiej.swiecki@corp.ovh.com> wrote:
>> Hi,
>>
>> What are constraints regarding names of RBD images? I tried to look =
it up
>> but without success.
>=20
> I'm afraid this is something nobody ever paid enough attention to.
>=20
>>
>> My tests show that maximum length is about 4089 bytes and the only f=
orbidden
>> characters are '\0' and '@' but didn't get deep enough into the code=
 to
>> figure out the length limit. Are my findings correct?
>=20
> There is an old define in the code base, but it's not enforced:
>=20
>     #define RBD_MAX_IMAGE_NAME_SIZE 96

On the kernel RBD client we have RBD_IMAGE_NAME_LEN_MAX,
which is 4093 bytes.  That is because the RBD "dir_get_name"
object method returns an encoded string, which consists of a
32-byte name length followed by the name.  We place the result
into a buffer which has room for a terminating NUL character.
This length value was used to limit the buffer size to a 4KB
page or less.  I haven't checked but I'm pretty sure the request
fails of the name is larger than that.

It does not surprise me that there are other limits that are
more restrictive than that.  The one you're referring to below
appears to be CEPH_MAX_OID_NAME_LEN.

> The kernel client, however, won't process object requests with names
> bigger than 100 chars.  Lifting this limitation wouldn't be hard, but
> so far I've only seen this raised once, by Jean-Tiare Le Bigot, also
> from OVH.
>=20
> Currently, with no enforcement from librbd, this comes down to how bi=
g
> RADOS object names can be, which depends on config options and even t=
he
> choice of the data store - in case of ext4, you wouldn't get ~4k, for
> example.

Honestly I don't think there's much need for anything legitimate
beyond about 100 characters, but it is important to test the
limits, whatever they are.

					-Alex

>=20
>>
>> I also think I've found a regression introduced in v10.0.1 regarding=
 pool /
>> image name constraints (introduced in
>> fa4e00f8c85603ed202bfef2f3be6086482fbbb2).
>>
>> In newer versions there's regex that's parsing image name passed to =
rbd
>> command (in src/tools/rbd/Utils.cc, function: extract_spec):
>>
>>     "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"
>>
>> It won't parse pool name with '@', image name with '/' nor snapshot =
name
>> with '/', which was allowed in previous implementation based on strc=
hr.
>=20
> "spec" is a combination of pool, image and snapshot names:
>=20
>     [pool/]image[@snap] # pool and snap are optional
>=20
> I haven't looked at either of the versions in detail, but you can see
> how an image name with a '/' in it is a problem.
>=20
> Would you mind sharing some details on what you are doing?  If you ha=
ve
> a layer of management software on top, it wouldn't be a bad idea to
> restrict things to a basic A-Za-z0-9+=3D or so and 96 chars in length=
=2E
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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
