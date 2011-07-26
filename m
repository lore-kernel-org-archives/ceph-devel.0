From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: Consistency vs efficiency
Date: Tue, 26 Jul 2011 11:34:35 -0700
Message-ID: <CAJD3hpU6_PMT1kobijdEg6UdT+PtyBq=i1bCHwZsPYk1_UnzEQ@mail.gmail.com>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
	<Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
	<CAJD3hpUw_AW-w3pK-GUSHY92U9=SvL5xdtMqC4rUUK+fnnO6mw@mail.gmail.com>
	<Pine.LNX.4.64.1107211047280.5868@cobra.newdream.net>
	<CAJD3hpW3JLB+VH3Kg5JouSoDG0-fpXO-g=kMBJPx_1bWDgauNQ@mail.gmail.com>
	<Pine.LNX.4.64.1107222049100.30052@cobra.newdream.net>
	<CAJD3hpW6o9snd1UiLBLEewAxmKz3xi2Rer4E7X6m6wbwPV=byA@mail.gmail.com>
	<Pine.LNX.4.64.1107231455180.15589@cobra.newdream.net>
	<CAJD3hpWrEdjjM2ua2jOy7DSbyOnVhNAM1uZz+7N2sbDsMxZavg@mail.gmail.com>
	<Pine.LNX.4.64.1107252109130.25672@cobra.newdream.net>
	<CAJD3hpX_9=1CQ0Lbgsbq9HQR_8p1FYeJ7KQfAGsi849yGr-2vg@mail.gmail.com>
	<Pine.LNX.4.64.1107261055280.2373@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41958 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1GZSeg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 14:34:36 -0400
Received: by gwaa18 with SMTP id a18so469691gwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 11:34:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107261055280.2373@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage,
Will get back to you with the logs.

Had another question about the implementation:


Here is the piece of code that I am a bit confused about:

In "fs/ceph/inode.c" ( function "ceph_fill_trace")

			/* do we have a lease on the whole dir? */
		have_dir_cap =3D
			(le32_to_cpu(rinfo->diri.in->cap.caps) &
			 CEPH_CAP_FILE_SHARED);

		/* do we have a dn lease? */
		have_lease =3D have_dir_cap ||
			(le16_to_cpu(rinfo->dlease->mask) &
			 CEPH_LOCK_DN);




So we check the capability "CEPH_CAP_FILE_SHARED" to make sure the
entire directory has the lease.  "have_lease" is then used to
determine if the dentry can be cached.

I would have thought that it should be "CEPH_CAP_FILE_EXCL" that
should be used to determine if a dentry can be cached since it would
mean that the client created the file and has "update" capabilities.

thanks
-Jojy








On Tue, Jul 26, 2011 at 10:56 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 26 Jul 2011, Jojy Varghese wrote:
>> Sage
>> =C2=A0I tried the simple use case of mkdir on the ceph mounted dir b=
ut
>> still see the issue. So i am wondering if our setup has anything to =
do
>> with it (although ideally it should not). Anything i should be looki=
ng
>> at given this behavior?'
>
> Can you capture the mds and kernel logs for the simple case?
>
> debug mds =3D 20
> debug ms =3D 1
>
> and for the kernel side run ceph.git's src/scripts/kcon_most.sh (or
> similar)
>
> Thanks!
> sage
>
>>
>>
>>
>> thx
>> Jojy
>>
>> On Mon, Jul 25, 2011 at 9:12 PM, Sage Weil <sage@newdream.net> wrote=
:
>> > On Mon, 25 Jul 2011, Jojy Varghese wrote:
>> >> What i observe is that after a mkdir, the inode CAPS loses the
>> >> lease(FILE_SHARED). I would have thought that the owing client sh=
ould
>> >> have a FILE_EXCL on the files/dirs it creates.
>> >>
>> >> Since it doesnt have a lease, the dentry(after splicing) is not c=
ached.
>> >
>> > Can you describe the specific sequence of operations you're doing?=
 =C2=A0I'm
>> > not seeing this behavior. =C2=A0I see
>> >
>> > $ mkdir foo
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds lookup #1/foo
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds mkdir #1/foo
>> > $ mkdir foo/a
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds lookup #100000000/a
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds mkdir #100000000/a
>> >
>> > with no repeated lookup on foo.
>> >
>> > sage
>> >
>> >
>> >>
>> >> thanks
>> >> Jojy
>> >>
>> >> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.net> wr=
ote:
>> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> >> >> Not sure how it is designed to work but I assume that some kin=
d of
>> >> >> async RPC mechanism exists from the MDCs to the clients to upd=
ate the
>> >> >> CAP for a file from "exclusive" to "shared". This will allow t=
he
>> >> >> cached dentries to be pruned/dropped when another client updat=
es the
>> >> >> file.
>> >> >
>> >> > Right. =C2=A0If the MDS needs to modify a dentry, it revoke any=
 issued client
>> >> > leases before granting the write/exclusive lock to process the =
request.
>> >> >
>> >> > sage
>> >> >
>> >> >>
>> >> >> -Jojy
>> >> >>
>> >> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdream.net>=
 wrote:
>> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> >> >> >> Sage would the latest patches fix the lookup issue?
>> >> >> >
>> >> >> > No, the blocker there is the '[PATCH] vfs: add d_prune dentr=
y operation'
>> >> >> > email on Jul 8 to linux-fsdevel and lkml. =C2=A0Once this se=
t goes in (and
>> >> >> > cleans up a bunch of stuff Al found in a code audit last wee=
kend) I'll be
>> >> >> > bugging him about it again.
>> >> >> >
>> >> >> > sage
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@newdream.=
net> wrote:
>> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> Thanks for the response Sage. We are using 2.6.39 kernel=
 and in the
>> >> >> >> >> "ceph_lookup" method, i see that there is a shortcut for=
 deciding
>> >> >> >> >> ENOENT but after the MDS lookup, i dont see a d_add. I a=
m sure i am
>> >> >> >> >> missing something here.
>> >> >> >> >
>> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dout(" dir %p complete, -ENOENT\n", dir);
>> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0d_add(dentry, NULL);
>> >> >> >> >
>> >> >> >> > ...but that is only for the negative lookup in a director=
y with the
>> >> >> >> > 'complete' flag set. =C2=A0And it's never set currently b=
ecause we don't have
>> >> >> >> > d_prune yet (and the old use of d_release was racy). =C2=A0=
So ignore this part
>> >> >> >> > for now!
>> >> >> >> >
>> >> >> >> > You have an existing, unchanging, directory that you're s=
eeing repeated
>> >> >> >> > lookups on, right? =C2=A0Like the top-level directory in =
the heirarchy you're
>> >> >> >> > copying? =C2=A0And the client is doing repeated lookups o=
n the same name?
>> >> >> >> >
>> >> >> >> > The way to debug this is probably to start with the messa=
ges passing to
>> >> >> >> > the MDS and verifying that lookups are duplicated. =C2=A0=
Then enable the
>> >> >> >> > logging on the kernel client and see why the client isn't=
 uses leases or
>> >> >> >> > the FILE_SHARED cap to avoid them. =C2=A0We can help you =
through that on #ceph
>> >> >> >> > if you like.
>> >> >> >> >
>> >> >> >> > sage
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> thanks again
>> >> >> >> >> Jojy
>> >> >> >> >>
>> >> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@newdrea=
m.net> wrote:
>> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> >> Hi
>> >> >> >> >> >> =C2=A0 I just started looking at the ceph code in ker=
nel and had a question
>> >> >> >> >> >> about performance considerations for lookup operation=
s. I noticed that
>> >> >> >> >> >> for every operation (say copying a directory), the ro=
ot dentry is
>> >> >> >> >> >> "looked" up multiple times and since they all go to M=
DS for the actual
>> >> >> >> >> >> lookup operation, it effects the performance. I am su=
re consistency is
>> >> >> >> >> >> the winner here. Is there any plan to improve this, m=
aybe by having
>> >> >> >> >> >> MDS push the capability down to the clients when the =
dentry is
>> >> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED when the =
dentry is
>> >> >> >> >> >> modified. This was the client node can cache the look=
up operation and
>> >> >> >> >> >> does not have to make a round trip to the MDS.
>> >> >> >> >> >
>> >> >> >> >> > In general, the MDS has two ways of keeping a client's=
 cached dentry
>> >> >> >> >> > consistent:
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0- it can issue the FILE_SHARED capability bit on=
 the parent directory,
>> >> >> >> >> > which means the entire directory is static and the cli=
ent can cache
>> >> >> >> >> > dentry.
>> >> >> >> >> > =C2=A0- if it can't do that, it will issue a per-dentr=
y lease
>> >> >> >> >> >
>> >> >> >> >> > There is an additional 'complete' bit that is used to =
indicate on the
>> >> >> >> >> > client that it has the _entire_ directory in cache. =C2=
=A0If set, it can do
>> >> >> >> >> > negative lookups and readdir without hitting the MDS. =
=C2=A0That's currently
>> >> >> >> >> > broken, pending the addition of a d_prune dentry_opera=
tion (see
>> >> >> >> >> > linux-fsdevel email from July 8).
>> >> >> >> >> >
>> >> >> >> >> > Anyway, long story short, if you're seeing repeated lo=
okups on a dentry
>> >> >> >> >> > that isn't changing, something is broken. =C2=A0Can yo=
u describe the workload
>> >> >> >> >> > in more detail? =C2=A0Which versions of the client and=
 mds are you running?
>> >> >> >> >> >
>> >> >> >> >> > sage
>> >> >> >> >> >
>> >> >> >> >> >
>> >> >> >> >> --
>> >> >> >> >> To unsubscribe from this list: send the line "unsubscrib=
e ceph-devel" in
>> >> >> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> >> >> More majordomo info at =C2=A0http://vger.kernel.org/majo=
rdomo-info.html
>> >> >> >> >>
>> >> >> >> >>
>> >> >> >>
>> >> >> >>
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
