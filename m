From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: Consistency vs efficiency
Date: Mon, 25 Jul 2011 17:37:01 -0700
Message-ID: <CAJD3hpWrEdjjM2ua2jOy7DSbyOnVhNAM1uZz+7N2sbDsMxZavg@mail.gmail.com>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
	<Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
	<CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
	<Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
	<CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
	<Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
	<CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
	<Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47508 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab1GZAhD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2011 20:37:03 -0400
Received: by gyh3 with SMTP id 3so2577457gyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2011 17:37:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

What i observe is that after a mkdir, the inode CAPS loses the
lease(FILE_SHARED). I would have thought that the owing client should
have a FILE_EXCL on the files/dirs it creates.

Since it doesnt have a lease, the dentry(after splicing) is not cached.

thanks
Jojy

On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> Not sure how it is designed to work but I assume that some kind of
>> async RPC mechanism exists from the MDCs to the clients to update th=
e
>> CAP for a file from "exclusive" to "shared". This will allow the
>> cached dentries to be pruned/dropped when another client updates the
>> file.
>
> Right. =C2=A0If the MDS needs to modify a dentry, it revoke any issue=
d client
> leases before granting the write/exclusive lock to process the reques=
t.
>
> sage
>
>>
>> -Jojy
>>
>> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net> wrote=
:
>> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> >> Sage would the latest patches fix the lookup issue?
>> >
>> > No, the blocker there is the '[PATCH] vfs: add d_prune dentry oper=
ation'
>> > email on Jul 8 to linux-fsdevel and lkml. =C2=A0Once this set goes=
 in (and
>> > cleans up a bunch of stuff Al found in a code audit last weekend) =
I'll be
>> > bugging him about it again.
>> >
>> > sage
>> >
>> >
>> >
>> >>
>> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.net> w=
rote:
>> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> Thanks for the response Sage. We are using 2.6.39 kernel and i=
n the
>> >> >> "ceph_lookup" method, i see that there is a shortcut for decid=
ing
>> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I am sure=
 i am
>> >> >> missing something here.
>> >> >
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dout(" dir %p complete, -ENOENT\n", dir);
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0d_add(dentry, NULL);
>> >> >
>> >> > ...but that is only for the negative lookup in a directory with=
 the
>> >> > 'complete' flag set. =C2=A0And it's never set currently because=
 we don't have
>> >> > d_prune yet (and the old use of d_release was racy). =C2=A0So i=
gnore this part
>> >> > for now!
>> >> >
>> >> > You have an existing, unchanging, directory that you're seeing =
repeated
>> >> > lookups on, right? =C2=A0Like the top-level directory in the he=
irarchy you're
>> >> > copying? =C2=A0And the client is doing repeated lookups on the =
same name?
>> >> >
>> >> > The way to debug this is probably to start with the messages pa=
ssing to
>> >> > the MDS and verifying that lookups are duplicated. =C2=A0Then e=
nable the
>> >> > logging on the kernel client and see why the client isn't uses =
leases or
>> >> > the FILE_SHARED cap to avoid them. =C2=A0We can help you throug=
h that on #ceph
>> >> > if you like.
>> >> >
>> >> > sage
>> >> >
>> >> >
>> >> >>
>> >> >> thanks again
>> >> >> Jojy
>> >> >>
>> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdream.net>=
 wrote:
>> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> >> Hi
>> >> >> >> =C2=A0 I just started looking at the ceph code in kernel an=
d had a question
>> >> >> >> about performance considerations for lookup operations. I n=
oticed that
>> >> >> >> for every operation (say copying a directory), the root den=
try is
>> >> >> >> "looked" up multiple times and since they all go to MDS for=
 the actual
>> >> >> >> lookup operation, it effects the performance. I am sure con=
sistency is
>> >> >> >> the winner here. Is there any plan to improve this, maybe b=
y having
>> >> >> >> MDS push the capability down to the clients when the dentry=
 is
>> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the dentry=
 is
>> >> >> >> modified. This was the client node can cache the lookup ope=
ration and
>> >> >> >> does not have to make a round trip to the MDS.
>> >> >> >
>> >> >> > In general, the MDS has two ways of keeping a client's cache=
d dentry
>> >> >> > consistent:
>> >> >> >
>> >> >> > =C2=A0- it can issue the FILE_SHARED capability bit on the p=
arent directory,
>> >> >> > which means the entire directory is static and the client ca=
n cache
>> >> >> > dentry.
>> >> >> > =C2=A0- if it can't do that, it will issue a per-dentry leas=
e
>> >> >> >
>> >> >> > There is an additional 'complete' bit that is used to indica=
te on the
>> >> >> > client that it has the _entire_ directory in cache. =C2=A0If=
 set, it can do
>> >> >> > negative lookups and readdir without hitting the MDS. =C2=A0=
That's currently
>> >> >> > broken, pending the addition of a d_prune dentry_operation (=
see
>> >> >> > linux-fsdevel email from July 8).
>> >> >> >
>> >> >> > Anyway, long story short, if you're seeing repeated lookups =
on a dentry
>> >> >> > that isn't changing, something is broken. =C2=A0Can you desc=
ribe the workload
>> >> >> > in more detail? =C2=A0Which versions of the client and mds a=
re you running?
>> >> >> >
>> >> >> > sage
>> >> >> >
>> >> >> >
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-=
info.html
>> >> >>
>> >> >>
>> >>
>> >>
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
