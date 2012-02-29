From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 5/5] rbd: restore previous rbd id sequence behavior
Date: Wed, 29 Feb 2012 12:53:06 -0800
Message-ID: <CAC-hyiFXkcp64aj5rkS4h6pdvPQr3WCrK8Xy7NbKO5N+JSWjKw@mail.gmail.com>
References: <4F4D9DA5.8050101@dreamhost.com>
	<4F4D9E1D.806@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54228 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab2B2UxH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 15:53:07 -0500
Received: by bkcik5 with SMTP id ik5so2748668bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 12:53:06 -0800 (PST)
In-Reply-To: <4F4D9E1D.806@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 7:40 PM, Alex Elder <elder@dreamhost.com> wrote=
:
> It used to be that selecting a new unique identifier for an added
> rbd device required searching all existing ones to find the highest
> id is used. =A0A recent change made that unnecessary, but made it
> so that id's used were monotonically non-decreasing. =A0It's a bit
> more pleasant to have smaller rbd id's though, and this change
> makes ids get allocated as they were before--each new id is one more
> than the maximum currently in use.

Oh, so ignore my previous comment, though in any case we can still
exhaust the 31 bits:

loop through:

add A
add B
remove A
add C
remove B
add A
remove C
add B


etc..

>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 40 ++++++++++++++++++++++++++++++++++---=
---
> =A01 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 042377b..4c5bb39 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2171,18 +2171,46 @@ static void rbd_id_get(struct rbd_device *rbd=
_dev)
> =A0*/
> =A0static void rbd_id_put(struct rbd_device *rbd_dev)
> =A0{
> - =A0 =A0 =A0 BUG_ON(rbd_dev->id < 1);
> + =A0 =A0 =A0 struct list_head *tmp;
> + =A0 =A0 =A0 int rbd_id =3D rbd_dev->id;
> + =A0 =A0 =A0 int max_id;
> +
> + =A0 =A0 =A0 BUG_ON(rbd_id < 1);
>
> =A0 =A0 =A0 =A0spin_lock(&rbd_dev_list_lock);
> =A0 =A0 =A0 =A0list_del_init(&rbd_dev->node);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the id being "put" is not the current maximum, =
there
> + =A0 =A0 =A0 =A0* is nothing special we need to do.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rbd_id !=3D atomic_read(&rbd_id_max)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&rbd_dev_list_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We need to update the current maximum id. =A0Searc=
h the
> + =A0 =A0 =A0 =A0* list to find out what it is. =A0We're more likely =
to find
> + =A0 =A0 =A0 =A0* the maximum at the end, so search the list backwar=
d.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 max_id =3D 0;
> + =A0 =A0 =A0 list_for_each_prev(tmp, &rbd_dev_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rbd_device *rbd_dev;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rbd_dev =3D list_entry(tmp, struct rbd_=
device, node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rbd_id > max_id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_id =3D rbd_id;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0spin_unlock(&rbd_dev_list_lock);

So we still need to either use 64 bit counter, or think of a better
scheme to allocate ids. Maybe using some sorted data structure here?
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* New id's are always one more than the current maxi=
mum.
> - =A0 =A0 =A0 =A0* If the id being "put" *is* that maximum, decrement=
 the
> - =A0 =A0 =A0 =A0* maximum so the next one requested just reuses this=
 one.
> + =A0 =A0 =A0 =A0* The max id could have been updated by rbd_id_get()=
, in
> + =A0 =A0 =A0 =A0* which case it now accurately reflects the new maxi=
mum.
> + =A0 =A0 =A0 =A0* Be careful not to overwrite the maximum value in t=
hat
> + =A0 =A0 =A0 =A0* case.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 atomic_cmpxchg(&rbd_id_max, rbd_dev->id, rbd_dev->id - =
1);
> + =A0 =A0 =A0 atomic_cmpxchg(&rbd_id_max, rbd_id, max_id);
> =A0}
>
> =A0static ssize_t rbd_add(struct bus_type *bus,
> @@ -2217,7 +2245,7 @@ static ssize_t rbd_add(struct bus_type *bus,
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&rbd_dev->node);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&rbd_dev->snaps);
>
> - =A0 =A0 =A0 /* generate unique id: one more than highest used so fa=
r */
> + =A0 =A0 =A0 /* generate unique id: find highest unique id, add one =
*/
> =A0 =A0 =A0 =A0rbd_id_get(rbd_dev);
>
> =A0 =A0 =A0 =A0/* parse add command */
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
