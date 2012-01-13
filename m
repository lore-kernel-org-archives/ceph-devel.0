From: huang jun <hjwsm1989@gmail.com>
Subject: Re: subuser of radosgw
Date: Fri, 13 Jan 2012 08:57:25 +0800
Message-ID: <CABAwU-Z2YPm9niHz07ue+TvJOyPG30j43RGY2vJckv9uRfPU0w@mail.gmail.com>
References: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
	<CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50843 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2AMA50 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 19:57:26 -0500
Received: by iabz25 with SMTP id z25so3508045iab.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 16:57:25 -0800 (PST)
In-Reply-To: <CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/1/13 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Thu, Jan 12, 2012 at 4:27 PM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>>
>> hi,all
>> =A0 when i use radosgw+s3, there are two werid things:
>> =A0 1) =A0we can use the command "raodsgw_admin subuser create =A0--=
subuser
>> =3D"a1" =A0-i 8" to create a subuser named "a1" under a user whoes u=
ser_id
>> is 8.
>> =A0 =A0 =A0 =A0and also can create many subusers under one single us=
er.
>> =A0 can we give the specified subuser =A0permission to visit a speci=
fied bucket?
>
> Not at the moment, though we can probably add that easily. You can,
> however, give the subuser a reduced access permission to whatever the
> main user has (e.g., read-only access, read-write only with no access
> control, etc.)
>
>> =A0 so what do subusers do here?
>
> Subuser is used currently for Swift, where you can create a few users
> under a single account.
>
>> =A0 2) we can create many access-key and secret-keys for an user, do=
 we
>> need so many keys?
>>
> That's up to you. You may want to use a key per service, and if one
> key is compromised, or if there's a need to replace it you can revoke
> only that key, while other services can continue using their keys.
>
> Yehuda
thanks
   but there is one  thing always in my head,how can we banlance the wo=
rkload?
rados stores an object comes from s3 no matter how big it is.


--=20
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
