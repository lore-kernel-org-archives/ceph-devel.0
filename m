From: Chris Mason <clmason@fusionio.com>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Thu, 21 Mar 2013 14:06:14 -0400
Message-ID: <20130321180614.30044.29961@localhost.localdomain>
References: <orhak8fm0u.fsf@livre.home>
 <20130318225245.25964.22219@localhost.localdomain>
 <orzjy0dkz9.fsf@livre.home>
 <20130319120940.29898.80124@localhost.localdomain>
 <ora9pzdwdw.fsf@livre.home> <or1ubaesrx.fsf@livre.home>
 <ord2utb4xx.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <ord2utb4xx.fsf@livre.home>
Sender: linux-btrfs-owner@vger.kernel.org
To: Alexandre Oliva <oliva@gnu.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Quoting Alexandre Oliva (2013-03-21 03:14:02)
> On Mar 19, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>=20
> > On Mar 19, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
> >>> that is being processed inside the snapshot.
>=20
> >> This doesn't explain why the master database occasionally gets sim=
ilarly
> >> corrupted, does it?
>=20
> > Actually, scratch this bit for now.  I don't really have proof that=
 the
> > master database actually gets corrupted while it's in use
>=20
> Scratch the =E2=80=9Cscratch this=E2=80=9D.  The master database actu=
ally gets
> corrupted, and it's with recently-created files, created after earlie=
r
> known-good snapshots.  So, it can't really be orphan processing, can =
it?

Right, it can't be orphan processing.

>=20
> Some more info from the errors and instrumentation:
>=20
> - no data syncing on the affected files is taking place.  it's just
>   memcpy()ing data in <4KiB-sized chunks onto mmap()ed areas,
>   munmap()ing it, growing the file with ftruncate and mapping a
>   subsequent chunk for further output
>=20
> - the NULs at the end of pages do NOT occur at munmap/mmap boundaries=
 as
>   I suspected at first, but they do coincide with the end of extents
>   that are smaller than the maximum compressed extent size.  So,
>   something's making btrfs flush pages to disk before the pages are
>   completely written (which is fine in principle), but apparently
>   failing to pick up subsequent changes to the pages (eek!)

With mmap the kernel can pick any given time to start writing out dirty
pages.  The idea is that if the application makes more changes the page
becomes dirty again and the kernel writes it again.

So the question is, can you trigger this without snapshots being done
at all?  I'll try to make an mmap tester here that hammers on the
related code.  We usually test this with fsx, which catches all kinds o=
f
horrors.

-chris
--
To unsubscribe from this list: send the line "unsubscribe linux-btrfs" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
