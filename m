From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: newstore direction
Date: Tue, 20 Oct 2015 09:06:46 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB569C6C42@ABGEX73E.FSC.NET>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:46213 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbJTHGy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 03:06:54 -0400
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, October 19, 2015 9:49 PM
>=20
> The current design is based on two simple ideas:
>=20
>  1) a key/value interface is better way to manage all of our internal=
 metadata
> (object metadata, attrs, layout, collection membership, write-ahead l=
ogging,
> overlay data, etc.)
>=20
>  2) a file system is well suited for storage object data (as files).
>=20
> So far 1 is working out well, but I'm questioning the wisdom of #2.  =
A few
> things:
>=20
> [..]
>=20
> But what's the alternative?  My thought is to just bite the bullet an=
d consume
> a raw block device directly.  Write an allocator, hopefully keep it p=
retty
> simple, and manage it in kv store along with all of our other metadat=
a.

This is pretty much reinventing the file system, but...

I actually did something similar for my personal project (e-mail client=
), moving from maildir-like structure (each message was one file) to so=
mething resembling mbox (one large file per mail folder, containing pre=
-decoded structures for fast and easy access). And this worked out real=
ly well, especially with searches and bulk processing (filtering by bod=
y contents, and so on). I don't remember exact figures, but the perform=
ance benefit was in at least order of magnitude. If huge amounts of sma=
ll-to-medium (0-128k) objects are the target, this is the way to go.

The most serious issue was fragmentation. Since I actually put my box f=
iles on top of actual FS (here: NTFS), low-level fragmentation was not =
a problem (each message was read and written in one fread/fwrite anyway=
). High-level fragmentation was an issue - each time a message was move=
d away, it still occupied space. To combat this, I wrote a space reclai=
mer that moved messages within box file (consolidated them) and maintai=
ned a bitmap of 4k free spaces, so I could re-use unused space without =
taking too much time iterating through messages and without calling rec=
laimer. Also, reclaimer was smart enough to not move messages one-by-on=
e, but instead it loaded up to n messages in at most n reads (in common=
 case it was less than that) and wrote them in one call and do its work=
 until some space was actually reclaimed, instead of doing full garbage=
 collection. Machinery was also aware of fact that messages were (mostl=
y) appended to the end of box, so instead of blindly doing that, it mov=
ed back end-of-box pointer once messages at the end of box were deleted=
=2E
Other issue was reliability. Obviously, I had an option of secondary te=
mp file, but still, everything above is doable without that.
Benefits included reduced requirements for metadata storage. Instead of=
 generating unique ID (filename) for each message (apparently, message-=
id header is not reliable in that regard), I just stored offset and siz=
e (8+4 bytes per message), which, for 300 thousand of messages calculat=
ed to just 3,5MB of memory and could be kept in RAM. I/O performance ha=
s also improved due to less random access pattern (messages were physic=
ally close to each other instead of being scattered all over the drive)
=46or Ceph, benefits could be even greater. I can imagine faster deep s=
crubs that are way more efficient on spinning drives; efficient object =
storage (no per-object fragmentation and less disk-intensive object rea=
dahead, maybe with better support from hardware); possibly more reliabi=
lity (when we fsync, we actually fsync - we don't get cheated by underl=
ying FS), and we could get it optimized for particular devices (for exa=
mple, most SSDs suck like vacuum on I/Os below 4k, so we could enforce =
I/Os of at least 4k).

Just my 0.02$.

With best regards / Pozdrawiam
Piotr Da=B3ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
