From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd error: kernel BUG at fs/bio.c:1499!
Date: Wed, 25 May 2011 10:53:45 -0700
Message-ID: <BANLkTinuS48VO7nzm_a5ooVEXzQyZn_d7w@mail.gmail.com>
References: <BANLkTi=L4S39cG+Ns+FQMC3+92ubXw0ODg@mail.gmail.com>
	<Pine.LNX.4.64.1105250857110.29945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52300 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1EYRxr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 13:53:47 -0400
Received: by bwz15 with SMTP id 15so6739604bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 10:53:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105250857110.29945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 25, 2011 at 8:57 AM, Sage Weil <sage@newdream.net> wrote:
> Hi created tracker issue 1109 for this. =A0We'll look at it today.
>
> sage
>
>
> On Wed, 25 May 2011, huang jun wrote:
>
>> hi,all
>> Recently,i got a error when write a file to rbd mount directory.
>> what i have done are below:
>> =A0 mkfs.btrfs /dev/rbd0
>> =A0 mount /dev/rbd0 =A0/rbd
>> =A0 then, i write a 400M file in /rbd
>> the errors are:
>> May 25 10:20:29 T02-MON12 kernel: [ =A0159.004710] rbd: =A0fetched r=
equest
>> May 25 10:20:29 T02-MON12 kernel: [ =A0159.004711] rbd: =A0write 0x1=
f000
>> bytes at 0x8bf0000
>> May 25 10:20:29 T02-MON12 kernel: [ =A0159.004712] rbd: =A0rq->bio->=
bi_vcnt=3D31
>> May 25 10:20:29 T02-MON12 kernel: [ =A0159.004714] rbd: =A0bio_chain=
_clone
>> split! total=3D0 remaining=3D65536bi_size=3D126976

We recently fixed a bug in that area and the fix just made into the
latest kernel. Can you verify that this still happens with 2.6.39?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
