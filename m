From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 09:56:11 -0500
Message-ID: <0B894755-4057-4F4E-B3BB-D0B1154E7B44@redhat.com>
References: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com> <959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com> <CAOi1vP-CVdSmFeskBSZ=H8rwkd9d1EEarfSCPUAWkFxOTYZHyw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269AbcCBO4M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 09:56:12 -0500
In-Reply-To: <CAOi1vP-CVdSmFeskBSZ=H8rwkd9d1EEarfSCPUAWkFxOTYZHyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On Mar 2, 2016, at 9:10 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Wed, Mar 2, 2016 at 2:59 PM, Douglas Fuller <dfuller@redhat.com> w=
rote:
>>=20
>>> On Mar 2, 2016, at 6:26 AM, Ilya Dryomov <idryomov@gmail.com> wrote=
:
>>>=20
>>=20
>>> I also spotted two memory leaks on the NOTIFY_COMPLETE path in
>>> __do_event().  The event one is trivial,
>>=20
>> We cannot free the event here because CEPH_WATCH_EVENT_NOTIFY_COMPLE=
TE fills values needed by the caller that may be waiting on it. The wai=
ter has to call ceph_osdc_cancel_event when done with it.
>=20
> My ceph_osdc_put_event() doesn't free the event, it just puts a ref
> that was acquired above with get_event().

That ref should be put by a call to ceph_osdc_cancel_event in that part=
icular case. It looks like the event ref counting may need attention, t=
hough. I=E2=80=99ll look further.

>>> the page vector one I have
>>> a question about.  The data item is allocated in alloc_msg() and th=
e
>>> actual buffer is then passed into __do_event() and eventually into
>>> rbd_send_async_notify(), but not further up the stack.  Is anything
>>> going to use it?  If not, we should remove it entirely.
>>=20
>> The incoming message may contain the data item. In the case of CEPH_=
WATCH_EVENT_NOTIFY_COMPLETE, rbd does not expect any data from the OSD,=
 only the return code. The protocol allows it to be present, though, so=
 osd_client should handle this case.
>=20
> If there won't be any users of it on the kernel client side, there's =
no
> point in allocating the data item, extracting that data and propagati=
ng
> it half way up, only to discard the data and free the data item.

alloc_msg will have to allocate and the data item anyway, because CEPH_=
MSG_WATCH_NOTIFY might contain one. We only know that krbd is not expec=
ting one iff the notify opcode is CEPH_WATCH_EVENT_NOTIFY_COMPLETE, but=
 we do not decode that until later.

We could do as you suggest in your patch and free the data item there. =
It should be empty anyway for these cases, so this will not save memory=
=2E We could shrink the ceph_osd_event struct by a pointer and a size_t=
, though.

>> Yes. I thought you promised not to look at the garbage/junk commits,=
 where that line is.
>=20
> I looked at the entire diff - it was blowing past 1G of memory, after
> all ;)

Your test was, or the diff was? ;)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
