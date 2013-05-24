From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as
 storage-backend
Date: Fri, 24 May 2013 17:15:36 +0200
Message-ID: <519F8418.6080707@filoo.de>
References: <519F1AED.80005@filoo.de> <519F8273.1000307@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:42739 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab3EXPPi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 11:15:38 -0400
In-Reply-To: <519F8273.1000307@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well,

On 05/24/2013 05:08 PM, Wido den Hollander wrote:
> On 05/24/2013 09:46 AM, Oliver Francke wrote:
>> Hi,
>>
>> with a running VM I encounter this strange behaviour, former
>> qemu-versions don't show up such an error.
>> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination
>> with ceph-0.56.6? Therefore my
>> crosspost.
>>
>> Even if I have no real live-snapshot avail - they know of this
>> restriction -, it's more work for the customers
>> to perform a shutdown before the wonna do some changes to their VM ;=
)
>>
>
> Doesn't Qemu try to save the memory state to RBD here as well? That=20
> doesn't work and fails.

true, but that should qemu try in version 1.4.x, too, but that succeeds=
 ;)

Tried to figure out some corresponding QMP-commands, found some=20
references like:

{"execute": "snapshot-create", "arguments": {"name": "vm_before_upgrade=
"} }


but that fails with unknown command.

The convenience for a monitoring-command would be, that qemu cares for=20
all mounted block-devs, well,
it _should_ exclude some "ide-cd0" devices, where I get another error=20
with an inserted CD, but... other error,

Oliver.

>
>> Any hints welcome,
>>
>> Oliver.
>>
>
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
