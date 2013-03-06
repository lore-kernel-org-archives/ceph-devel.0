From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 13:39:54 -0800
Message-ID: <1856965A675D4D5D971D5DC9AB01C657@inktank.com>
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
 <5137B4E9.1030505@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52262 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab3CFVj7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 16:39:59 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so6595548pbc.11
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 13:39:58 -0800 (PST)
In-Reply-To: <5137B4E9.1030505@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Wednesday, March 6, 2013 at 1:28 PM, Jim Schutt wrote:
> On 03/06/2013 01:21 PM, Greg Farnum wrote:
> > > > Also, this issue of stat on files created on other clients seem=
s
> > > > like it's going to be problematic for many interactions our use=
rs
> > > > will have with the files created by their parallel compute jobs=
 -
> > > > any suggestion on how to avoid or fix it?
> > > =20
> > =20
> > =20
> > Brief background: stat is required to provide file size information=
,
> > and so when you do a stat Ceph needs to find out the actual file
> > size. If the file is currently in use by somebody, that requires
> > gathering up the latest metadata from them. Separately, while Ceph
> > allows a client and the MDS to proceed with a bunch of operations
> > (ie, mknod) without having it go to disk first, it requires anythin=
g
> > which is visible to a third party (another client) be durable on di=
sk
> > for consistency reasons.
> > =20
> > These combine to mean that if you do a stat on a file which a clien=
t
> > currently has buffered writes for, that buffer must be flushed out =
to
> > disk before the stat can return. This is the usual cause of the slo=
w
> > stats you're seeing. You should be able to adjust dirty data
> > thresholds to encourage faster writeouts, do fsyncs once a client i=
s
> > done with a file, etc in order to minimize the likelihood of runnin=
g
> > into this. Also, I'd have to check but I believe opening a file wit=
h
> > LAZY_IO or whatever will weaken those requirements =E2=80=94 it's p=
robably
> > not the solution you'd like here but it's an option, and if this
> > turns out to be a serious issue then config options to reduce
> > consistency on certain operations are likely to make their way into
> > the roadmap. :)
> =20
> =20
> =20
> That all makes sense.
> =20
> But, it turns out the files in question were written yesterday,
> and I did the stat operations today.
> =20
> So, shouldn't the dirty buffer issue not be in play here?
Probably not. :/


> Is there anything else that might be going on?
In that case it sounds like either there's a slowdown on disk access th=
at is propagating up the chain very bizarrely, there's a serious perfor=
mance issue on the MDS (ie, swapping for everything), or the clients ar=
e still holding onto capabilities for the files in question and you're =
running into some issues with the capability revocation mechanisms.
Can you describe your setup a bit more? What versions are you running, =
kernel or userspace clients, etc. What config options are you setting o=
n the MDS? Assuming you're on something semi-recent, getting a perfcoun=
ter dump from the MDS might be illuminating as well.

We'll probably want to get a high-debug log of the MDS during these slo=
w stats as well.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
