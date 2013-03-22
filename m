From: Chris Mason <clmason@fusionio.com>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Fri, 22 Mar 2013 10:26:59 -0400
Message-ID: <20130322142659.27874.81283@localhost.localdomain>
References: <orhak8fm0u.fsf@livre.home>
 <20130319120940.29898.80124@localhost.localdomain>
 <ora9pzdwdw.fsf@livre.home> <or1ubaesrx.fsf@livre.home>
 <ord2utb4xx.fsf@livre.home>
 <20130321180614.30044.29961@localhost.localdomain>
 <20130321230621.30044.80640@localhost.localdomain>
 <orzjxw9f75.fsf@livre.home>
 <20130322120754.27874.14389@localhost.localdomain>
 <orobeba58l.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <orobeba58l.fsf@livre.home>
Sender: linux-btrfs-owner@vger.kernel.org
To: Alexandre Oliva <oliva@gnu.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Quoting Alexandre Oliva (2013-03-22 10:17:30)
> On Mar 22, 2013, Chris Mason <clmason@fusionio.com> wrote:
> 
> > Are you using compression in btrfs or just in leveldb?
> 
> btrfs lzo compression.

Perfect, I'll focus on that part of things.

> 
> > I'd like to take snapshots out of the picture for a minute.
> 
> That's understandable, I guess, but I don't know that anyone has ever
> got the problem without snapshots.  I mean, even when the master copy of
> the database got corrupted, snapshots of the subvol containing it were
> being taken every now and again, because that's the way ceph works.

Hopefully Sage can comment, but the basic idea is that if you snapshot a
database file the db must participate.  If it doesn't, it really is the
same effect as crashing the box.

Something is definitely broken if we're corrupting the source files
(either with or without snapshots), but avoiding incomplete writes in
the snapshot files requires synchronization with the db.

-chris
