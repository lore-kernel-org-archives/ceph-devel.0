From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 10:33:12 -0500
Message-ID: <ABB5FE7D-82FF-481A-80C7-05F1C5DA6F0E@redhat.com>
References: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com> <959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com> <CAOi1vP-CVdSmFeskBSZ=H8rwkd9d1EEarfSCPUAWkFxOTYZHyw@mail.gmail.com> <0B894755-4057-4F4E-B3BB-D0B1154E7B44@redhat.com> <CAOi1vP8KHOAB+TA3ciGYeNW9O7CwqpcqKxM6T43=oqgQLxRUzw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbcCBPd5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 10:33:57 -0500
In-Reply-To: <CAOi1vP8KHOAB+TA3ciGYeNW9O7CwqpcqKxM6T43=oqgQLxRUzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sorry, I should have looked more closely at this. I forgot that the dat=
a comes inside the message when opcode =3D=3D CEPH_WATCH_EVENT_NOTIFY a=
nd a data item when opcode =3D=3D CEPH_WATCH_EVENT_NOTIFY_COMPLETE. Yes=
, the data item isn=E2=80=99t used by rbd.

>> alloc_msg will have to allocate and the data item anyway, because CE=
PH_MSG_WATCH_NOTIFY might contain one. We only know that krbd is not ex=
pecting one iff the notify opcode is CEPH_WATCH_EVENT_NOTIFY_COMPLETE, =
but we do not decode that until later.
>=20
> Who is going to be the user in the !NOTIFY_COMPLETE case?
>=20
>>=20
>> We could do as you suggest in your patch and free the data item ther=
e. It should be empty anyway for these cases, so this will not save mem=
ory. We could shrink the ceph_osd_event struct by a pointer and a size_=
t, though.
>=20
> If you are saying we can drop notify_data and notify_data_len from th=
e
> struct, how would you propagate the data in the !NOTIFY_COMPLETE case=
?
>=20
> Right now the whole thing is unused and I don't see any kind of switc=
h
> on the notify opcode in the code:
>=20
>    alloc_msg():
>        if type =3D=3D CEPH_MSG_WATCH_NOTIFY:
>            if data_len > 0:
>                alloc page vector, create a data item, add it to the m=
sg
>=20
>    handle_watch_notify():
>        pages =3D data_item->pages;
>        len =3D data_item->length;
>        pass pages and len into __do_event()
>=20
>    __do_event():
>        assign pages and len to notify.notify_data and notify.notify_d=
ata_len,
>        both of which are unused
>=20
>    destroy the message
>=20
> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
