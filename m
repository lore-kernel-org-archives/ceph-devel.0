From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph config without ctrfs
Date: Mon, 27 Feb 2012 15:29:41 -0800
Message-ID: <CAF3hT9Ap-rqB+3B0WqUzFGhMFDTrN00HiYHAhaW0gSF_60HNnQ@mail.gmail.com>
References: <4F4C0F60.1070100@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62619 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab2B0X3m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 18:29:42 -0500
Received: by iagj37 with SMTP id j37so409264iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 15:29:41 -0800 (PST)
In-Reply-To: <4F4C0F60.1070100@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, Feb 27, 2012 at 3:18 PM, Matt Weil <mweil@genome.wustl.edu> wro=
te:
> How do you do this type of config (specifying multiple devices per se=
rver)
> on xfs not btrfs?
>
>> [osd.1]
>> =A0 =A0 =A0 =A0host =3D linuscs92
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d2
>>
>> [osd.2]
>> =A0 =A0 =A0 =A0host =3D linuscs92
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d3
>>
>> [osd.3]
>> =A0 =A0 =A0 =A0host =3D linuscs92
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d4
>>
>> [osd.4]
>> =A0 =A0 =A0 =A0host =3D linuscs92
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d5
>>
>> [osd.5]
>> =A0 =A0 =A0 =A0host =3D linuscs93
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d2
>>
>> [osd.6]
>> =A0 =A0 =A0 =A0host =3D linuscs93
>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/cciss/c1d3

The fact that it's multiple daemons per server doesn't make a
difference to configuration. If you're asking how to use xfs instead
of btrfs:
http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#creating-a-c=
eph-conf-file
has a sample config with the correct fields. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
