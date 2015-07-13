From: Wido den Hollander <wido@42on.com>
Subject: Re: rads gateway Parallel Uploads
Date: Mon, 13 Jul 2015 08:36:42 +0200
Message-ID: <55A35C7A.1000000@42on.com>
References: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com> <55A357A3.7060002@42on.com> <D891CEBE-6A3A-468E-940A-A57B93110D02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47558 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbGMGga (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 02:36:30 -0400
In-Reply-To: <D891CEBE-6A3A-468E-940A-A57B93110D02@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?546LIOWBpQ==?= <jason.jianwang@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 13-07-15 08:32, =E7=8E=8B =E5=81=A5 wrote:
> Does rados gateway support object composition? Like Google could stor=
age, user can upload divide a large object into several objects and upl=
oad parallel, then combine them as a single object.
> Thanks
> Jian

Yes, that is how multipart uploads work. The RADOS Gatewas supports it.

Wido

>> On Jul 13, 2015, at 2:16 AM, Wido den Hollander <wido@42on.com> wrot=
e:
>>
>>
>>
>> On 13-07-15 08:07, =E7=8E=8B =E5=81=A5 wrote:
>>> Hello Cepher,
>>> I am working on prorting Google Cloud Storage API to rados gateway =
and I notice that Google Cloud Storage support parallel uploads as belo=
w:
>>> "Object composition enables a simple mechanism for uploading an obj=
ect in parallel: simply divide your data into as many chunks as require=
d to fully utilize your available bandwidth, upload each chunk to a dis=
tinct object, compose your final object, and delete any temporary objec=
ts. =E2=80=9C
>>> So I am wondering whether radios gateway support the similar featur=
e to let user parallel upload large objects?
>>
>> Yes, you can do a multipart upload with the RADOS gateway, no proble=
m.
>>
>> Wido
>>
>>> Thanks
>>> Jian
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
