From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: ceph/rbd benchmarks
Date: Wed, 24 Aug 2011 11:19:07 -0600
Message-ID: <CALFpzo4+oaiuBT5E5EPZk4dcF2D_NDt67UGC5Kj+146LyAvMCg@mail.gmail.com>
References: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
	<CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
	<Pine.LNX.4.64.1108240943460.20147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65524 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab1HXRTJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 13:19:09 -0400
Received: by qyk38 with SMTP id 38so2859349qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 10:19:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108240943460.20147@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

I knew I read the acronym in a pdf somewhere (something from '08 I
think), but I couldn't find it when I needed it, thanks.

Everything was running 3.1-rc1, I checked the kernel source before
building and it already included the following patches, so I assumed I
was good on the readahead thing.

https://patchwork.kernel.org/patch/1001462/
https://patchwork.kernel.org/patch/1001432/

On Wed, Aug 24, 2011 at 10:46 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 24 Aug 2011, Gregory Farnum wrote:
>> On Wed, Aug 24, 2011 at 8:29 AM, Marcus Sorensen <shadowsor@gmail.co=
m> wrote:
>> > Just thought I'd share this basic testing I did, comparing cephfs =
0.32
>> > on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys see a=
 lot
>> > of this. Any feedback would be appreciated.
>> >
>> > The data is here:
>> >
>> > http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-iscsi=
-benchmarks.ods
>> >
>> > and the writeup is here:
>> >
>> > http://learnitwithme.com/?p=3D303
>>
>> We see less of it than you'd think, actually. Thanks!
>>
>> To address a few things specifically
>> Ceph is both the name of the project and of the POSIX-compliant
>> filesystem. RADOS stands for Reliable Autonomous Distributed Object
>> Store. Apparently we should publish this a bit more. :)
>>
>> Looks like most of the differences in your tests have to do with our
>> relatively lousy read performance -- this is probably due to lousy
>> readahead, which nobody's spent a lot of time optimizing as we focus
>> on stability. Sage made some improvements a few weeks ago but I don'=
t
>> remember what version of stuff they ended up in. :) (Optimizing
>> cross-server reads is hard!)
>
> The readahead improvements are in the 'master' branch of ceph-client.=
git,
> and will go upstream for Linux 3.2-rc1 (I just missed the 3.1-rc1 cut=
off).
> In my tests I was limited by the wire speed with these patches. =A0I'=
m
> guessing you were using 3.0 or earlier kernel?
>
> The file copy test was also surprising. =A0I think there is a regress=
ion
> there somewhere, taking a look.
>
> sage
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
