From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Re: RBD image name constraints
Date: Mon, 11 Apr 2016 10:45:42 +0200
Message-ID: <570B6436.9040109@corp.ovh.com>
References: <5707A2C4.3030102@corp.ovh.com> <20160408202919.GA8043@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo174.mail-out.ovh.net ([46.105.43.252]:57996 "EHLO
	6.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcDKKD1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 06:03:27 -0400
In-Reply-To: <20160408202919.GA8043@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


On 04/08/2016 10:29 PM, Mykola Golub wrote:
> On Fri, Apr 08, 2016 at 02:23:32PM +0200, Bart=C5=82omiej =C5=9Awi=C4=
=99cki wrote:
>
>> In newer versions there's regex that's parsing image name passed to =
rbd
>> command (in src/tools/rbd/Utils.cc, function: extract_spec):
>>
>>       "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"
>>
>> It won't parse pool name with '@', image name with '/' nor snapshot =
name
>> with '/', which was allowed in previous implementation based on strc=
hr.
> And I would leave this limitation (if there were no real complains
> from users) because it could be really difficult to understand what a
> spec that had e.g. two "@" meant.
Wouldn't that cause backward compatibility issues? I.e. if I've created=
=20
image name with '/' inside, I won't be able to do anything with it afte=
r=20
upgrading to Jewel, even remove or rename it.

>
> You can still bypass the limitation by using --pool, --image, and
> --snap options, and I would recommend to always use these in scripts
> instead of specs.
>
True, but even if I specify image name with --image argument it still=20
goes through rbd::utils::extract_spec function (or set_pool_image_name=20
in old code) so there's no way to put there any raw name I want.

Regards,
Bartek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
