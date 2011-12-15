From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:44:40 +0100
Message-ID: <4EEA23F8.10209@tuxadero.com>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <4EEA2174.2060002@widodh.nl> <4EEA2299.6070601@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48711 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab1LOQop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 11:44:45 -0500
In-Reply-To: <4EEA2299.6070601@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

Hi,
at least there is a patch that should have fixed it.

http://marc.info/?l=ceph-devel&m=131955913203561&w=2

Am 15.12.2011 17:38, schrieb Martin Mailand:
> Hi Wido,
> but wasn't that fixed a few weeks ago?
>
> -martin
>
> Am 15.12.2011 17:33, schrieb Wido den Hollander:
>> Yes, from what I've seen it will block indefinitely until you restart
>> one of the OSDs who are member of the PG.
>>
>> Wido
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

