From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: Consistency vs efficiency
Date: Wed, 3 Aug 2011 16:40:58 -0700
Message-ID: <CAJD3hpX14eMC6rWu=FpXJLvoriG3C24KpbHDdJ7Emg8eq7-97Q@mail.gmail.com>
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
	<CAJD3hpV0dLivWAhY_p7DeWS8xFTaziK6mnSBCaoGo_dJvi8SAA@mail.gmail.com>
	<Pine.LNX.4.64.1108012026570.21689@cobra.newdream.net>
	<CAJD3hpXmM0i0zNVoWo3xS-v2rTgu3sD63Red8dMX=FzP_JZP7w@mail.gmail.com>
	<Pine.LNX.4.64.1108030941380.20062@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44802 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab1HCXk7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 19:40:59 -0400
Received: by yxj19 with SMTP id 19so530139yxj.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2011 16:40:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108030941380.20062@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Yes confirmed that the problem goes away with the latest version.

Thanks
Jojy

On Wed, Aug 3, 2011 at 9:45 AM, Sage Weil <sage@newdream.net> wrote:
> It looks like you're running pretty old version of the client AND ser=
ver.
> I'm 90% sure this was fixed by 5dc09dd6b81c622960f628acdabda9eac8af1c=
eb on
> the server and/or 2f90b852e3ae73889d7f6de6ecf429b9b6a6b103 on the ker=
nel
> side will fix this. =C2=A0Running a new versin of either one should f=
ix this,
> but I'd recommend running a current version of both!
>
> sage
>
>
> On Tue, 2 Aug 2011, Jojy Varghese wrote:
>
>> Updated the bug.
>>
>> On Mon, Aug 1, 2011 at 8:31 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 26 Jul 2011, Jojy Varghese wrote:
>> >> Sage
>> >> =C2=A0 =C2=A0Attached is the dmesg outputs after an scp of three =
level
>> >> directory. Here is how the directory tree looks like:
>> >>
>> >>
>> >> testscpdirB/
>> >> =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF level1
>> >> =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF l1f1
>> >> =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF l1f2
>> >> =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF l1f3
>> >> =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF level2
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF =
l2f1
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF =
l2f2
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF =
l2f3
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF =
l2f4
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=C3=BF=C3=BF =
level3
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C3=BF=C3=BF=C3=BF=C3=BF=
=C3=BF=C3=BF l3f1
>> >>
>> >> "scp_c_kernel.log" has one more level of detail in the log
>> >> (ceph_fill_trace) and I changed the top level directory name. You=
 will
>> >> observe that the top level directory has "have_lease" false.
>> >>
>> >> As you will see in the log, the top level dentry is looked up mul=
tiple times.
>> >
>> > Hmm, yep, that is strange! =C2=A0 Looks like a bug, although it ma=
y be one we
>> > already fixed in the last kernel. =C2=A0Can you confirm which vers=
ion of the
>> > kernel client and server side you are running?
>> >
>> > Also, can you do it one more time with everything in inode.c and c=
aps.c
>> > enabled (or just the scripts/kcon_most.sh from ceph.git), and also=
 the mds
>> > log (debug mds =3D 20, debug ms =3D 1)? =C2=A0That will have every=
thing I need.
>> >
>> > Opened ticket #1350 to track this.
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> >>
>> >>
>> >> thx,
>> >> Jojy
>> >>
>> >>
>> >>
>> >> On Tue, Jul 26, 2011 at 10:56 AM, Sage Weil <sage@newdream.net> w=
rote:
>> >> > On Tue, 26 Jul 2011, Jojy Varghese wrote:
>> >> >> Sage
>> >> >> =C2=A0I tried the simple use case of mkdir on the ceph mounted=
 dir but
>> >> >> still see the issue. So i am wondering if our setup has anythi=
ng to do
>> >> >> with it (although ideally it should not). Anything i should be=
 looking
