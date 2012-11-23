From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd import from stdin
Date: Fri, 23 Nov 2012 15:07:42 +0100
Message-ID: <50AF832E.9050402@profihost.ag>
References: <9a1238da-8eb3-4080-b331-26890d51b9aa@mailpro> <50AF535D.5080602@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55531 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2KWOHw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 09:07:52 -0500
In-Reply-To: <50AF535D.5080602@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Hi,

even with size it does not work:

Am 23.11.2012 11:43, schrieb Stefan Priebe - Profihost AG:
> ah so right now the size parameter is needed. But i don't know the si=
ze
> ;-) file is gzip compressed ;-)

gzip -d -c vm-101-disk-1.img.gz | rbd import --size=3D42945478656 -=20
kvmpool1/vm-101-disk-1
rbd: image creation failed
2012-11-23 15:05:49.300363 7f5a599cc760 -1 librbd: rbd image=20
vm-101-disk-1 already existsrbd: import failed:
(17) File exists

Greets,
Stefan

> Stefan
> Am 23.11.2012 11:25, schrieb Alexandre DERUMIER:
>>
>> import for stdin already work like this:
>>
>> rbd import --size=3Dxxx - image < stdin
>>
>> from this patch
>>
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6315
>>
>>
>> (so I think you just need to specify --size)
>>
>>
>>
>> ----- Mail original -----
>>
>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>> =C3=80: ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:15:11
>> Objet: rbd import from stdin
>>
>> Hello,
>>
>> i was looking at the wip-rbd-export-stdout branch which also allows =
to
>> import from stdin.
>>
>> But it doesn't seem to work:
>>
>> gzip -d -c vm-101-disk-1.img.gz | rbd import - kvmpool1/vm-101-disk-=
1
>> rbd: unable to get size of file/block device: (25) Inappropriate ioc=
tl
>> for device
>> rbd: import failed: (25) Inappropriate ioctl for device
>>
>> Greets,
>> Stefan
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
