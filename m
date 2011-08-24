From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: mount errors
Date: Wed, 24 Aug 2011 08:56:02 -0600
Message-ID: <CALFpzo5hZ9AZu6aDoarROUK8wdKDnecALSFsC8rDjuzG78s62A@mail.gmail.com>
References: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
	<Pine.LNX.4.64.1108222142490.9949@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52531 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1HXO4D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 10:56:03 -0400
Received: by wwf5 with SMTP id 5so1304366wwf.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 07:56:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108222142490.9949@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jojy Varghese <jojy.varghese@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I have also seen this on occasion when I unmount client, rebuild, then
mount client all without rebooting client. I have done so much that I
cannot for sure say what the exact conditions were, but I know I have
gotten it when rebuilding an unmounted fs. Passing the "fsid=3D" mount
option with the new fsid gets around it if I recall.

On Mon, Aug 22, 2011 at 10:43 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 22 Aug 2011, Jojy Varghese wrote:
>> Hi
>> =A0I am getting "libceph: bad fsid, had
>> e49ae577-0f7b-24e0-1c75-10ae17d9f86b got
>> 3c9b15ef-c2d0-1318-4d12-3508025ccd97" on attempting to mount the fs.
>> Any quick fixes?
>
> This means the client is getting data from a different file system th=
an it
> originally mounted. =A0Probably you had the client mounted, rebuilt t=
he fs
> and restarted the monitors, and now the client is confused because th=
e
> servers were changed out from underneath it.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