>> >> >> at given this behavior?'
>> >> >
>> >> > Can you capture the mds and kernel logs for the simple case?
>> >> >
>> >> > debug mds =3D 20
>> >> > debug ms =3D 1
>> >> >
>> >> > and for the kernel side run ceph.git's src/scripts/kcon_most.sh=
 (or
>> >> > similar)
>> >> >
>> >> > Thanks!
>> >> > sage
>> >> >
>> >> >>
>> >> >>
>> >> >>
>> >> >> thx
>> >> >> Jojy
>> >> >>
>> >> >> On Mon, Jul 25, 2011 at 9:12 PM, Sage Weil <sage@newdream.net>=
 wrote:
>> >> >> > On Mon, 25 Jul 2011, Jojy Varghese wrote:
>> >> >> >> What i observe is that after a mkdir, the inode CAPS loses =
the
>> >> >> >> lease(FILE_SHARED). I would have thought that the owing cli=
ent should
>> >> >> >> have a FILE_EXCL on the files/dirs it creates.
>> >> >> >>
>> >> >> >> Since it doesnt have a lease, the dentry(after splicing) is=
 not cached.
>> >> >> >
>> >> >> > Can you describe the specific sequence of operations you're =
doing? =C2=A0I'm
>> >> >> > not seeing this behavior. =C2=A0I see
>> >> >> >
>> >> >> > $ mkdir foo
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds lookup #1/foo
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds mkdir #1/foo
>> >> >> > $ mkdir foo/a
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds lookup #100000000/a
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0client->mds mkdir #100000000/a
>> >> >> >
>> >> >> > with no repeated lookup on foo.
>> >> >> >
>> >> >> > sage
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> thanks
>> >> >> >> Jojy
>> >> >> >>
>> >> >> >> On Sat, Jul 23, 2011 at 2:56 PM, Sage Weil <sage@newdream.n=
et> wrote:
>> >> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> Not sure how it is designed to work but I assume that so=
me kind of
>> >> >> >> >> async RPC mechanism exists from the MDCs to the clients =
to update the
>> >> >> >> >> CAP for a file from "exclusive" to "shared". This will a=
llow the
>> >> >> >> >> cached dentries to be pruned/dropped when another client=
 updates the
>> >> >> >> >> file.
>> >> >> >> >
>> >> >> >> > Right. =C2=A0If the MDS needs to modify a dentry, it revo=
ke any issued client
>> >> >> >> > leases before granting the write/exclusive lock to proces=
s the request.
>> >> >> >> >
>> >> >> >> > sage
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> -Jojy
>> >> >> >> >>
>> >> >> >> >> On Fri, Jul 22, 2011 at 8:51 PM, Sage Weil <sage@newdrea=
m.net> wrote:
>> >> >> >> >> > On Fri, 22 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> >> Sage would the latest patches fix the lookup issue?
>> >> >> >> >> >
>> >> >> >> >> > No, the blocker there is the '[PATCH] vfs: add d_prune=
 dentry operation'
>> >> >> >> >> > email on Jul 8 to linux-fsdevel and lkml. =C2=A0Once t=
his set goes in (and
>> >> >> >> >> > cleans up a bunch of stuff Al found in a code audit la=
st weekend) I'll be
>> >> >> >> >> > bugging him about it again.
>> >> >> >> >> >
>> >> >> >> >> > sage
>> >> >> >> >> >
>> >> >> >> >> >
>> >> >> >> >> >
>> >> >> >> >> >>
>> >> >> >> >> >> On Thu, Jul 21, 2011 at 10:55 AM, Sage Weil <sage@new=
dream.net> wrote:
>> >> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> >> >> Thanks for the response Sage. We are using 2.6.39 =
kernel and in the
>> >> >> >> >> >> >> "ceph_lookup" method, i see that there is a shortc=
ut for deciding
>> >> >> >> >> >> >> ENOENT but after the MDS lookup, i dont see a d_ad=
d. I am sure i am
>> >> >> >> >> >> >> missing something here.
>> >> >> >> >> >> >
>> >> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dout(" dir %p complete, -ENOENT\n", dir)=
;
>> >> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d_add(dentry, NULL);
>> >> >> >> >> >> >
>> >> >> >> >> >> > ...but that is only for the negative lookup in a di=
rectory with the
>> >> >> >> >> >> > 'complete' flag set. =C2=A0And it's never set curre=
ntly because we don't have
>> >> >> >> >> >> > d_prune yet (and the old use of d_release was racy)=
=2E =C2=A0So ignore this part
>> >> >> >> >> >> > for now!
>> >> >> >> >> >> >
>> >> >> >> >> >> > You have an existing, unchanging, directory that yo=
u're seeing repeated
>> >> >> >> >> >> > lookups on, right? =C2=A0Like the top-level directo=
ry in the heirarchy you're
>> >> >> >> >> >> > copying? =C2=A0And the client is doing repeated loo=
kups on the same name?
>> >> >> >> >> >> >
>> >> >> >> >> >> > The way to debug this is probably to start with the=
 messages passing to
