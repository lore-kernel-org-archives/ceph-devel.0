From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Wed, 18 Jan 2012 15:43:29 -0800
Message-ID: <CAF3hT9C6zT5ShqP95pXv6+N1oPC0cR5w_dauCbAKRt2TZrBfzw@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
	<CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
	<CAF3hT9Bq6Nwan2wF54Gz0OpHWoO9pGJE1h2a-ke6=7wW4wBSrA@mail.gmail.com>
	<CA+o_KfuigaFGYvHVOk_W-gpTQryheYfc4=9v5nxemUyqhH-GQw@mail.gmail.com>
	<CAF3hT9AUFiZz01PzE9n8VYK0NJCQBFndKVsiOfAX5-ZNrNw+Og@mail.gmail.com>
	<CA+o_Kft7RWEanbBM8ZUMTaz0ucr-XEOc1tJHK7i304XnspmRyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58269 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab2ARXn3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 18:43:29 -0500
Received: by iagf6 with SMTP id f6so6741157iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 15:43:29 -0800 (PST)
In-Reply-To: <CA+o_Kft7RWEanbBM8ZUMTaz0ucr-XEOc1tJHK7i304XnspmRyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 17, 2012 at 5:08 AM, Karoly Horvath <rhswdev@gmail.com> wro=
te:
> Hi,
>
> I did this test on the new ceph 0.40-1oneiric package.
>
> I removed the power cord from beta.
>
> alpha became the new active MDS
> 2012-01-17 12:32:36.817012 =A0 mds e494: 1/1/1 up {0=3Dalpha=3Dup:act=
ive}
> but I still couldn't access the ceph fs, so I tried lazy force umount
> as you suggested:
> umount -lf ceph_mnt_point/
> but it never returned.
>
> I attached the logs.

To diagnose a problem like that we're going to need the client logs.
If nothing else there's probably some relevant output in dmesg? Also,
what kernel version?
Everything I checked looked good for the rest of the system; did you
check if new clients could do things appropriately?
-Greg

> (note: I removed a huge chunk of the alpha mds log covering approx 1 =
minute)
>
> --
> Karoly Horvath
>
>
> On Wed, Dec 21, 2011 at 4:13 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> [Re-added list]
>>
>> On Wed, Dec 21, 2011 at 4:33 AM, Karoly Horvath <rhswdev@gmail.com> =
wrote:
>>> On Wed, Dec 21, 2011 at 12:03 AM, Gregory Farnum
>>>> It looks like maybe you got it turned on in the mon section rather
>>>> than the mds or global sections. :)
>>>
>>> right
>>>
>>>> However, as I look at these a little more it generally looks good,
>>>> even in trial 3. The only alarming thing that's present is a note =
that
>>>> two of your clients failed to reconnect to the MDS in time and wer=
e
>>>> cut off. Did you try establishing a new connection to the cluster =
and
>>>> seeing if that worked? It's possible there's a client bug, or that
>>>> there was some sort of network error that interfered with them.
>>>> -Greg
>>>
>>> By client I assume you mean the kernel driver.. the FS is freezed, =
so
>>> I cannot unmount (cannot even `shutdown`).. how can I force the cli=
ent
>>> to reconnect?
>>
>> Try a lazy force unmount:
>> umount -lf ceph_mnt_point/
>> And then mount again.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
