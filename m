From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 14:34:46 +0800
Message-ID: <CACJqLyZp=+c0BbHRW3JUdAXrT9nWPopE82GEAJUUFrPi5g1vnQ@mail.gmail.com>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F31740C2F@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36536 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbJMGer convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 02:34:47 -0400
Received: by vkgc187 with SMTP id c187so4506165vkg.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 23:34:46 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31740C2F@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Tue, Oct 13, 2015 at 12:18 PM, Somnath Roy <Somnath.Roy@sandisk.com>=
 wrote:
> Mark,
>
> Thanks for this data. This means probably simple messenger (not OSD c=
ore) is
> not doing optimal job of handling memory.
>
>
>
> Haomai,
>
> I am not that familiar with Async messenger code base, do you have an
> explanation of the behavior (like good performance with default tcmal=
loc)
> Mark reported ? Is it using lot less thread overall than Simple ?

Originally async messenger mainly want to solve with high thread
number problem which limited the ceph cluster size. High context
switch and cpu usage caused by simple messenger under large cluster.

Recently we have memory problem discussed on ML and I also spend times
to think about the root cause. Currently I would like to consider the
simple messenger's memory usage is deviating from the design of
tcmalloc. Tcmalloc is aimed to provide memory with local cache, and it
also has memory control among all threads, if we have too much
threads, it may let tcmalloc busy with memory lock contention.

Async messenger uses thread pool to serve connections, it make all
blocking calls in simple messenger async.

>
> Also, it seems Async messenger has some inefficiencies in the io path=
 and
> that=E2=80=99s why it is not performing as well as simple if the memo=
ry allocation
> stuff is optimally handled.

Yep, simple messenger use two threads(one for read, one for write) to
serve one connection, async messenger at most have one thread to serve
one connection and multi connection  will share the same thread.

Next, I would like to have several plans to improve performance:
1. add poll mode support, I hope it can help enhance high performance
storage need
2. add load balance ability among worker threads
3. move more works out of messenger thread.

>
> Could you please send out any documentation around Async messenger ? =
I tried
> to google it , but, not even blueprint is popping up.

>
>
>
>
>
> Thanks & Regards
>
> Somnath
>
> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf=
 Of
> Haomai Wang
> Sent: Monday, October 12, 2015 7:57 PM
> To: Mark Nelson
> Cc: ceph-devel; ceph-users@lists.ceph.com
> Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger=
 vs
> AsyncMessenger results
>
>
>
> COOL
>
>
>
> Interesting that async messenger will consume more memory than simple=
, in my
> mind I always think async should use less memory. I will give a look =
at this
>
>
>
> On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson@redhat.com> wr=
ote:
>
> Hi Guy,
>
> Given all of the recent data on how different memory allocator
> configurations improve SimpleMessenger performance (and the effect of=
 memory
> allocators and transparent hugepages on RSS memory usage), I thought =
I'd run
> some tests looking how AsyncMessenger does in comparison.  We spoke a=
bout
> these a bit at the last performance meeting but here's the full write=
 up.
> The rough conclusion as of right now appears to be:
>
> 1) AsyncMessenger performance is not dependent on the memory allocato=
r like
> with SimpleMessenger.
>
> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB=
 (ie
> default) thread cache.
>
> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128=
K
> random reads.
>
> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memor=
y
> allocator optimizations are used.
>
> 5) AsyncMessenger currently uses far more RSS memory than SimpleMesse=
nger.
>
> Here's a link to the paper:
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
>
> Mark
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
>
> --
>
> Best Regards,
>
> Wheat
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is
> intended only for the use of the designated recipient(s) named above.=
 If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any re=
view,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please =
notify
> the sender by telephone or e-mail (as shown above) immediately and de=
stroy
> any and all copies of this message in your possession (whether hard c=
opies
> or electronically stored copies).
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
