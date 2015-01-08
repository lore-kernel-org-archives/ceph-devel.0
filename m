From: "joel.merrick@gmail.com" <joel.merrick@gmail.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Thu, 8 Jan 2015 08:49:54 +0000
Message-ID: <CA+wb_2t-F2NCdXi5fiF+Jjg5yJyJ6Gw3956Zh9yrDv6_NxErTw@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
	<54AA7246.9070303@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:46286 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbbAHIt4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 03:49:56 -0500
Received: by mail-wg0-f48.google.com with SMTP id l2so1337173wgh.7
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jan 2015 00:49:55 -0800 (PST)
In-Reply-To: <54AA7246.9070303@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 11:15 AM, Wido den Hollander <wido@42on.com> wrote:
>
>
> On 05-01-15 11:53, Chaitanya Huilgol wrote:
>>
>> Hi All,
>>
>> The stock ceph-client modules with Ubuntu 14.04 LTS are quite dated and we
>> are seeing crashes and soft-lockup issues which have been fixed in the
>> current ceph-client code base.
>> What would be recommended ceph-client branch compatible with the Ubuntu
>> 14.04 (3.13.0-x) kernels so that we can get as many fixes as possible?
>>
>
> I recommend you take a look here:
> http://kernel.ubuntu.com/~kernel-ppa/mainline/
>
> That should give you some new kernels.

Just to throw in another method... Ubuntu also ship the kernels for
newer non-LTS releases (as well as X components and other cherry
picked bits) in their LTS releases too. So linux-generic-lts-utopic
currently exists in 14.04. As Ilya mentioned though, the fixes should
be marked anyway in the stock ubuntu 14.04 kernels (I use them without
issue but use case may vary), but could be useful knowledge for
someone.



-- 
$ echo "kpfmAdpoofdufevq/dp/vl" | perl -pe 's/(.)/chr(ord($1)-1)/ge'
