From: Greg Farnum <greg@inktank.com>
Subject: CephFS Space Accounting and Quotas (was: CephFS First product
 release discussion)
Date: Wed, 6 Mar 2013 11:13:58 -0800
Message-ID: <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43120 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab3CFTOD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 14:14:03 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so6415740pbb.27
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 11:14:02 -0800 (PST)
In-Reply-To: <513793FD.7010001@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Wednesday, March 6, 2013 at 11:07 AM, Jim Schutt wrote:
> On 03/05/2013 12:33 PM, Sage Weil wrote:
> > > > Running 'du' on each directory would be much faster with Ceph s=
ince it
> > > > accounts tracks the subdirectories and shows their total size w=
ith an 'ls
> > > > -al'.
> > > > =20
> > > > Environments with 100k users also tend to be very dynamic with =
adding and
> > > > removing users all the time, so creating separate filesystems f=
or them would
> > > > be very time consuming.
> > > > =20
> > > > Now, I'm not talking about enforcing soft or hard quotas, I'm j=
ust talking
> > > > about knowing how much space uid X and Y consume on the filesys=
tem.
> > > =20
> > =20
> > =20
> > The part I'm most unclear on is what use cases people have where ui=
d X and =20
> > Y are spread around the file system (not in a single or small set o=
f sub =20
> > directories) and per-user (not, say, per-project) quotas are still =
=20
> > necessary. In most environments, users get their own home directory=
 and =20
> > everything lives there...
> =20
> =20
> =20
> Hmmm, is there a tool I should be using that will return the space
> used by a directory, and all its descendants?
> =20
> If it's 'du', that tool is definitely not fast for me.
> =20
> I'm doing an 'strace du -s <path>', where <path> has one
> subdirectory which contains ~600 files. I've got ~200 clients
> mounting the file system, and each client wrote 3 files in that
> directory.
> =20
> I'm doing the 'du' from one of those nodes, and the strace is showing
> me du is doing a 'newfstat' for each file. For each file that was
> written on a different client from where du is running, that 'newfsta=
t'
> takes tens of seconds to return. Which means my 'du' has been running
> for quite some time and hasn't finished yet....
> =20
> I'm hoping there's another tool I'm supposed to be using that I
> don't know about yet. Our use case includes tens of millions
> of files written from thousands of clients, and whatever tool
> we use to do space accounting needs to not walk an entire directory
> tree, checking each file.

Check out the directory sizes with ls -l or whatever =E2=80=94 those nu=
mbers are semantically meaningful! :)

Unfortunately we can't (currently) use those "recursive statistics" to =
do proper hard quotas on subdirectories as they're lazily propagated fo=
llowing client ops, not as part of the updates. (Lazily in the technica=
l sense =E2=80=94 it's actually quite fast in general). But they'd work=
 fine for soft quotas if somebody wrote the code, or to block writes on=
 a slight time lag.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
