From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 14:28:09 -0700
Message-ID: <5137B4E9.1030505@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
 <D19243567199482692F961618A335817@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35715 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab3CFV2c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 16:28:32 -0500
In-Reply-To: <D19243567199482692F961618A335817@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On 03/06/2013 01:21 PM, Greg Farnum wrote:
>> > Also, this issue of stat on files created on other clients seems
>> > like it's going to be problematic for many interactions our users
>> > will have with the files created by their parallel compute jobs -
>> > any suggestion on how to avoid or fix it?
>> > =20
> Brief background: stat is required to provide file size information,
> and so when you do a stat Ceph needs to find out the actual file
> size. If the file is currently in use by somebody, that requires
> gathering up the latest metadata from them. Separately, while Ceph
> allows a client and the MDS to proceed with a bunch of operations
> (ie, mknod) without having it go to disk first, it requires anything
> which is visible to a third party (another client) be durable on disk
> for consistency reasons.
>=20
> These combine to mean that if you do a stat on a file which a client
> currently has buffered writes for, that buffer must be flushed out to
> disk before the stat can return. This is the usual cause of the slow
> stats you're seeing. You should be able to adjust dirty data
> thresholds to encourage faster writeouts, do fsyncs once a client is
> done with a file, etc in order to minimize the likelihood of running
> into this. Also, I'd have to check but I believe opening a file with
> LAZY_IO or whatever will weaken those requirements =E2=80=94 it's pro=
bably
> not the solution you'd like here but it's an option, and if this
> turns out to be a serious issue then config options to reduce
> consistency on certain operations are likely to make their way into
> the roadmap. :)

That all makes sense.

But, it turns out the files in question were written yesterday,
and I did the stat operations today.

So, shouldn't the dirty buffer issue not be in play here?

Is there anything else that might be going on?

Thanks -- Jim

> -Greg
>=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
