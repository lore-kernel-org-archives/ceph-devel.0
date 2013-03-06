From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 12:58:05 -0700
Message-ID: <51379FCD.9000502@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:50199 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3CFT7A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 14:59:00 -0500
In-Reply-To: <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On 03/06/2013 12:13 PM, Greg Farnum wrote:
> On Wednesday, March 6, 2013 at 11:07 AM, Jim Schutt wrote:
>> On 03/05/2013 12:33 PM, Sage Weil wrote:
>>>>> Running 'du' on each directory would be much faster with Ceph sin=
ce it
>>>>> accounts tracks the subdirectories and shows their total size wit=
h an 'ls
>>>>> -al'.
>>>>> =20
>>>>> Environments with 100k users also tend to be very dynamic with ad=
ding and
>>>>> removing users all the time, so creating separate filesystems for=
 them would
>>>>> be very time consuming.
>>>>> =20
>>>>> Now, I'm not talking about enforcing soft or hard quotas, I'm jus=
t talking
>>>>> about knowing how much space uid X and Y consume on the filesyste=
m.
>>>> =20
>>> =20
>>> =20
>>> The part I'm most unclear on is what use cases people have where ui=
d X and =20
>>> Y are spread around the file system (not in a single or small set o=
f sub =20
>>> directories) and per-user (not, say, per-project) quotas are still =
=20
>>> necessary. In most environments, users get their own home directory=
 and =20
>>> everything lives there...
>> =20
>> =20
>> =20
>> Hmmm, is there a tool I should be using that will return the space
>> used by a directory, and all its descendants?
>> =20
>> If it's 'du', that tool is definitely not fast for me.
>> =20
>> I'm doing an 'strace du -s <path>', where <path> has one
>> subdirectory which contains ~600 files. I've got ~200 clients
>> mounting the file system, and each client wrote 3 files in that
>> directory.
>> =20
>> I'm doing the 'du' from one of those nodes, and the strace is showin=
g
>> me du is doing a 'newfstat' for each file. For each file that was
>> written on a different client from where du is running, that 'newfst=
at'
>> takes tens of seconds to return. Which means my 'du' has been runnin=
g
>> for quite some time and hasn't finished yet....
>> =20
>> I'm hoping there's another tool I'm supposed to be using that I
>> don't know about yet. Our use case includes tens of millions
>> of files written from thousands of clients, and whatever tool
>> we use to do space accounting needs to not walk an entire directory
>> tree, checking each file.
>=20
> Check out the directory sizes with ls -l or whatever =E2=80=94 those =
numbers are semantically meaningful! :)

That is just exceptionally cool!

>=20
> Unfortunately we can't (currently) use those "recursive statistics"
> to do proper hard quotas on subdirectories as they're lazily
> propagated following client ops, not as part of the updates. (Lazily
> in the technical sense =E2=80=94 it's actually quite fast in general)=
=2E But
> they'd work fine for soft quotas if somebody wrote the code, or to
> block writes on a slight time lag.

'ls -lh <dir>' seems to be just the thing if you already know <dir>.

And it's perfectly suitable for our use case of not scheduling
new jobs for users consuming too much space.

I was thinking I might need to find a subtree where all the
subdirectories are owned by the same user, on the theory that
all the files in such a subtree would be owned by that same
user.  E.g., we might want such a capability to manage space per
user in shared project directories.

So, I tried 'find <dir> -type d -exec ls -lhd {} \;'

Unfortunately, that ended up doing a 'newfstatat' on each file
under <dir>, evidently to learn if it was a directory.  The
result was that same slowdown for files written on other clients.

Is there some other way I should be looking for directories if I
don't already know what they are?

Also, this issue of stat on files created on other clients seems
like it's going to be problematic for many interactions our users
will have with the files created by their parallel compute jobs -
any suggestion on how to avoid or fix it?

Thanks!

-- Jim

> -Greg
>=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
