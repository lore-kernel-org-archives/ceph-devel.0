From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 19:00:22 -0500
Message-ID: <53321896.1080606@ieee.org>
References: <1395736765.2823.29.camel@localhost>		 <53317BC2.9010700@ieee.org>		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>		 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>		 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>		 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>		 <5331D2E8.6060002@ieee.org>		 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>		 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>		 <1395781847.2076.21.camel@localhost>		 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>		 <1395782577.2076.23.camel@localhost>		 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>		 <1395783675.2076.26.camel@localhost>		 <CALFYKtBFMbo9
 1ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>		 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>	 <5332075F.8080105@ieee.org> <1395788695.2076.35.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:48278 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbaCZAAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 20:00:04 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so1484844qac.13
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 17:00:03 -0700 (PDT)
In-Reply-To: <1395788695.2076.35.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 06:04 PM, Olivier Bonvalet wrote:
> Le mardi 25 mars 2014 =C3=A0 17:46 -0500, Alex Elder a =C3=A9crit :
>> On 03/25/2014 05:17 PM, Olivier Bonvalet wrote:
>>>
>>> I now have this one very often (here 5 minutes after the host boot)=
 :
>>
>> I am fairly sure this indicates a use-after-free scenario,
>> likely caused by something getting deleted before every
>> user was done with it.
>>
>> I believe Ilya is done for the night; I'm going to spend some
>> time looking at this to try to determine the cause.  If you
>> are willing I'd love to have you try whatever fix I come up
>> with.  I'd rather find a fix than just collect more information,
>> but I may need to get more, we'll see.
>>
>> Thank you for all your reports, they help a lot.
>>
>> 					-Alex
>=20
> Ok. I can apply some patch to help debug that yes.
> I will try to reproduce on a different host, without customer data.
>=20
> But I think I will stop here for the night too.
>=20
> Thanks for your time,
> Olivier

Here's something that will provide a few more pieces of
information.  If you're around and you're able to try it
out it might confirm something had likely been destroyed.

I'll keep sending stuff as I come up with it (even though
I realize you may not be around until morning).

					-Alex


Index: b/drivers/block/rbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2132,6 +2132,35 @@ static void rbd_img_obj_callback(struct
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
+		printk("    ->kref %d\n", atomic_read(&obj_request->kref));
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
+		printk("    ->kref %d\n", atomic_read(&img_request->kref));
+	}
 	rbd_assert(which =3D=3D img_request->next_completion);

 	for_each_obj_request_from(img_request, obj_request) {

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
