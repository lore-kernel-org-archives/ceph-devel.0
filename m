From: Pawel Stefanski <pejotes@gmail.com>
Subject: Re: fix for issue with RGW on larger than 528k downloads
Date: Wed, 18 Dec 2013 23:03:32 +0100
Message-ID: <CAC96waGkiMTDOMwv-XXN0KdOWOig4=6rus5w-yoy7OrfV0O5Jg@mail.gmail.com>
References: <CAC96waHg9nm3txHCDdqMeKZboBKgt1c-DoVQ+irJ3u7fWrGD5w@mail.gmail.com>
	<CABBk=J9Lg8ekDmGYisC0Sq+UaWWoBm6_vHXADeXG1yTrOgznQg@mail.gmail.com>
Reply-To: pejotes@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43593 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3LRWDd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 17:03:33 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so273177wgh.9
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 14:03:32 -0800 (PST)
In-Reply-To: <CABBk=J9Lg8ekDmGYisC0Sq+UaWWoBm6_vHXADeXG1yTrOgznQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hello!

At first glance it seems to work :-) We will test it in next hours,
but now looks great.

Thank you very, very, very much!!!!

best regards!

On Wed, Dec 18, 2013 at 5:11 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Wed, Dec 18, 2013 at 1:53 AM, Pawel Stefanski <pejotes@gmail.com> wrote:
>> hello!
>>
>> We are struggling with issue on downloading bigger files since some
>> time, on ceph-users there were some complains about this but without
>> any conclusions or with misunderstood cause (as a solution there was
>> proposed new http serwer for example nginx, where the cause is
>> somewhere in radosgw).
>>
>> I see that cluster at dreamhost suffered the same issue recently,
>> could community get the same path/workaround for the stalling download
>> issue ?
>>
>
> Sure. It's not on a proper release yet. but it's out there if you want
> to give it a try (wip-rgw-getobj-cb). We'll get it on a proper release
> soon.
>
> Yehuda
