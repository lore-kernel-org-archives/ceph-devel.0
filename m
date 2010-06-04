From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: subdir quotas
Date: Fri, 4 Jun 2010 11:19:24 +0800
Message-ID: <AANLkTinsL5X_DtHbfk-tLAMW_yu2bH-Q0or_mQt7X1gQ@mail.gmail.com>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
	<Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
	<l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
	<Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
	<m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
	<w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
	<Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
	<AANLkTimi8lrwiblFXYJIiprfy3gCZOoGu5auL3umEqA2@mail.gmail.com>
	<Pine.LNX.4.64.1006021223590.1269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab0FDD0E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 23:26:04 -0400
Received: by gye5 with SMTP id 5so621759gye.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jun 2010 20:26:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1006021223590.1269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On Thu, Jun 3, 2010 at 3:48 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 2 Jun 2010, Henry C Chang wrote:
>> Yes, I am interested and that's what I am doing right now.
>> In fact, we have a clone of ceph on github, and have had a "quick"
>> implementation already. You can get it from:
>>
>> http://github.com/tcloud/ceph/tree/folder-quota
>> http://github.com/tcloud/ceph-client-standalone/tree/folder-quota
>
> Oh, cool. =C2=A0I'll take a look at this today.
>
>> To allow switching quota on/off, we added the option/configuration o=
n both
>> client and server sides. To enable folder quota, you need to mount c=
eph with
>> "-o folder_quota=3D1" on client side. On server side, you need to ad=
d
>> "folder quota =3D 1" in the global section of ceph config file. We a=
lso
>> implemented a tool to set/unset/get/list quota limits on folders.
>>
>> To enforce the quota more precisely, our imlementation, however, sac=
rifies
>> the writing throughput and introduces more traffic:
>>
>> 1. We modified the max_size request-reply behaviour between client a=
nd mds.
>> =C2=A0 =C2=A0Our client requests a new max_size only when endoff > m=
ax_size. (i.e., it
>> =C2=A0 =C2=A0will not pre-request a larger max-size when it's approa=
ched the max_size.)
>>
>> 2. Our client requests a constant 4 MB (the object size) every time.=
 This
>> =C2=A0 =C2=A0degrades the throughput significantly. (It used to requ=
est more and more.)
>
> Is this just to reduce the amount by which we might overshoot? =C2=A0=
I would
> try to make it a tunable, maybe ('max size slop' or something) so tha=
t it

Great!

> preserves the current doubling logic but caps it at some value, so th=
e
> admin can trade throughput vs quota precision. =C2=A0And/or we can ma=
ke it also
> dynamic reduce that window as the user approaches the limit.

Yes. But if there are multiple clients writing one subtree concurrently=
, it is
a little bit difficult to say if we are approaching the limit.... we
need to know
how many clients are writing to the same subtree...

>
>> Anyway, it is the initial implementation. I will take your comments =
into
>> consideration and try to revise the current implementation. Of cours=
e, I will
>> need your help on rstat propagation issue 'cause I have no clue righ=
t now
>> and have to dig the mds source code more to understand the existing
>> implementation. :)
>
> Sure.
>
>> A few questions about ceph testing:
>> - When will a subtree be fragmented?
>> - Can I force a subtree to be framented to faciliate testing?
>
> By default the load balancer goes every 30 seconds. =C2=A0You can tur=
n on mds
> 'thrashing' that will export random directories to random nodes (to s=
tress
> test the migration), but that is probably overkill.
>
> It would probably be best to add something to MDS.cc's handle_command=
 that
> lets the admin explicit initiate a subtree migration, via something l=
ike
>
> =C2=A0$ ceph mds tell 0 export_dir /foo/bar 2 =C2=A0 =C2=A0# send /fo=
o/bar from mds0 to 2
>
> I just pushed something to do that to unstable.. let me know if you r=
un
> into problems with it.
>

The export_dir command working well, and gives us a convenient way to t=
est
multi-mds scenarios. Not surprisingly, our current implementation is no=
t
working in mult-mds environment... :)

My test setup:
Under mount point, I created /volume, /volume/aaa, /volume/bbb.
    mds0 is authoritative for /volume, /volume/aaa.
    mds1 is authoritative for /volume/bbb.
Quota is set on /volume: 250M

Test case 0: pass
cp 100M file to /volume/aaa/a0
cp 100M file to /volume/aaa/a1
cp 100M file to /volume/aaa/a2  =3D=3D> quota exceeded error is expecte=
d here

Test case 1: pass
cp 100M file to /volume/bbb/b0
cp 100M file to /volume/bbb/b1
cp 100M file to /volume/aaa/a1  =3D=3D> quota exceeded error is expecte=
d here

Test case 2: failed
cp 100M file to /volume/bbb/b0
cp 100M file to /volume/bbb/b1
cp 100M file to /volume/bbb/b2  =3D=3D> quota exceeded error is expecte=
d here

It seems that rstat can be propagated up (from mds1 to mds0) quickly (c=
ase 1);
however, the ancestor replica (/volume) in mds1 is not updated (case 2)=
=2E
I wonder how/when the replicas get updated. I'm still digging the sourc=
e code
to find where. :(

Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
