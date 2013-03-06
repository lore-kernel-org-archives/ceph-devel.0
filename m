From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 12:21:28 -0800
Message-ID: <D19243567199482692F961618A335817@inktank.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:62319 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CFUVh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 15:21:37 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so6472092pbb.41
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 12:21:37 -0800 (PST)
In-Reply-To: <51379FCD.9000502@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Wednesday, March 6, 2013 at 11:58 AM, Jim Schutt wrote:
> On 03/06/2013 12:13 PM, Greg Farnum wrote:
> > Check out the directory sizes with ls -l or whatever =E2=80=94 thos=
e numbers are semantically meaningful! :)
> =20
> =20
> That is just exceptionally cool!
> =20
> > =20
> > Unfortunately we can't (currently) use those "recursive statistics"
> > to do proper hard quotas on subdirectories as they're lazily
> > propagated following client ops, not as part of the updates. (Lazil=
y
> > in the technical sense =E2=80=94 it's actually quite fast in genera=
l). But
> > they'd work fine for soft quotas if somebody wrote the code, or to
> > block writes on a slight time lag.
> =20
> =20
> =20
> 'ls -lh <dir>' seems to be just the thing if you already know <dir>.
> =20
> And it's perfectly suitable for our use case of not scheduling
> new jobs for users consuming too much space.
> =20
> I was thinking I might need to find a subtree where all the
> subdirectories are owned by the same user, on the theory that
> all the files in such a subtree would be owned by that same
> user. E.g., we might want such a capability to manage space per
> user in shared project directories.
> =20
> So, I tried 'find <dir> -type d -exec ls -lhd {} \;'
> =20
> Unfortunately, that ended up doing a 'newfstatat' on each file
> under <dir>, evidently to learn if it was a directory. The
> result was that same slowdown for files written on other clients.
> =20
> Is there some other way I should be looking for directories if I
> don't already know what they are?
> =20
> Also, this issue of stat on files created on other clients seems
> like it's going to be problematic for many interactions our users
> will have with the files created by their parallel compute jobs -
> any suggestion on how to avoid or fix it?
> =20

Brief background: stat is required to provide file size information, an=
d so when you do a stat Ceph needs to find out the actual file size. If=
 the file is currently in use by somebody, that requires gathering up t=
he latest metadata from them.
Separately, while Ceph allows a client and the MDS to proceed with a bu=
nch of operations (ie, mknod) without having it go to disk first, it re=
quires anything which is visible to a third party (another client) be d=
urable on disk for consistency reasons.

These combine to mean that if you do a stat on a file which a client cu=
rrently has buffered writes for, that buffer must be flushed out to dis=
k before the stat can return. This is the usual cause of the slow stats=
 you're seeing. You should be able to adjust dirty data thresholds to e=
ncourage faster writeouts, do fsyncs once a client is done with a file,=
 etc in order to minimize the likelihood of running into this.
Also, I'd have to check but I believe opening a file with LAZY_IO or wh=
atever will weaken those requirements =E2=80=94 it's probably not the s=
olution you'd like here but it's an option, and if this turns out to be=
 a serious issue then config options to reduce consistency on certain o=
perations are likely to make their way into the roadmap. :)
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
