From: Christian Brunner <c.m.brunner@gmail.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v7)
Date: Mon, 15 Nov 2010 18:04:49 +0100
Message-ID: <AANLkTik0=3tDxu+PMA-JzGwLaCYRGQfRugm36h3L=xvn@mail.gmail.com>
References: <20101015195424.GA4094@dell.home>
	<AANLkTikE3UX8AxmfiwwVgR7_NxL=p=1CCD+6wwomwBkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33904 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab0KOREv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 12:04:51 -0500
In-Reply-To: <AANLkTikE3UX8AxmfiwwVgR7_NxL=p=1CCD+6wwomwBkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com

Hi Stefan,

thanks for your feedback. Yehuda and Sage have already committed some
pathes to our git repository.

What I'm not sure about is the rados_(de)initialization for multiple
rbd images. I suspect that _deinitialize should only be called for the
last rbd image.

Yehuda and Sage know librados a lot better than me. I pretty sure,
that they will give some feedback about this remaining issue. After
that we will send an updated patch.

Regards,
Christian

2010/11/11 Stefan Hajnoczi <stefanha@gmail.com>:
> On Fri, Oct 15, 2010 at 8:54 PM, Christian Brunner <chb@muc.de> wrote=
:
>> [...]
>> +
>> + =A0 =A0if ((r =3D rados_initialize(0, NULL)) < 0) {
>> + =A0 =A0 =A0 =A0error_report("error initializing");
>> + =A0 =A0 =A0 =A0return r;
>> + =A0 =A0}
>
> Does rados_initialize() work when called multiple times? =A0This woul=
d happen if
> the VM has several rbd devices attached.
>
> [...]
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
