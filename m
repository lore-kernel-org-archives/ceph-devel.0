From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 12:50:50 -0800
Message-ID: <AANLkTimQDB=--AwvqGAt7Fvj996coUUPNGkb114NnQxY@mail.gmail.com>
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
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34577 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab1BYUuw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 15:50:52 -0500
Received: by wyg36 with SMTP id 36so1994871wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 12:50:51 -0800 (PST)
In-Reply-To: <AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
But in the case of two different files, it is clear that you're
opening a specific file. A pool handle is similar to a file, however,
when you're using a file handle you can write to a specific file,
whereas with a pool handle you can (though not necessarily supposed
to) write to different objects. That is, a pool is more of a partition
than a single file, so the analogy is not quite right.
The pool handle should only be used with objects that share the same
context, but there's nothing in the infrastructure that prevents users
to misuse it, and the penalty for using the wrong snap context can be
very high (loss of data).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
