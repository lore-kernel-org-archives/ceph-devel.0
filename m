From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: using discard from qemu guest when snapshot exist, fill the rbd
 layer with zeroes and use more space
Date: Sat, 18 Jun 2016 08:08:48 -0400
Message-ID: <CA+aFP1CKd_O1ceCAFhZqk0G2Km=Nm+P8vaMhJYV9Jy7w-9AbLA@mail.gmail.com>
References: <1498621012.13671278.1466154654173.JavaMail.zimbra@oxygem.tv>
	<CA+aFP1A9a5ZEUzsJ_4_dRd_Ok7Ob4yk6PjaQNnrwWQbUmK6V3w@mail.gmail.com>
	<883325327.16929202.1466235640463.JavaMail.zimbra@oxygem.tv>
	<2080661916.17082708.1466242175934.JavaMail.zimbra@oxygem.tv>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35202 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbcFRMIt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Jun 2016 08:08:49 -0400
Received: by mail-pf0-f181.google.com with SMTP id c2so39079192pfa.2
        for <ceph-devel@vger.kernel.org>; Sat, 18 Jun 2016 05:08:49 -0700 (PDT)
In-Reply-To: <2080661916.17082708.1466242175934.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Definitely broken -- I've opened a new tracker ticket to get it fixed [=
1].

[1] http://tracker.ceph.com/issues/16386

On Sat, Jun 18, 2016 at 5:29 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>Thanks Jason . I had tried it some week ago, and my fstrim was hangi=
ng.
>>>It'll do more test next week.
>>>
>>>It must be defined on client right ?
>>>
>>>[client]
>>>rbd_skip_partial_discard =3D true
>
>
> Just tested again, fstrim is totally hanging
>
> I have attached the client.client.log in debug verbose, the log start=
 when fstrim start
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: dillaman@redhat.com
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Samedi 18 Juin 2016 09:40:40
> Objet: Re: using discard from qemu guest when snapshot exist, fill th=
e rbd layer with zeroes and use more space
>
>>>There is a "rbd_skip_partial_discard" configuration option which can
>>>be set to true. When enabled, discard will avoid zeroing holes if th=
e
>>>discard extent is in the middle of an object.
>
> Thanks Jason . I had tried it some week ago, and my fstrim was hangin=
g.
> It'll do more test next week.
>
> It must be defined on client right ?
>
> [client]
> rbd_skip_partial_discard =3D true
>
>
>
> ----- Mail original -----
> De: "Jason Dillaman" <jdillama@redhat.com>
> =C3=80: "aderumier" <aderumier@odiso.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Vendredi 17 Juin 2016 15:21:53
> Objet: Re: using discard from qemu guest when snapshot exist, fill th=
e rbd layer with zeroes and use more space
>
> There is a "rbd_skip_partial_discard" configuration option which can
> be set to true. When enabled, discard will avoid zeroing holes if the
> discard extent is in the middle of an object.
>
> On Fri, Jun 17, 2016 at 5:10 AM, Alexandre DERUMIER <aderumier@odiso.=
com> wrote:
>> Hi,
>>
>> I'm using fstrim inside my qemu guests to remove unused space from t=
he rbd storage.
>>
>> This is working fine, but I just notice that if a snapshot exist,
>>
>> It just do the reverse, it's filling the snasphot with zeroes, and t=
he total cluster space is growing.
>>
>> It's is possible to avoid that ?
>>
>>
>> Regards,
>>
>> Alexandre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--=20
Jason
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
