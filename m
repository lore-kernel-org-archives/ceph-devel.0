From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 16:20:39 +0100
Message-ID: <CAOi1vP8KHOAB+TA3ciGYeNW9O7CwqpcqKxM6T43=oqgQLxRUzw@mail.gmail.com>
References: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com>
	<959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com>
	<CAOi1vP-CVdSmFeskBSZ=H8rwkd9d1EEarfSCPUAWkFxOTYZHyw@mail.gmail.com>
	<0B894755-4057-4F4E-B3BB-D0B1154E7B44@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34772 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbcCBPUk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 10:20:40 -0500
Received: by mail-wm0-f53.google.com with SMTP id p65so84816921wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 07:20:39 -0800 (PST)
In-Reply-To: <0B894755-4057-4F4E-B3BB-D0B1154E7B44@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 2, 2016 at 3:56 PM, Douglas Fuller <dfuller@redhat.com> wro=
te:
>
>> On Mar 2, 2016, at 9:10 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Wed, Mar 2, 2016 at 2:59 PM, Douglas Fuller <dfuller@redhat.com> =
wrote:
>>>
>>>> On Mar 2, 2016, at 6:26 AM, Ilya Dryomov <idryomov@gmail.com> wrot=
e:
>>>>
>>>
>>>> I also spotted two memory leaks on the NOTIFY_COMPLETE path in
>>>> __do_event().  The event one is trivial,
>>>
>>> We cannot free the event here because CEPH_WATCH_EVENT_NOTIFY_COMPL=
ETE fills values needed by the caller that may be waiting on it. The wa=
iter has to call ceph_osdc_cancel_event when done with it.
>>
>> My ceph_osdc_put_event() doesn't free the event, it just puts a ref
>> that was acquired above with get_event().
>
> That ref should be put by a call to ceph_osdc_cancel_event in that pa=
rticular case. It looks like the event ref counting may need attention,=
 though. I=E2=80=99ll look further.

The final ref *is* put by a call to ceph_osdc_cancel_event().  This is
the second ref, acquired at the top of __do_event(), and it needs to be
put somewhere.  In NOTIFY/DISCONNECT cases it's put in do_event_work(),
in the COMPLETE case it needs to be put in __do_event().  Am I missing
something?

>
>>>> the page vector one I have
>>>> a question about.  The data item is allocated in alloc_msg() and t=
he
>>>> actual buffer is then passed into __do_event() and eventually into
>>>> rbd_send_async_notify(), but not further up the stack.  Is anythin=
g
>>>> going to use it?  If not, we should remove it entirely.
>>>
>>> The incoming message may contain the data item. In the case of CEPH=
_WATCH_EVENT_NOTIFY_COMPLETE, rbd does not expect any data from the OSD=
, only the return code. The protocol allows it to be present, though, s=
o osd_client should handle this case.
>>
>> If there won't be any users of it on the kernel client side, there's=
 no
>> point in allocating the data item, extracting that data and propagat=
ing
>> it half way up, only to discard the data and free the data item.
>
> alloc_msg will have to allocate and the data item anyway, because CEP=
H_MSG_WATCH_NOTIFY might contain one. We only know that krbd is not exp=
ecting one iff the notify opcode is CEPH_WATCH_EVENT_NOTIFY_COMPLETE, b=
ut we do not decode that until later.

Who is going to be the user in the !NOTIFY_COMPLETE case?

>
> We could do as you suggest in your patch and free the data item there=
=2E It should be empty anyway for these cases, so this will not save me=
mory. We could shrink the ceph_osd_event struct by a pointer and a size=
_t, though.

If you are saying we can drop notify_data and notify_data_len from the
struct, how would you propagate the data in the !NOTIFY_COMPLETE case?

Right now the whole thing is unused and I don't see any kind of switch
on the notify opcode in the code:

    alloc_msg():
        if type =3D=3D CEPH_MSG_WATCH_NOTIFY:
            if data_len > 0:
                alloc page vector, create a data item, add it to the ms=
g

    handle_watch_notify():
        pages =3D data_item->pages;
        len =3D data_item->length;
        pass pages and len into __do_event()

    __do_event():
        assign pages and len to notify.notify_data and notify.notify_da=
ta_len,
        both of which are unused

    destroy the message

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
