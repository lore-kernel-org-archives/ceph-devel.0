From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 15:10:39 +0100
Message-ID: <CAOi1vP-CVdSmFeskBSZ=H8rwkd9d1EEarfSCPUAWkFxOTYZHyw@mail.gmail.com>
References: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com>
	<959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36474 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbcCBOKk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 09:10:40 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so87558992wmn.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 06:10:40 -0800 (PST)
In-Reply-To: <959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 2, 2016 at 2:59 PM, Douglas Fuller <dfuller@redhat.com> wro=
te:
>
>> On Mar 2, 2016, at 6:26 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> Hi Doug,
>>
>> The cause of that memory corruption is a premature (duplicate, too)
>> call to rbd_obj_request_complete() in the !object-map DELETE case.
>> You've got:
>>
>>    <dispatch>
>>    rbd_osd_req_callback
>>      rbd_osd_delete_callback
>>        rbd_osd_discard_callback
>>        rbd_obj_request_complete
>>          <complete obj_request->completion>
>>                                                <waiter is woken up>
>>                                                ...
>>                                                rbd_obj_request_put
>>                                                <obj_request is gone>
>>    <do more things with obj_request> <- !!!
>>    rbd_obj_request_complete
>>      <complete obj_request->completion>
>
> Ah, yes, that is left over from before when I used the delete callbac=
k explicitly (assigning it to r_callback) instead of routing it through=
 rbd_osd_req_callback like everything else. That likely explains it, th=
anks.
>
>> I also spotted two memory leaks on the NOTIFY_COMPLETE path in
>> __do_event().  The event one is trivial,
>
> We cannot free the event here because CEPH_WATCH_EVENT_NOTIFY_COMPLET=
E fills values needed by the caller that may be waiting on it. The wait=
er has to call ceph_osdc_cancel_event when done with it.

My ceph_osdc_put_event() doesn't free the event, it just puts a ref
that was acquired above with get_event().

>
>> the page vector one I have
>> a question about.  The data item is allocated in alloc_msg() and the
>> actual buffer is then passed into __do_event() and eventually into
>> rbd_send_async_notify(), but not further up the stack.  Is anything
>> going to use it?  If not, we should remove it entirely.
>
> The incoming message may contain the data item. In the case of CEPH_W=
ATCH_EVENT_NOTIFY_COMPLETE, rbd does not expect any data from the OSD, =
only the return code. The protocol allows it to be present, though, so =
osd_client should handle this case.

If there won't be any users of it on the kernel client side, there's no
point in allocating the data item, extracting that data and propagating
it half way up, only to discard the data and free the data item.

>
>> Another thing that caught my eye is your diff adds a bunch of
>> ceph_get_snap_context() calls on header.snapc with no corresponding
>> puts.  My understanding is the ones around rbd_image_request_fill() =
are
>> there to workaround the fact that rbd_queue_workfn() isn't used,
>
> Yes. I think I left a comment there, but I=E2=80=99ll add one if I di=
d not.
>
>> but
>> the one in rbd_obj_delete_sync() is immediately followed by
>> ceph_osdc_build_request() which bumps snapc and so is almost certain=
ly
>> a leak.
>
> Yes. I thought you promised not to look at the garbage/junk commits, =
where that line is.

I looked at the entire diff - it was blowing past 1G of memory, after
all ;)

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
