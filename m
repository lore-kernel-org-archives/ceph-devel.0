From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: subdir quotas
Date: Wed, 2 Jun 2010 17:34:22 +0800
Message-ID: <AANLkTimi8lrwiblFXYJIiprfy3gCZOoGu5auL3umEqA2@mail.gmail.com>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
	<Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
	<l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
	<Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
	<m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
	<w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
	<Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0FBJeX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jun 2010 05:34:23 -0400
Received: by vws11 with SMTP id 11so2326519vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jun 2010 02:34:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Yes, I am interested and that's what I am doing right now.
In fact, we have a clone of ceph on github, and have had a "quick"
implementation already. You can get it from:

http://github.com/tcloud/ceph/tree/folder-quota
http://github.com/tcloud/ceph-client-standalone/tree/folder-quota

To allow switching quota on/off, we added the option/configuration on b=
oth
client and server sides. To enable folder quota, you need to mount ceph=
 with
"-o folder_quota=3D1" on client side. On server side, you need to add
"folder quota =3D 1" in the global section of ceph config file. We also
implemented a tool to set/unset/get/list quota limits on folders.

To enforce the quota more precisely, our imlementation, however, sacrif=
ies
the writing throughput and introduces more traffic:

1. We modified the max_size request-reply behaviour between client and =
mds.
   Our client requests a new max_size only when endoff > max_size. (i.e=
=2E, it
   will not pre-request a larger max-size when it's approached the max_=
size.)

2. Our client requests a constant 4 MB (the object size) every time. Th=
is
   degrades the throughput significantly. (It used to request more and =
more.)

Anyway, it is the initial implementation. I will take your comments int=
o
consideration and try to revise the current implementation. Of course, =
I will
need your help on rstat propagation issue 'cause I have no clue right n=
ow
and have to dig the mds source code more to understand the existing
implementation. :)

A few questions about ceph testing:
- When will a subtree be fragmented?
- Can I force a subtree to be framented to faciliate testing?
- How do I know which mds is authoritive for particular fragment?

Thanks,
Henry

On Wed, Jun 2, 2010 at 3:17 AM, Sage Weil <sage@newdream.net> wrote:
> Hi,
>
> The subject of quota enforcement came up in the IRC channel last week=
 so I
> thought I'd resurrect this discussion.
>
>> > On Fri, 30 Apr 2010, Henry C Chang wrote:
>> > > In fact, I am trying to add "folder quota support" to ceph right=
 now.
>> > > My rough idea is as below:
>> > >
>> > > (1) Store the quota limit in the xattr of the folder;
>> > > (2) When the client requests a new max size for writing content =
to a file,
>> > > MDS authorizes the request according to the quota and the rstat =
of the
>> > > folder.
>> >
>> > One thing to keep in mind is that because the recursive rsize info=
 is
>> > lazily propagated up the file tree, this won't work perfectly. =C2=
=A0If you set
>> > a limit of 1GB on /foo and are writing data in /foo/bar/baz, it wo=
n't stop
>> > you right at 1GB. =C2=A0Similarly, if you hit the limit, and delet=
e some stuff,
>> > it will take time before the MDS notices and lets you start writin=
g again.
>> >
>> Hmm... this would be a problem....
>> From the perspective of a user, I would be happy if I can write more
>> than my quota. However, I would get pissed off if I have deleted som=
e
>> stuff but still cannot write anything and don't know how long I have=
 to
>> wait.
>>
>> Is it possible to force MDS to propaget rsize info when files are de=
leted?
>> Or, can lazy propagation be bounded to a maximum interval (say 5 sec=
onds)?
>
> The propagation is bounded by a tunable timeout (30 seconds by defaul=
t,
> but adjustable). =C2=A0That's per ancestor.. so if you're three level=
s deep,
> the max is 3x that. =C2=A0In practice, it's typically less, though, a=
nd I think
> we could come up with something that would force propagation to happe=
n
> faster in these situations. =C2=A0The reason it's there is just to li=
mit the
> overhead of maintaining the recursive stats. =C2=A0We don't want to u=
pdate all
> ancestors every time we change something, and because we're distribut=
ed
> over multiple nodes we can't.
>
>> > What is your use case?
>>
>> I want to create "depots" inside ceph:
>> - Each depot has its own quota limit and can be resized as needed.
>> - Multiple users can read/write the same depot concurrently.
>>
>> My original plan is to create a first-level folder for each depot
>> (e.g., /mnt/ceph/depot1, /mnt/ceph/depot2, ...) and set quota on it.
>> Do you have any suggestion on implementing such a use case?
>
> There's no reason to restrict this to first-level folders (if that's =
what
> you were suggesting). =C2=A0We should allow a subdir quota to be set =
on any
> directory, probably iff you are the owner. =C2=A0We can make the user=
 interface
> based on xattrs, since that's generally nicer to interact with than a=
n
> ioctl based interface. =C2=A0That's not to say the quota should neces=
sarily be
> handled/stored internally as an xattr (although it could be). =C2=A0I=
t might
> make more sense to add a field to the inode and extend the client/mds
> protocol to manipulate it.
>
> Either way, I think a coarse implementation could be done pretty easi=
ly,
> where by 'coarse' I mean we don't necessarily stop writes exactly at =
the
> limit (they can write a bit more before they start getting ENOSPC).
>
> On IRC the subject of soft quotas also came up (where you're allowed =
over
> the soft limit for some grace period before writes start failing). =C2=
=A0That's
> also not terribly difficult to implement (we just need to store some
> timestamp field as well so we know when they initially cross the soft
> threashold).
>
> Are you still interested in working on this?
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
