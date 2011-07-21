From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: Consistency vs efficiency
Date: Thu, 21 Jul 2011 11:19:58 -0700
Message-ID: <CAJD3hpWyhdVov32LHLGxUW8MfUeXtDr0KNX15BD4jnqfrzLQdg@mail.gmail.com>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
	<Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
	<CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
	<Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44948 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1GUST6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 14:19:58 -0400
Received: by gyh3 with SMTP id 3so787859gyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 11:19:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I did some basic debugging and thats another thing I wanted to add to
the ceph kernel. I started off with a print_message and am working on
it now.  At some point I want to be able to use this method at various
places for debugging outgoing and incoming messages.
 But yes going back to your question - i do see repeated lookups. I
need to look more carefully though if each of the lookups differ in
any manner. Also interesting is that after the first lookup (followed
by a mkdir), couple of next lookups still fail.

thanks again
Jojy

On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> Thanks for the response Sage. We are using 2.6.39 kernel and in the
>> "ceph_lookup" method, i see that there is a shortcut for deciding
>> ENOENT but after the MDS lookup, i dont see a d_add. I am sure i am
>> missing something here.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dout(" dir %p complete, -ENOENT\n", dir);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0d_add(dentry, NULL);
>
> ...but that is only for the negative lookup in a directory with the
> 'complete' flag set. =C2=A0And it's never set currently because we do=
n't have
> d_prune yet (and the old use of d_release was racy). =C2=A0So ignore =
this part
> for now!
>
> You have an existing, unchanging, directory that you're seeing repeat=
ed
> lookups on, right? =C2=A0Like the top-level directory in the heirarch=
y you're
> copying? =C2=A0And the client is doing repeated lookups on the same n=
ame?
>
> The way to debug this is probably to start with the messages passing =
to
> the MDS and verifying that lookups are duplicated. =C2=A0Then enable =
the
> logging on the kernel client and see why the client isn't uses leases=
 or
> the FILE_SHARED cap to avoid them. =C2=A0We can help you through that=
 on #ceph
> if you like.
>
> sage
>
>
>>
>> thanks again
>> Jojy
>>
>> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net> wrote=
:
>> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> Hi
>> >> =C2=A0 I just started looking at the ceph code in kernel and had =
a question
>> >> about performance considerations for lookup operations. I noticed=
 that
>> >> for every operation (say copying a directory), the root dentry is
>> >> "looked" up multiple times and since they all go to MDS for the a=
ctual
>> >> lookup operation, it effects the performance. I am sure consisten=
cy is
>> >> the winner here. Is there any plan to improve this, maybe by havi=
ng
>> >> MDS push the capability down to the clients when the dentry is
>> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
>> >> modified. This was the client node can cache the lookup operation=
 and
>> >> does not have to make a round trip to the MDS.
>> >
>> > In general, the MDS has two ways of keeping a client's cached dent=
ry
>> > consistent:
>> >
>> > =C2=A0- it can issue the FILE_SHARED capability bit on the parent =
directory,
>> > which means the entire directory is static and the client can cach=
e
>> > dentry.
>> > =C2=A0- if it can't do that, it will issue a per-dentry lease
>> >
>> > There is an additional 'complete' bit that is used to indicate on =
the
>> > client that it has the _entire_ directory in cache. =C2=A0If set, =
it can do
>> > negative lookups and readdir without hitting the MDS. =C2=A0That's=
 currently
>> > broken, pending the addition of a d_prune dentry_operation (see
>> > linux-fsdevel email from July 8).
>> >
>> > Anyway, long story short, if you're seeing repeated lookups on a d=
entry
>> > that isn't changing, something is broken. =C2=A0Can you describe t=
he workload
>> > in more detail? =C2=A0Which versions of the client and mds are you=
 running?
>> >
>> > sage
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
