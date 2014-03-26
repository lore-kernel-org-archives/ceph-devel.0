From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:54:33 -0500
Message-ID: <53324F79.1080108@ieee.org>
References: <1395736765.2823.29.camel@localhost>		 <1395773582.2076.10.camel@localhost>		 <5331D2E8.6060002@ieee.org>			 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>			 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>			 <1395781847.2076.21.camel@localhost>			 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>			 <1395782577.2076.23.camel@localhost>			 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>			 <1395783675.2076.26.camel@localhost>			 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>			 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>			 <5332075F.8080105@ieee.org> <1395788695.2076.35.camel@localhost>			 <53321896.1080606@ieee.org> <1395797596.2076.43.c
 amel@localhost>		 <1395798658.2076.45.camel@localhost> <5332339A.8030000@ieee.org>	 <1395801625.2076.52.camel@localhost> <53323EA5.6010506@ieee.org> <1395801940.2076.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:57203 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbaCZDyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 23:54:14 -0400
Received: by mail-qc0-f170.google.com with SMTP id e9so1980614qcy.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 20:54:13 -0700 (PDT)
In-Reply-To: <1395801940.2076.54.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 09:45 PM, Olivier Bonvalet wrote:
> Le mardi 25 mars 2014 =C3=A0 21:42 -0500, Alex Elder a =C3=A9crit :
>> PS  I thought you said you were going to stop for the night!
>=20
> Yes, I would love ! But my phone doesn't stop ring about ceph crash :=
D
>=20

OK, one more thing to try and I'm going to bed.

I'm hoping that an image request spanning multiple objects
is an unusual case, enough so that the following won't
overwhelm with output.  I'd avoid putting it on a production
system (that's the case for all this testing, really) if
possible.

Basically I'm trying to catch an image object request being
either submitted more than once, or completing more than
once.  So if an image request has more than one object
request I produce some informative output.

This patch fixes two warnings in the previous debug patch,
and adds to it (so use it instead of the last one).

If you get a chance to try this I'll want to see the output.
But first, I shall sleep.

Thank you.

					-Alex

Index: b/drivers/block/rbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1484,6 +1484,10 @@ static void rbd_img_request_complete(str
 			xferred +=3D obj_request->xferred;
 		img_request->xferred =3D xferred;
 	}
+	if (img_request->obj_request_count > 1)
+		printk("%s: img_request %p count %u result %d xferred %llu\n",
+			__func__, img_request, img_request->obj_request_count,
+			img_request->result, img_request->xferred);

 	if (img_request->callback)
 		img_request->callback(img_request);
@@ -2129,9 +2133,43 @@ static void rbd_img_obj_callback(struct
 	rbd_assert(which !=3D BAD_WHICH);
 	rbd_assert(which < img_request->obj_request_count);

+	if (img_request->obj_request_count > 1)
+		printk("%s: obj_request %p (%llu/%llu)\n", __func__,
+			obj_request, obj_request->offset, obj_request->length);
 	spin_lock_irq(&img_request->completion_lock);
 	if (which > img_request->next_completion)
 		goto out;
+	if (which !=3D img_request->next_completion) {
+		printk("%s: bad image object request information:\n", __func__);
+		printk("obj_request %p\n", obj_request);
+		printk("    ->object_name <%s>\n", obj_request->object_name);
+		printk("    ->offset %llu\n", obj_request->offset);
+		printk("    ->length %llu\n", obj_request->length);
+		printk("    ->type 0x%x\n", (u32)obj_request->type);
+		printk("    ->flags 0x%lx\n", obj_request->flags);
+		printk("    ->img_request %p\n", obj_request->img_request);
+		printk("    ->which %u\n", obj_request->which);
+		printk("    ->xferred %llu\n", obj_request->xferred);
+		printk("    ->result %d\n", obj_request->result);
+		printk("    ->kref %d\n",
+			atomic_read(&obj_request->kref.refcount));
+
+		printk("img_request %p\n", img_request);
+		printk("    ->snap 0x%016llx\n", img_request->snap_id);
+		printk("    ->offset %llu\n", img_request->offset);
+		printk("    ->length %llu\n", img_request->length);
+		printk("    ->flags 0x%lx\n", img_request->flags);
+		printk("    ->obj_request_count %u\n",
+			img_request->obj_request_count);
+		printk("    ->next_completion %u\n",
+			img_request->next_completion);
+		printk("    ->xferred %llu\n", img_request->xferred);
+		printk("    ->result %d\n", img_request->result);
+		printk("    ->obj_requests head %p\n",
+			img_request->obj_requests.next);
+		printk("    ->kref %d\n",
+			atomic_read(&img_request->kref.refcount));
+	}
 	rbd_assert(which =3D=3D img_request->next_completion);

 	for_each_obj_request_from(img_request, obj_request) {
@@ -2697,11 +2735,21 @@ static int rbd_img_request_submit(struct
 {
 	struct rbd_obj_request *obj_request;
 	struct rbd_obj_request *next_obj_request;
+	bool verbose =3D false;

 	dout("%s: img %p\n", __func__, img_request);
+	if (img_request->obj_request_count > 1) {
+		printk("%s: img_request %p count %u (%llu/%llu)\n", __func__,
+			img_request, img_request->offset, img_request->length);
+	    	verbose =3D true;
+	}
 	for_each_obj_request_safe(img_request, obj_request, next_obj_request)=
 {
 		int ret;

+		if (verbose)
+			printk("%s: obj_request %p (%llu/%llu)\n", __func__,
+				obj_request, obj_request->offset,
+				obj_request->length);
 		ret =3D rbd_img_obj_request_submit(obj_request);
 		if (ret)
 			return ret;

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
