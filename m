From: Simon Tian <aixt2006@gmail.com>
Subject: Re: snapshot of rbd
Date: Mon, 13 Jun 2011 13:43:36 +0800
Message-ID: <BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43577 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab1FMFni convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 01:43:38 -0400
Received: by wwa36 with SMTP id 36so4486048wwa.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 22:43:37 -0700 (PDT)
In-Reply-To: <BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---------- Forwarded message ----------
=46rom: Simon Tian <aixt2006@gmail.com>
Date: 2011/6/13
Subject: Re: snapshot of rbd
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>


2011/6/13 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
> On Sun, Jun 12, 2011 at 7:02 AM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>>
>> hi guys,
>>
>> =C2=A0 =C2=A0I have some questions about librbd snapshot:
>>
>> =C2=A0int snap_create(const char *snapname);
>> =C2=A0int snap_remove(const char *snapname);
>> =C2=A0int snap_rollback(const char *snap_name);
>> =C2=A0int snap_set(const char *snap_name);
>>
>> =C2=A0int copy(IoCtx& src_io_ctx, const char *srcname, IoCtx& dest_i=
o_ctx,
>> const char *destname);
>>
>> If I create a snapshot S1, and then write 10GB data, and then I want
>> to create a snapshot S2. About how long time will the "snap_create"
>> take? =C2=A0May take just several seconds?
>
> Yes. It updates the header, and sends notifications (through the osd)
> to the other clients.



>> And how long will it task when remove S2?
>
> Same as creating it.
>
>
>> How long when rollback to S1?
>
> Rollback is (currently) is in the order of the number of object of
> that image. It needs to go through all the objects and execute an
> explicit request of each. For very large images it can be quite long.

When a VM is running based on rbd image, and need to rollback to S1.
During rollback, seem like that data written by the VM is not allowed?
Is there any way to rollback without affecting the user experience of t=
he VM?


Thx
Simon
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
