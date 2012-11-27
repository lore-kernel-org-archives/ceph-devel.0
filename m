From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 27 Nov 2012 11:12:12 -0600
Message-ID: <50B4F46C.7090504@inktank.com>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com> <50B4EE31.5020908@inktank.com> <8707A447F7754068A1D89D240265E1B7@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51908 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab2K0RMQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 12:12:16 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so8570965iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 09:12:16 -0800 (PST)
In-Reply-To: <8707A447F7754068A1D89D240265E1B7@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 11/27/2012 11:07 AM, Gregory Farnum wrote:
> On Tuesday, November 27, 2012 at 8:45 AM, Sam Lang wrote:
>>
>> Hi Noah,
>>
>> I was able to reproduce your issue with a similar test using the fus=
e
>> client and the clock_offset option for the mds. This is what I see
>> happening:
>>
>> clientA's clock is a few seconds behind the mds clock
>>
>> clientA creates the file
>> - the mds sets the mtime from its current time
>> - clientA acquires the exclusive capability (cap) for the file
>>
>> clientA writes to the file
>> - the mtime is updated locally (at clientA with its current time)
>>
>> clientA closes the file
>> - the exclusive cap is flushed to the mds, but the mtime is less
>> than the create mtime because of the clock skew, so the mds
>> doesn't update it to the mtime from clientA's write
>>
>> clientA stats the file
>> - the mtime from the write (still cached) gets returned. I saw a
>> race in my tests, where sometimes the mtime was from the cache
>> (if the flush hadn't completed I assume), and sometimes it was
>> from the mds.
>>
>> clientB stats the file
>> - the exclusive cap is revoked at clientA, but the mtime returned
>> to clientB is from the mds
>
> Hurray, I think we all agree about what's happening now! :)
>
> Have you checked to see if the MDS ever sets mtime after create, or i=
s it always dictated by the client following that?

It sets it on truncate as well.
-sam

>
>>
>> The goal of the current implementation is to provide an mtime that i=
s
>> non-decreasing, but that conflicts with using mtime as a version in =
this
>> case. Using mtime as a version has its own set of problems, but I wo=
n't
>> go into that here. I think there are a few alternatives if we want t=
o
>> try to have a more consistent mtime value across clients.
>>
>> 1. Let the client set the create mtime. This avoids the issue that t=
he
>> mds and client clocks are out of sync, but in other cases where the
>> client has a clock a few seconds ahead of other clients, we run into=
 a
>> similar problem. This might be reasonable considering clients that
>> share state will more likely have synchronized clocks than the clien=
ts
>> and mds.
>>
>> 2. Provide a config option to always set the mtime on cap flush/revo=
ke,
>> even if its less than the current mtime. This breaks the non-decreas=
ing
>> behavior, and requires the user set a config option across the clust=
er
>> if they want this.
>>
>> 3. When a client acquires the cap for a file, have the mds provide i=
ts
>> current time as well. As the client updates the mtime, it uses the
>> timestamp provided by the mds and the time since the cap was acquire=
d.
>> Except for the skew caused by the message latency, this approach all=
ows
>> the mtime to be based off the mds time, so it will be consistent acr=
oss
>> clients and the mds. It does however, allow a client to set an mtime=
 to
>> the future (based off of its local time), which might be undesirable=
,
>> but that is more like how NFS behaves. Message latency probably won'=
t
>> be much of an issue either, as the granularity of mtime is a second.
>> Also, the client can set its cap acquired timestamp to the time at w=
hich
>> the cap was requested, ensuring that the relative increment includes=
 the
>> round trip latency so that the mtime will always be set further ahea=
d.
>> Of course, this approach would be a lot more intrusive to implement.=
 :-)
>
> I actually like this third approach of letting the MDS be authoritati=
ve about time even if it's not directly involved. Given that, I wonder =
if perhaps the client should just have time translation functions it us=
es everywhere?
> However, the problem with that is that the different MDS daemons migh=
t also disagree about time. Perhaps they could adopt the master MDS clo=
ck or something skanky like that=E2=80=A6 :/
>
> The fundamental issue of time resolution is why things are the way th=
ey are now, of course =E2=80=94 you usually don't want things going "ba=
ckwards" in time, but clock skews are a real problem in large clusters =
so we just decided to not let things go back on the assumption it would=
 be a temporary and little-noticed disparity, with easy-to-understand b=
ehavior. Obviously we were wrong about it being little-noticed.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