>> >> >> >> >> >> > the MDS and verifying that lookups are duplicated. =
=C2=A0Then enable the
>> >> >> >> >> >> > logging on the kernel client and see why the client=
 isn't uses leases or
>> >> >> >> >> >> > the FILE_SHARED cap to avoid them. =C2=A0We can hel=
p you through that on #ceph
>> >> >> >> >> >> > if you like.
>> >> >> >> >> >> >
>> >> >> >> >> >> > sage
>> >> >> >> >> >> >
>> >> >> >> >> >> >
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> thanks again
>> >> >> >> >> >> >> Jojy
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> On Thu, Jul 21, 2011 at 9:49 AM, Sage Weil <sage@n=
ewdream.net> wrote:
>> >> >> >> >> >> >> > On Thu, 21 Jul 2011, Jojy Varghese wrote:
>> >> >> >> >> >> >> >> Hi
>> >> >> >> >> >> >> >> =C2=A0 I just started looking at the ceph code =
in kernel and had a question
>> >> >> >> >> >> >> >> about performance considerations for lookup ope=
rations. I noticed that
>> >> >> >> >> >> >> >> for every operation (say copying a directory), =
the root dentry is
>> >> >> >> >> >> >> >> "looked" up multiple times and since they all g=
o to MDS for the actual
>> >> >> >> >> >> >> >> lookup operation, it effects the performance. I=
 am sure consistency is
>> >> >> >> >> >> >> >> the winner here. Is there any plan to improve t=
his, maybe by having
>> >> >> >> >> >> >> >> MDS push the capability down to the clients whe=
n the dentry is
>> >> >> >> >> >> >> >> updated. So say from CAP_EXCL to CAP_SHARED whe=
n the dentry is
>> >> >> >> >> >> >> >> modified. This was the client node can cache th=
e lookup operation and
>> >> >> >> >> >> >> >> does not have to make a round trip to the MDS.
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> > In general, the MDS has two ways of keeping a cl=
ient's cached dentry
>> >> >> >> >> >> >> > consistent:
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> > =C2=A0- it can issue the FILE_SHARED capability =
bit on the parent directory,
>> >> >> >> >> >> >> > which means the entire directory is static and t=
he client can cache
>> >> >> >> >> >> >> > dentry.
>> >> >> >> >> >> >> > =C2=A0- if it can't do that, it will issue a per=
-dentry lease
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> > There is an additional 'complete' bit that is us=
ed to indicate on the
>> >> >> >> >> >> >> > client that it has the _entire_ directory in cac=
he. =C2=A0If set, it can do
>> >> >> >> >> >> >> > negative lookups and readdir without hitting the=
 MDS. =C2=A0That's currently
>> >> >> >> >> >> >> > broken, pending the addition of a d_prune dentry=
_operation (see
>> >> >> >> >> >> >> > linux-fsdevel email from July 8).
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> > Anyway, long story short, if you're seeing repea=
ted lookups on a dentry
>> >> >> >> >> >> >> > that isn't changing, something is broken. =C2=A0=
Can you describe the workload
>> >> >> >> >> >> >> > in more detail? =C2=A0Which versions of the clie=
nt and mds are you running?
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> > sage
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> >
>> >> >> >> >> >> >> --
>> >> >> >> >> >> >> To unsubscribe from this list: send the line "unsu=
bscribe ceph-devel" in
>> >> >> >> >> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> >> >> >> >> More majordomo info at =C2=A0http://vger.kernel.or=
g/majordomo-info.html
>> >> >> >> >> >> >>
>> >> >> >> >> >> >>
>> >> >> >> >> >>
>> >> >> >> >> >>
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
