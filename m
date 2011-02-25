From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 12:49:45 -0800
Message-ID: <AANLkTi=XvPve25vPewN_37rbJVM8QauqU9Os9oEZpu2M@mail.gmail.com>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
	<87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
	<Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
	<AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
	<AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
	<Pine.LNX.4.64.1102251143450.23080@cobra.newdream.net>
	<AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab1BYUvQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 15:51:16 -0500
Received: by fxm17 with SMTP id 17so2073735fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 12:51:14 -0800 (PST)
In-Reply-To: <AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Another idea: pool_t -> pool_context_t, PoolHandle -> PoolContext
?

C.


On Fri, Feb 25, 2011 at 12:24 PM, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> On Fri, Feb 25, 2011 at 11:48 AM, Sage Weil <sage@newdream.net> wrote=
:
>> We're definitely moving into bikeshedding territory now, but one thi=
ng
>> Yehuda suggested:
>>
>> The pool handle (rados_pool_t, PoolHandle) has state associated with=
 it,
>> including the snap to read from or snap context to write with. =A0Th=
at's not
>> obvious from the name. =A0Maybe it should be renamed rados_ioctx_t t=
o be
>> more clear. =A0Then the pool we're reading to/writing from becomes o=
ne more
>> piece of state associated with the handle.
>
> PoolHandle in the C++ API and pool_t in the C API map onto
> RadosClient::PoolCtx, which contains the aforementioned state. So if
> we change this in the C++ API, we should change it all the way
> through, and rename pool_t, RadosClient::PoolCtx, etc.
>
> Should we? I could go either way. The concept of a handle itself
> having properties is not really unfamiliar. After all, two different
> processes can open two different file descriptors referring to the
> same file, but one with O_RDONLY, and the other with O_WRONLY. etc. A
> handle to a thing is not the same as the thing itself.
>
> Colin
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
