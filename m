From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: ceph/rbd benchmarks
Date: Fri, 26 Aug 2011 14:53:10 -0600
Message-ID: <CALFpzo7-1PzMdqT+_K_JMK1Dp01GFGo0NgQ9Hb213wWhUbpZgw@mail.gmail.com>
References: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
	<CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
	<Pine.LNX.4.64.1108240943460.20147@cobra.newdream.net>
	<CALFpzo4+oaiuBT5E5EPZk4dcF2D_NDt67UGC5Kj+146LyAvMCg@mail.gmail.com>
	<Pine.LNX.4.64.1108241048420.20147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57484 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab1HZUxM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 16:53:12 -0400
Received: by wyg24 with SMTP id 24so2757725wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 13:53:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108241048420.20147@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

I applied the patches to the client's existing kernel version, here
are the results with respect to the pre-patch:

seq char write	100.60%
seq blk write	97.18%
seq blk rewrite	120.07%
seq char read	161.52%
seq blk read	162.30%
seeks	141.93%
seq create	76.02%
seq read	186.78%
seq delete	103.18%
rand create	91.50%
rand read	86.34%
rand delete	84.94%


seq reads are now limited by the NIC like the other filesystems.
Rewrite also got a nice bump, as well as the other sequential reads,
but strangely the sequential create is down a non-trivial amount. I
expected the possibility of a small hit to random.

On Wed, Aug 24, 2011 at 11:51 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 24 Aug 2011, Marcus Sorensen wrote:
>> I knew I read the acronym in a pdf somewhere (something from '08 I
>> think), but I couldn't find it when I needed it, thanks.
>>
>> Everything was running 3.1-rc1, I checked the kernel source before
>> building and it already included the following patches, so I assumed=
 I
>> was good on the readahead thing.
>>
>> https://patchwork.kernel.org/patch/1001462/
>> https://patchwork.kernel.org/patch/1001432/
>
> Yeah, those two help marginally, but the big fix is
>
> http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommit;h=3D78e6=
69966f994964581167c6e25c83d22ebb26c6
>
> and you'd probably also want
>
> http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommitdiff;h=3D=
6468bfe33c8e674509e39e43fad6bc833398fee2
>
> Those are in linux-next and will be sent upstream for 3.2-rc1.
>
> Not sure if it's worth rerunning your tests just yet (I want to look =
at
> the MDS stuff still), but it should fix the sequential read performan=
ce.
>
> sage
>
>
>>
>> On Wed, Aug 24, 2011 at 10:46 AM, Sage Weil <sage@newdream.net> wrot=
e:
>> > On Wed, 24 Aug 2011, Gregory Farnum wrote:
>> >> On Wed, Aug 24, 2011 at 8:29 AM, Marcus Sorensen <shadowsor@gmail=
=2Ecom> wrote:
>> >> > Just thought I'd share this basic testing I did, comparing ceph=
fs 0.32
>> >> > on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys se=
e a lot
>> >> > of this. Any feedback would be appreciated.
>> >> >
>> >> > The data is here:
>> >> >
>> >> > http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-is=
csi-benchmarks.ods
>> >> >
>> >> > and the writeup is here:
>> >> >
>> >> > http://learnitwithme.com/?p=3D303
>> >>
>> >> We see less of it than you'd think, actually. Thanks!
>> >>
>> >> To address a few things specifically
>> >> Ceph is both the name of the project and of the POSIX-compliant
>> >> filesystem. RADOS stands for Reliable Autonomous Distributed Obje=
ct
>> >> Store. Apparently we should publish this a bit more. :)
>> >>
>> >> Looks like most of the differences in your tests have to do with =
our
>> >> relatively lousy read performance -- this is probably due to lous=
y
>> >> readahead, which nobody's spent a lot of time optimizing as we fo=
cus
>> >> on stability. Sage made some improvements a few weeks ago but I d=
on't
>> >> remember what version of stuff they ended up in. :) (Optimizing
>> >> cross-server reads is hard!)
>> >
>> > The readahead improvements are in the 'master' branch of ceph-clie=
nt.git,
>> > and will go upstream for Linux 3.2-rc1 (I just missed the 3.1-rc1 =
cutoff).
>> > In my tests I was limited by the wire speed with these patches. =A0=
I'm
>> > guessing you were using 3.0 or earlier kernel?
>> >
>> > The file copy test was also surprising. =A0I think there is a regr=
ession
>> > there somewhere, taking a look.
>> >
>> > sage
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
