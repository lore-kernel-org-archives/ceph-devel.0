From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 09:30:31 -0800
Message-ID: <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net> <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu> <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:53048 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2CHRac convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 12:30:32 -0500
In-Reply-To: <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


On Mar 7, 2012, at 1:40 PM, Greg Farnum wrote:

> CephMount::conf_get requires a buf_size. But we freely adjust that if=
 we need more space, so is there any point to it? I can't see callers r=
eally having a better idea of size than we do.
Good point. I can't think of a reason to publicly expose the buffer len=
gth param in CephMount to users, but CephProxy is a private interface. =
On a related a related note:

   int ceph_conf_get(struct ceph_mount_info *cmount, const char *option=
, char *buf, size_t len);

shouldn't the 'buf' parameter be char ** if libcephfs is going to be do=
ing a re-alloc, or is there some voodoo behind the scenes?


> (Oh, now I see there's another one that doesn't take buf_size. Do we =
have a use case for the with-size option, though?)
> Similarly with getdnames

Yes, the default buf_size interfaces are meant to be friendly, while th=
e explicit buf_size interfaces are primarily meant for the unit tests s=
o that the buffer expansion logic can be tested. It would be safe to le=
ave it public, but maybe it is better for it to be protected and used e=
xplicitly by the unit tests.

> We don't implement CephMount::mkdir, just mkdirs? I *can* see use cas=
es for not wanting recursive creates=85

I was going for the minimum to support Hadoop. I'll stick mkdirs on the=
 short list of API expansion TODOs.

> The ordering is a little funny for some functions =97 we see close() =
before open(), for instance. Maybe we should reorder these?

Yeh, definitely. I noticed that too for some, but clearly didn't catch =
them all.

> set_default_file_replication doesn't actually do anything internally =
=97 I thought that was documented somewhere. Even if it's not, it certa=
inly should be here (and elsewhere, patches welcome! ;). (It passes the=
 value to the Client, and the Client passes it to the MDS, but the MDS =
never looks at it).
> I like the states and require_state() stuff. It's making me notice th=
at you need a little more documentation on stuff like closedir and what=
 happens to the CephDirectory under success and error returns. :)

The state checking is really helpful to catch set faults when blindly c=
asting Java long to void* :) I wonder if there is a way to push the sta=
te checking even further down in libcephfs? Currently all errors are co=
mmunicated through a generic CephException, but making things more spec=
ific as we go along will be nice. In the mean time, though, I'll add ex=
plicit documentation about the state assumptions.

> The CHECK_ARG_* stuff could use some docs. I see now that CHECK_ARG_B=
OUNDS is expecting a full comparison, so it's probably just my lack of =
preprocessor idiom knowledge, but it weirded me out. And CHECK_ARG_COND=
 appears to be unused.
> do we need mount() when we can just run mount(null)? Similarly, I don=
't think we need an if-else in CephMountCreateTest::setupMount. :)

Doh! Fixed.

>=20
>=20
>=20
>=20
> On Wednesday, March 7, 2012 at 10:02 AM, Noah Watkins wrote:
>=20
>> I've kept an eye on how much things are deviating from the current i=
mplementation and its pretty minimal, so I think producing a new versio=
n to use the generic libcephfs interface will happen quickly.
>>=20
>> As for producing an upstream patch, I think the two biggest concerns=
 are:
>>=20
>> 1. Reporting hostname/racks rather than IPs for object location.
>> 2. Address (or at least document) the time synchronization issue.
>>=20
>> These are largely orthogonal to getting the code ready for upstream,=
 but may be a "political" road block? I can put together the details of=
 these two issues in a separate thread=85
>=20
> Please do! I know I've seen most of these issues come up, but I'm sti=
ll a bit fuzzy on the time sync issue.
>=20
> Thanks!
> -Greg
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
