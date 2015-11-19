From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: Regarding op_t, local_t
Date: Thu, 19 Nov 2015 10:27:32 +0800
Message-ID: <CANE=7sWanyn0XQm8nVNFyzwMPt6ABSbS+PeYhtDLpdCT0Hvkfw@mail.gmail.com>
References: <CO1PR02MB208676EEBEE4B862DDDF769F41B0@CO1PR02MB208.namprd02.prod.outlook.com>
	<CANE=7sW+-4XB9iqduiVL9RSwWYfj6fn2xSUp2+WJcVMyMRPxbA@mail.gmail.com>
	<CO1PR02MB20864C79565C2686B5D651FF41B0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33933 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbbKSC1d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 21:27:33 -0500
Received: by obbbj7 with SMTP id bj7so49545148obb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 18:27:33 -0800 (PST)
In-Reply-To: <CO1PR02MB20864C79565C2686B5D651FF41B0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, Roy:
My previous performance data shows that:

If we keep them separate and pass them to
ObjectStore::queue_transactions() ,the cpu usage of
ObjectStore::queue_transactions() would take up from 6.03% to 6.76%
compared with re-using op_t items.

I am happy if we could git similar performance data.

2015-11-19 10:09 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> It's a stack allocation there , no 'new' overhead , but, will save on=
e list push_back. So, gain could be negligible.
> But, since I am working on a pull request to delete these transaction=
 object from FileStore  worker thread , I need to introduce heap alloca=
tion on that path as well , reducing one transaction would help there.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: =E6=B1=A0=E4=BF=A1=E6=B3=BD [mailto:xmdxcxz@gmail.com]
> Sent: Wednesday, November 18, 2015 6:00 PM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Regarding op_t, local_t
>
> Good catch. I think it does make sense.
>
> 2015-11-19 9:54 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
>> Hi Sage,
>> I saw we are now having single transaction in submit_transaction. Bu=
t,
>> in the replication path we are still having two transaction, can't w=
e merge it to one there ?
>>
>> Thanks & Regards
>> Somnath
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards,
> xinze



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
