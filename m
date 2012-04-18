From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: rbd snapshot in qemu and libvirt
Date: Wed, 18 Apr 2012 18:39:03 +0400
Message-ID: <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com>
References: <4F8EBCB9.3030803@tuxadero.com> <4F8EBD4E.1050606@widodh.nl> <4F8EC028.40601@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64308 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2DROjZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:39:25 -0400
Received: by wejx9 with SMTP id x9so4764146wej.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:39:24 -0700 (PDT)
In-Reply-To: <4F8EC028.40601@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

I have tested all of them about a week ago, all works fine. Also it
will be very nice if rbd can list an actual allocated size of every
image or snapshot in future.

On Wed, Apr 18, 2012 at 5:22 PM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi Wido,
>
> I am looking for doing the snapshots via libvirt, create, delete, rol=
lback
> and list of the snapshot.
>
> -martin
>
> Am 18.04.2012 15:10, schrieb Wido den Hollander:
>
>> I tested this about a year ago and that worked fine.
>>
>> Anything in particular you are looking for?
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
