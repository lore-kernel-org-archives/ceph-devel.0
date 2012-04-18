From: Martin Mailand <martin@tuxadero.com>
Subject: Re: rbd snapshot in qemu and libvirt
Date: Wed, 18 Apr 2012 16:55:06 +0200
Message-ID: <4F8ED5CA.7040006@tuxadero.com>
References: <4F8EBCB9.3030803@tuxadero.com> <4F8EBD4E.1050606@widodh.nl> <4F8EC028.40601@tuxadero.com> <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51121 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2DROzL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:55:11 -0400
In-Reply-To: <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi Andrey,

if I try it I get this error.

virsh snapshot-create linux1
error: Requested operation is not valid: Disk 
'rbd/vm1:rbd_cache_enabled=1' does not support snapshotting

maybe the rbd_cache option is the problem?


-martin


Am 18.04.2012 16:39, schrieb Andrey Korolyov:
> I have tested all of them about a week ago, all works fine. Also it
> will be very nice if rbd can list an actual allocated size of every
> image or snapshot in future.
>
> On Wed, Apr 18, 2012 at 5:22 PM, Martin Mailand<martin@tuxadero.com>  wrote:
>> Hi Wido,
>>
>> I am looking for doing the snapshots via libvirt, create, delete, rollback
>> and list of the snapshot.
>>
>> -martin
>>
>> Am 18.04.2012 15:10, schrieb Wido den Hollander:
>>
>>> I tested this about a year ago and that worked fine.
>>>
>>> Anything in particular you are looking for?
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

