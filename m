From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 14:57:30 -0700
Message-ID: <CAF3hT9DtAUCfJknGXO+tejPju6RY8mnAQkLotarQa66HMV0cwQ@mail.gmail.com>
References: <193464577.4390.1319657347846.JavaMail.root@mail-01.cse.ucsc.edu>
	<Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45955 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1JZV5b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 17:57:31 -0400
Received: by iaby12 with SMTP id y12so2179144iab.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 14:57:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Oct 26, 2011 at 2:34 PM, Sage Weil <sage@newdream.net> wrote:
> [adding ceph-devel CC]
>
> On Wed, 26 Oct 2011, Noah Watkins wrote:
>> ----- Original Message -----
>> > From: "Sage Weil" <sage@newdream.net>
>> >
>> > >
>> > > There was some packaging/cleanup work mentioned a while back on =
the
>> > > mailing list. Is anyone working on this?
>> >
>> > Nope.
>> >
>> > I'm not really sure what the "right' way to build/expose/package j=
ava
>> > bindings is.. but presumably it's less annoying than what we have =
now
>> > :)
>>
>> I'm revisiting this now to prepare packages and instructions for the
>> students running benchmarks this quarter, but I wanted to get your
>> input on future goals to not waste too much effort doing short-term
>> stuff. The possible approaches I see:
>>
>> 1) Everything (JNI wrappers + Java) lives in the Ceph tree and build
>> =A0 =A0instructions include applying a patch to Hadoop.
>>
>> =A0 =A0The current solution, and isn't too bad but needs documentati=
on. This
>> =A0 =A0approach can be simplified to avoid patching Hadoop by integr=
ating
>> =A0 =A0Ceph-specific Java code using the CLASSPATH global variable.
>>
>> 2) Everything is sent to Hadoop upstream.
>>
>> =A0 =A0This is convenient because the Hadoop infrastructure already =
has
>> =A0 =A0the facilities for building and linking native code into Hado=
op,
>> =A0 =A0and the only depenendency then becomes a standard ceph-devel
>> =A0 =A0installation.
>>
>> =A0 =A0This was the approach taken with the kernel client version wh=
ich
>> =A0 =A0also included JNI code (for ioctl).
>>
>> 3) Only JNI wrappers live in the Ceph tree and push Java patch upstr=
eam.
>>
>> =A0 =A0This could be better if it is anticipated that libceph will s=
ee a lot
>> =A0 =A0of churn in the future, and we'd avoid pushing more changes u=
pstream.
>
> #3 strikes me as the right approach, since there are potentially othe=
r
> Java users of libcephfs, and the Hadoop CephFileSystem class will be =
best
> maintained (and most usable) if it upstream. =A0There will just be th=
e
> initial pain of getting the packaging right for libcephfs so that it =
will
> work w/ hadoop out of the box. =A0(I'm assuming that is possible.. e.=
g.
> apt-get install ceph, fire up hadoop with the proper config?)
>
> sage
So I'd agree that #3 should be our eventual goal, but if we want
proper Java libceph/librados bindings (and to use these in Hadoop)
there's a lot of work that needs to be done before we try and push the
Java code upstream. The current library is *not* generic and contains
a lot of Hadoop-specific application logic that will need to be pushed
back out to Java.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
