From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Where is the source code about data movement when osdmap changes
Date: Thu, 28 Jan 2016 20:12:19 +0800
Message-ID: <CABAwU-ZKCD2_7MFN_VhHUmdgPrxmTkFvWS=EO8O8oQmqcTx5Ug@mail.gmail.com>
References: <CAEO_8=-rfny49UepfcTaN-ObJitt3o9L9-CnV4MoOK1c9ogn0Q@mail.gmail.com>
	<56A9CE29.3030307@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34318 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbcA1MMU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 07:12:20 -0500
Received: by mail-lb0-f169.google.com with SMTP id cl12so22239382lbc.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 04:12:20 -0800 (PST)
In-Reply-To: <56A9CE29.3030307@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Javen Wu <javen.wu@icloud.com>
Cc: ouyang tao <ouyangtao1988@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

you can start at  OSD::handle_osd_map function, it trigger the peering
process when osdmap changed

2016-01-28 16:15 GMT+08:00 Javen Wu <javen.wu@icloud.com>:
> OSDMap change would trigger peering and then recovery.
> I assume you are referring "Peering" and "Recovery".
> There are boost state machine PG::RecoveryState.
>
> I think you can start from there...
>
>
> On 2016=E5=B9=B401=E6=9C=8828=E6=97=A5 16:06, ouyang tao wrote:
>>
>> Hi, all
>>      I can't find the source code about the data movement when i rea=
d
>> the source code about handling the osdmap changes.  can your to fing=
er
>> out the code?
>>      Very appreciate your kindly reply.
>>
>> Thx
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
thanks
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
