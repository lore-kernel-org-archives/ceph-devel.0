From: Javen Wu <javen.wu@icloud.com>
Subject: Re: Where is the source code about data movement when osdmap changes
Date: Thu, 28 Jan 2016 16:15:37 +0800
Message-ID: <56A9CE29.3030307@icloud.com>
References: <CAEO_8=-rfny49UepfcTaN-ObJitt3o9L9-CnV4MoOK1c9ogn0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp001.me.com ([17.110.69.252]:55523 "EHLO
	mr11p00im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbcA1JPv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 04:15:51 -0500
Received: from [192.168.10.243] (unknown [119.57.173.137])
 by mr11p00im-asmtp001.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O1N00CH1LMB8G30@mr11p00im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Thu, 28 Jan 2016 08:15:51 +0000 (GMT)
In-reply-to: <CAEO_8=-rfny49UepfcTaN-ObJitt3o9L9-CnV4MoOK1c9ogn0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ouyang tao <ouyangtao1988@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

OSDMap change would trigger peering and then recovery.
I assume you are referring "Peering" and "Recovery".
There are boost state machine PG::RecoveryState.

I think you can start from there...

On 2016=E5=B9=B401=E6=9C=8828=E6=97=A5 16:06, ouyang tao wrote:
> Hi, all
>      I can't find the source code about the data movement when i read
> the source code about handling the osdmap changes.  can your to finge=
r
> out the code?
>      Very appreciate your kindly reply.
>
> Thx
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
