From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/5] rbd: rework calculation of new rbd id's
Date: Wed, 29 Feb 2012 12:37:49 -0800
Message-ID: <CAC-hyiGgrPA39U2F+Nxo-HVKH4h=+2fDA69UDLuKoyBw7Oqvpw@mail.gmail.com>
References: <4F4D9DA5.8050101@dreamhost.com>
	<4F4D9E19.9070204@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54750 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2B2Uhv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 15:37:51 -0500
Received: by bkcik5 with SMTP id ik5so2733807bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 12:37:50 -0800 (PST)
In-Reply-To: <4F4D9E19.9070204@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 7:40 PM, Alex Elder <elder@dreamhost.com> wrote=
:
> In order to select a new unique identifier for an added rbd device,
> the list of all existing ones is searched and a value one greater
> than the highest id is used.
>
> The list search can be avoided by using an atomic variable that
> keeps track of the current highest id. =A0Using a get/put model for
> id's we can limit the boundless growth of id numbers a bit by
> arranging to reuse the current highest id once it gets released.
> Add these calls to "put" the id when an rbd is getting removed.
>
> Note that this changes the pattern of device id's used--new values
> will never be below the highest one seen so far (even if there
> exists an unused lower one). =A0I assert this is OK because the key
> property of an rbd id is its uniqueness, not its magnitude.
>
> Regardless, a follow-on patch will restore the old way of doing
> things, I just think this commit just makes the incremental change
> to atomics a little easier to understand.
>
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0drivers/block/rbd.c | =A0 35 +++++++++++++++++++++++------------
> =A01 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 35290b1..0c492e4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2148,21 +2148,29 @@ static int rbd_init_watch_dev(struct rbd_devi=
ce
> *rbd_dev)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -/* caller must hold ctl_mutex */
> +static atomic_t rbd_id_max =3D ATOMIC_INIT(0);
> +
> +/*
> + * Get a unique rbd identifier. =A0The minimum rbd id is 1.
> + */
> =A0static int rbd_id_get(void)
> =A0{
> - =A0 =A0 =A0 struct list_head *tmp;
> - =A0 =A0 =A0 int new_id =3D 0;
> -
> - =A0 =A0 =A0 list_for_each(tmp, &rbd_dev_list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rbd_device *rbd_dev;
> + =A0 =A0 =A0 return atomic_inc_return(&rbd_id_max);
> +}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rbd_dev =3D list_entry(tmp, struct rbd_=
device, node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rbd_dev->id >=3D new_id)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_id =3D rbd_dev->id =
+ 1;
> - =A0 =A0 =A0 }
> +/*
> + * Record that an rbd identifier is no longer in use.
> + */
> +static void rbd_id_put(int rbd_id)
> +{
> + =A0 =A0 =A0 BUG_ON(rbd_id < 1);

A scenario where you have a few devices that keep being added/removed
in order (e.g., for backup purposes) may exhaust the 31 bits used for
this purpose. Can we use a 64 bit counter (is atomic64_t a good idea?)

>
> - =A0 =A0 =A0 return new_id;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* New id's are always one more than the current maxi=
mum.
> + =A0 =A0 =A0 =A0* If the id being "put" *is* that maximum, decrement=
 the
> + =A0 =A0 =A0 =A0* maximum so the next one requested just reuses this=
 one.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 atomic_cmpxchg(&rbd_id_max, rbd_id, rbd_id - 1);
> =A0}
>
> =A0static ssize_t rbd_add(struct bus_type *bus,
> @@ -2197,7 +2205,7 @@ static ssize_t rbd_add(struct bus_type *bus,
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&rbd_dev->node);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&rbd_dev->snaps);
>
> - =A0 =A0 =A0 /* generate unique id: find highest unique id, add one =
*/
> + =A0 =A0 =A0 /* generate unique id: one more than highest used so fa=
r */
> =A0 =A0 =A0 =A0mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>
> =A0 =A0 =A0 =A0rbd_dev->id =3D rbd_id_get();
> @@ -2267,6 +2275,7 @@ err_out_bus:
> =A0 =A0 =A0 =A0mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> =A0 =A0 =A0 =A0list_del_init(&rbd_dev->node);
> =A0 =A0 =A0 =A0mutex_unlock(&ctl_mutex);
> + =A0 =A0 =A0 rbd_id_put(target_id);
>
> =A0 =A0 =A0 =A0/* this will also clean up rest of rbd_dev stuff */
>
> @@ -2283,6 +2292,7 @@ err_out_client:
> =A0err_out_slot:
> =A0 =A0 =A0 =A0list_del_init(&rbd_dev->node);
> =A0 =A0 =A0 =A0mutex_unlock(&ctl_mutex);
> + =A0 =A0 =A0 rbd_id_put(target_id);
>
> =A0 =A0 =A0 =A0kfree(rbd_dev);
> =A0err_out_opt:
> @@ -2360,6 +2370,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0list_del_init(&rbd_dev->node);
> + =A0 =A0 =A0 rbd_id_put(target_id);
>
> =A0 =A0 =A0 =A0__rbd_remove_all_snaps(rbd_dev);
> =A0 =A0 =A0 =A0rbd_bus_del_dev(rbd_dev);
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
