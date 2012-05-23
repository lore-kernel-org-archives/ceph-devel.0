From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 01:29:51 -0700
Message-ID: <4FBC9FFF.6090605@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com> <4FBC8B41.1020300@profihost.ag> <4FBC8F8F.6060004@inktank.com> <4FBC9DDB.5090507@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39599 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab2EWI3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 04:29:54 -0400
Received: by pbbrp8 with SMTP id rp8so9564451pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 01:29:53 -0700 (PDT)
In-Reply-To: <4FBC9DDB.5090507@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 05/23/2012 01:20 AM, Stefan Priebe - Profihost AG wrote:
> Am 23.05.2012 09:19, schrieb Josh Durgin:
>> On 05/23/2012 12:01 AM, Stefan Priebe - Profihost AG wrote:
>>> Am 23.05.2012 08:30, schrieb Josh Durgin:
>>>> On 05/22/2012 11:18 PM, Stefan Priebe - Profihost AG wrote:
>>>>> Hi,
>>>>>
>>>>>>> So try enabling RBD writeback caching =E2=80=94 see http://marc=
=2Einfo
>>>>>>> /?l=3Dceph-devel&m=3D133758599712768&w=3D2
>>>>>>> will test tomorrow. Thanks.
>>>>> Can we path this to the qemu-drive option?
>>>>
>>>> Yup, see
>>>> http://article.gmane.org/gmane.comp.file-systems.ceph.devel/6400
>>> I'm sorry, i still don't get it where to pass rbd_cache_max_dirty, =
=2E..
>>> can i add it just to the ceph.conf? Even with qemu 1.0?
>>
>> You can use any of the rbd-specific options (like rbd_cache_max_dirt=
y)
>> with qemu>=3D 0.15.
>>
>> You can set them in a global ceph.conf file, or specify them on the =
qemu
>> command line like:
>>
>> qemu -m 512 -drive
>> file=3Drbd:pool/image:rbd_cache_max_dirty=3D0:rbd_cache=3Dtrue,forma=
t=3Draw,if=3Dvirtio
>
> So this is enough for testing on kvm host?
>
> /etc/ceph/ceph.conf
>
> [global]
>          auth supported =3D cephx
>          keyring =3D /etc/ceph/$name.keyring
>          rbd_cache =3D true
>          rbd_cache_size =3D 32M

This should be a number in bytes - M/G/k/etc aren't parsed. Assuming yo=
u=20
have the monitors listed below, this is fine. If you're not using the=20
admin user, you'll need to add :id=3Dname to the -drive string - it can=
't=20
be set in the config file.

>          rbd_cache_max_age =3D 2.0
>
> ...
>
> Stefan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
