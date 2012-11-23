From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 07:18:16 -0600
Message-ID: <50AF7798.9060303@inktank.com>
References: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63652 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2KWNSP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 08:18:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so3325684iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 05:18:15 -0800 (PST)
In-Reply-To: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Agreed with Alexandre, try putting the journal on a raw partition.=20
That's pretty insane!  What controller are you using again?

Mark

On 11/23/2012 05:03 AM, Alexandre DERUMIER wrote:
> so correcly aligned...
>
> Maybe try to use journal directly on the full partition, without xfs =
?
>
>
> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "ceph-devel" <ceph-devel=
@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9basti=
en Han" <han.sebastien@gmail.com>
> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:49:10
> Objet: Re: RBD fio Performance concerns
>
> Am 23.11.2012 11:47, schrieb Alexandre DERUMIER:
>>>> when i switch the journal to the OSD Disk seperate partiton on eac=
h disk
>>>> (/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from 2=
3.000
>>>> iops to 200 iops random 4k.
>> O_o , that's seem crazy...
>> Are you sure that your partitions are correctly aligned ? (starting =
first partition at sector 2048 is best for ssd)
>
> Model: ATA INTEL SSDSC2CW24 (scsi)
> Disk /dev/sdb: 468862128s
> Sector size (logical/physical): 512B/512B
> Partition Table: gpt
>
> Number Start End Size File system Name Flags
> 1 2048s 2342911s 2340864s xfs pri
> 2 2342912s 468860927s 466518016s xfs pri
>
> Stefan
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
