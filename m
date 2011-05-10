From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 22:29:07 +0800
Message-ID: <BANLkTi=Qo2_MKVuZPtTWp8NK6sj=hrJ_Og@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41633 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1EJO3J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 10:29:09 -0400
Received: by wwa36 with SMTP id 36so6936432wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 07:29:07 -0700 (PDT)
In-Reply-To: <BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

YES!! After try several times if I create a rbd, one of the cosd will c=
oredump.


2011/5/10 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Tue, May 10, 2011 at 6:39 AM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>> Sorry, I didn't learn the wiki carefullllllly..
>>
>> There is another problem:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [root@mon-00 ~]# rbd create foo --size 1024
>> 2011-05-11 02:37:15.400313 42d6a940 -- 10.250.6.98:0/1010326 >>
>> 10.250.6.30:6801/3051 pipe(0x63f140 sd=3D6 pgs=3D0 cs=3D0 l=3D0).fau=
lt first
>> fault
>
> This looks like your osd is not reachable, might have crashed?
>
>> terminate called after throwing an instance of 'ceph::buffer::end_of=
_buffer'
>> =C2=A0what(): =C2=A0buffer::end_of_buffer
>> *** Caught signal (Aborted) **
>
> This shouldn't happen anyway, but probably bad error handling. Can yo=
u
> verify whether one of the daemons went down?
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
