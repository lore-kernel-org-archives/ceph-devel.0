From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Wed, 21 Dec 2011 08:13:37 -0800
Message-ID: <CAF3hT9AUFiZz01PzE9n8VYK0NJCQBFndKVsiOfAX5-ZNrNw+Og@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
	<CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
	<CAF3hT9Bq6Nwan2wF54Gz0OpHWoO9pGJE1h2a-ke6=7wW4wBSrA@mail.gmail.com>
	<CA+o_KfuigaFGYvHVOk_W-gpTQryheYfc4=9v5nxemUyqhH-GQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57986 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1LUQNh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 11:13:37 -0500
Received: by iaeh11 with SMTP id h11so12080628iae.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2011 08:13:37 -0800 (PST)
In-Reply-To: <CA+o_KfuigaFGYvHVOk_W-gpTQryheYfc4=9v5nxemUyqhH-GQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

[Re-added list]

On Wed, Dec 21, 2011 at 4:33 AM, Karoly Horvath <rhswdev@gmail.com> wrote:
> On Wed, Dec 21, 2011 at 12:03 AM, Gregory Farnum
>> It looks like maybe you got it turned on in the mon section rather
>> than the mds or global sections. :)
>
> right
>
>> However, as I look at these a little more it generally looks good,
>> even in trial 3. The only alarming thing that's present is a note that
>> two of your clients failed to reconnect to the MDS in time and were
>> cut off. Did you try establishing a new connection to the cluster and
>> seeing if that worked? It's possible there's a client bug, or that
>> there was some sort of network error that interfered with them.
>> -Greg
>
> By client I assume you mean the kernel driver.. the FS is freezed, so
> I cannot unmount (cannot even `shutdown`).. how can I force the client
> to reconnect?

Try a lazy force unmount:
umount -lf ceph_mnt_point/
And then mount again.
