From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Tue, 19 Mar 2013 22:58:42 -0300
Message-ID: <or1ubaesrx.fsf@livre.home>
References: <orhak8fm0u.fsf@livre.home>
	<20130318225245.25964.22219@localhost.localdomain>
	<orzjy0dkz9.fsf@livre.home>
	<20130319120940.29898.80124@localhost.localdomain>
	<ora9pzdwdw.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <ora9pzdwdw.fsf@livre.home> (Alexandre Oliva's message of "Tue,
	19 Mar 2013 16:26:03 -0300")
Sender: linux-btrfs-owner@vger.kernel.org
To: Chris Mason <clmason@fusionio.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mar 19, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

>> that is being processed inside the snapshot.

> This doesn't explain why the master database occasionally gets similarly
> corrupted, does it?

Actually, scratch this bit for now.  I don't really have proof that the
master database actually gets corrupted while it's in use, rather than
having inherited corruption on a server restart, that rolls back to the
most recent snapshot and replays the osd journal on it.  It could be
that the used snapshot is corrupted in a way that doesn't manifest
itself immediately, or that that it gets corrupted afterwards with your
delayed-orphan theory.

I wrote a test that exercises leveldb's PosixMmapFile with highly
compressible appends of varying sizes, as well as syncs and btrfs
snapshots at random, but I haven't been able to trigger the problem with
it (yet?).

I'm now instrumenting the failing code to try to collect more data.  It
looks like, even though ceph does use leveldb's sync option in some
situations, the syncs don't seem to get all to the data files, only to
the leveldb logs.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
