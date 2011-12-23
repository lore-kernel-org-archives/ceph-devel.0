From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Thu, 22 Dec 2011 16:00:23 -0800
Message-ID: <CAF3hT9A=iDLWtmY_GsiS49Mi-pDNN1U0Rs3MuJsW93JFDObJ+w@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
	<CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
	<CAF3hT9Bq6Nwan2wF54Gz0OpHWoO9pGJE1h2a-ke6=7wW4wBSrA@mail.gmail.com>
	<CA+o_KfuigaFGYvHVOk_W-gpTQryheYfc4=9v5nxemUyqhH-GQw@mail.gmail.com>
	<CAF3hT9AUFiZz01PzE9n8VYK0NJCQBFndKVsiOfAX5-ZNrNw+Og@mail.gmail.com>
	<CA+o_KfvFnNqhiYuySZnhz7jdhj=MXgpiGqZA+D7Dw+fqZ7VNjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56372 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab1LWAAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 19:00:24 -0500
Received: by iaeh11 with SMTP id h11so14198563iae.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 16:00:23 -0800 (PST)
In-Reply-To: <CA+o_KfvFnNqhiYuySZnhz7jdhj=MXgpiGqZA+D7Dw+fqZ7VNjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 21, 2011 at 8:43 AM, Karoly Horvath <rhswdev@gmail.com> wrote:
> On Wed, Dec 21, 2011 at 4:13 PM, Gregory Farnum
>>> By client I assume you mean the kernel driver.. the FS is freezed, so
>>> I cannot unmount (cannot even `shutdown`).. how can I force the client
>>> to reconnect?
>>
>> Try a lazy force unmount:
>> umount -lf ceph_mnt_point/
>> And then mount again.
>
> wow, never heard about this, thanks.:)
> will report with the next mail
>
> In the meantime I did one test, killing mds+osd+mon on beta,
> it's jammed in '{0=alpha=up:replay}', after 45 minutes I shut it down...
> I attached the logs.

Oh, this is very odd! The MDS goes to sleep while it waits for an
up-to-date OSDMap, but it never seems to get woken up even though I
see the message sending in the OSDMap.

So let's try this one more time, but this time also add in "debug
objecter = 20" to the MDS config...Those logs will include everything
I need, or nothing will, promise! :)
-Greg
