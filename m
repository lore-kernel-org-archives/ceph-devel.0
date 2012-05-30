From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Wed, 30 May 2012 09:08:56 +0200
Message-ID: <201205300908.56991.a.ott@m-privacy.de>
References: <201205290944.33983.a.ott@m-privacy.de> <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:59945 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab2E3HJH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:09:07 -0400
In-Reply-To: <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday 29 May 2012 you wrote:
> On Tue, 29 May 2012, Amon Ott wrote:
> > Conclusion: If you want to run OSD and cephfs kernel client on the =
same
> > Linux server and have a libc6 before 2.14 (e.g. Debian's newest in
> > experimental is 2.13) or a kernel before 2.6.39, either do not use =
ext4
> > (but btrfs is still unstable) or risk data loss by missing syncs th=
rough
> > the workaround of forcing filestore_fsync_flushes_journal_data to t=
rue.
>
> Note that fsync_flushed_journal_data should only be set to true with =
ext3
> and the 'data=3Dordered' or 'data=3Djournal' mount option.  It is an
> implementation artifact only that fsync() will flush all previous wri=
tes.

I am fully aware of that, this is why I mentioned the risk of data loss=
=2E

> > Please consider putting out a fat warning at least at build time, i=
f
> > syncfs() is not available, e.g. "No syncfs() syscall, please expect=
 a
> > deadlock when running osd on non-btrfs together with a local cephfs
> > mount." Even better would be a quick runtime test for missing syncf=
s()
> > and storage on non-btrfs that spits out a warning, if deadlock is
> > possible.
>
> I think a runtime warning makes more sense; nobody will see the build=
 time
> warning (e.g., those installed debs).

Yes, fully agreed.

> > As a side effect, the experienced lockup seems to be a good way to
> > reproduce the long standing bug 1047 - when our cluster tried to re=
cover,
> > all MDS instances died with those symptoms. It seems that a partial=
 sync
> > of journal or data partition causes that broken state.
>
> Interesting!  If you could also note on that bug what the metadata
> workload was (what was making hard links?), that would be great!

We are auto creating up to 200 preconfigured home directories on all fo=
ur=20
nodes, each home dir consists of ca. 400 dirs and files with ca. 16 MB =
of=20
data. AFAIK, there are no hard links involved. So it is a massive paral=
lel=20
creation of many small files, probably lots of metadata for them.

Will put that as note to the bug, too.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
