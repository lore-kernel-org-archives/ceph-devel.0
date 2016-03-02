From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 08:59:50 -0500
Message-ID: <959DE663-CCF9-4EA9-98E0-A0C00C1CB127@redhat.com>
References: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbcCBN7x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 08:59:53 -0500
In-Reply-To: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On Mar 2, 2016, at 6:26 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> Hi Doug,
>=20
> The cause of that memory corruption is a premature (duplicate, too)
> call to rbd_obj_request_complete() in the !object-map DELETE case.
> You've got:
>=20
>    <dispatch>
>    rbd_osd_req_callback
>      rbd_osd_delete_callback
>        rbd_osd_discard_callback
>        rbd_obj_request_complete
>          <complete obj_request->completion>
>                                                <waiter is woken up>
>                                                ...
>                                                rbd_obj_request_put
>                                                <obj_request is gone>
>    <do more things with obj_request> <- !!!
>    rbd_obj_request_complete
>      <complete obj_request->completion>

Ah, yes, that is left over from before when I used the delete callback =
explicitly (assigning it to r_callback) instead of routing it through r=
bd_osd_req_callback like everything else. That likely explains it, than=
ks.

> I also spotted two memory leaks on the NOTIFY_COMPLETE path in
> __do_event().  The event one is trivial,

We cannot free the event here because CEPH_WATCH_EVENT_NOTIFY_COMPLETE =
fills values needed by the caller that may be waiting on it. The waiter=
 has to call ceph_osdc_cancel_event when done with it.

> the page vector one I have
> a question about.  The data item is allocated in alloc_msg() and the
> actual buffer is then passed into __do_event() and eventually into
> rbd_send_async_notify(), but not further up the stack.  Is anything
> going to use it?  If not, we should remove it entirely.

The incoming message may contain the data item. In the case of CEPH_WAT=
CH_EVENT_NOTIFY_COMPLETE, rbd does not expect any data from the OSD, on=
ly the return code. The protocol allows it to be present, though, so os=
d_client should handle this case.

> Another thing that caught my eye is your diff adds a bunch of
> ceph_get_snap_context() calls on header.snapc with no corresponding
> puts.  My understanding is the ones around rbd_image_request_fill() a=
re
> there to workaround the fact that rbd_queue_workfn() isn't used,

Yes. I think I left a comment there, but I=E2=80=99ll add one if I did =
not.

> but
> the one in rbd_obj_delete_sync() is immediately followed by
> ceph_osdc_build_request() which bumps snapc and so is almost certainl=
y
> a leak.

Yes. I thought you promised not to look at the garbage/junk commits, wh=
ere that line is.

> The attached patch fixes the use-after-free and plugs those leaks.
> With it applied your test loop runs fine for me - no crashes or out o=
f
> memory problems.
>=20
> Thanks,
>=20
>                Ilya
> <doug-testing.diff>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
