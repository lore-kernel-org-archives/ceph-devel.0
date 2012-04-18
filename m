From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: rbd snapshot in qemu and libvirt
Date: Wed, 18 Apr 2012 19:52:30 +0400
Message-ID: <CABYiri_GOHwpOZ2ZOUU4xTtHDmJFC01f07c2nQZ3yxT9j7m1Rg@mail.gmail.com>
References: <4F8EBCB9.3030803@tuxadero.com> <4F8EBD4E.1050606@widodh.nl>
 <4F8EC028.40601@tuxadero.com> <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com>
 <4F8ED5CA.7040006@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39386 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab2DRPwy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 11:52:54 -0400
Received: by wibhq7 with SMTP id hq7so841809wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 08:52:51 -0700 (PDT)
In-Reply-To: <4F8ED5CA.7040006@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Oh, I forgot to say about a patch:

https://www.redhat.com/archives/libvir-list/2012-March/msg01369.html

On Wed, Apr 18, 2012 at 6:55 PM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi Andrey,
>
> if I try it I get this error.
>
> virsh snapshot-create linux1
> error: Requested operation is not valid: Disk 'rbd/vm1:rbd_cache_enab=
led=3D1'
> does not support snapshotting
>
> maybe the rbd_cache option is the problem?
>
>
> -martin
>
>
> Am 18.04.2012 16:39, schrieb Andrey Korolyov:
>
>> I have tested all of them about a week ago, all works fine. Also it
>> will be very nice if rbd can list an actual allocated size of every
>> image or snapshot in future.
>>
>> On Wed, Apr 18, 2012 at 5:22 PM, Martin Mailand<martin@tuxadero.com>
>> =C2=A0wrote:
>>>
>>> Hi Wido,
>>>
>>> I am looking for doing the snapshots via libvirt, create, delete,
>>> rollback
>>> and list of the snapshot.
>>>
>>> -martin
>>>
>>> Am 18.04.2012 15:10, schrieb Wido den Hollander:
>>>
>>>> I tested this about a year ago and that worked fine.
>>>>
>>>> Anything in particular you are looking for?
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
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
