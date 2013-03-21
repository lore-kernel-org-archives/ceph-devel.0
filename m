From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Thu, 21 Mar 2013 04:14:02 -0300
Message-ID: <ord2utb4xx.fsf@livre.home>
References: <orhak8fm0u.fsf@livre.home>
	<20130318225245.25964.22219@localhost.localdomain>
	<orzjy0dkz9.fsf@livre.home>
	<20130319120940.29898.80124@localhost.localdomain>
	<ora9pzdwdw.fsf@livre.home> <or1ubaesrx.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:60178 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab3CUHOw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 03:14:52 -0400
In-Reply-To: <or1ubaesrx.fsf@livre.home> (Alexandre Oliva's message of "Tue,
	19 Mar 2013 22:58:42 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Mason <clmason@fusionio.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mar 19, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

> On Mar 19, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>>> that is being processed inside the snapshot.

>> This doesn't explain why the master database occasionally gets simil=
arly
>> corrupted, does it?

> Actually, scratch this bit for now.  I don't really have proof that t=
he
> master database actually gets corrupted while it's in use

Scratch the =E2=80=9Cscratch this=E2=80=9D.  The master database actual=
ly gets
corrupted, and it's with recently-created files, created after earlier
known-good snapshots.  So, it can't really be orphan processing, can it=
?

Some more info from the errors and instrumentation:

- no data syncing on the affected files is taking place.  it's just
  memcpy()ing data in <4KiB-sized chunks onto mmap()ed areas,
  munmap()ing it, growing the file with ftruncate and mapping a
  subsequent chunk for further output

- the NULs at the end of pages do NOT occur at munmap/mmap boundaries a=
s
  I suspected at first, but they do coincide with the end of extents
  that are smaller than the maximum compressed extent size.  So,
  something's making btrfs flush pages to disk before the pages are
  completely written (which is fine in principle), but apparently
  failing to pick up subsequent changes to the pages (eek!)

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
