From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Wed, 13 Apr 2016 12:27:35 +0900
Message-ID: <20160413122735.082783c7@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<20160412083925.5106311d@batzmaru.gol.ad.jp>
	<alpine.DEB.2.11.1604112046570.29593@cpach.fuggernut.com>
	<20160412114341.098486f7@batzmaru.gol.ad.jp>
	<alpine.DEB.2.11.1604120837120.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604120837120.29593-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Hello,

On Tue, 12 Apr 2016 09:56:32 -0400 (EDT) Sage Weil wrote:

> Hi all,
> 
> I've posted a pull request that updates any mention of ext4 in the docs:
> 
> 	https://github.com/ceph/ceph/pull/8556
> 
> In particular, I would appreciate any feedback on
> 
> 	https://github.com/ceph/ceph/pull/8556/commits/49604303124a2b546e66d6e130ad4fa296602b01
> 
> both on substance and delivery.
> 
> Given the previous lack of clarity around ext4, and that it works well 
> enough for RBD and other short object name workloads, I think the most
> we can do now is deprecate it to steer any new OSDs away.
> 
A clear statement of what "short" means in this context and if this (in
general) applies to RBD and CephFS would probably be helpful.

> And at least in the non-RGW case, I mean deprecate in the "recommend 
> alternative" sense of the word, not that it won't be tested or that any 
> code will be removed.
> 
> 	https://en.wikipedia.org/wiki/Deprecation#Software_deprecation
> 
> If there are ext4 + RGW users, that is still a difficult issue, since it 
> is broken now, and expensive to fix.
> 
I'm wondering what the cross section of RGW (being "stable" a lot longer
than CephFS) and Ext4 users is for this to pop up so late in the game.

Also, since Sam didn't pipe up, I'd still would like to know if this is
"fixed" by having larger than the default 256Byte Ext4 inodes (2KB in my
case) as it isn't purely academic for me.
Or maybe other people like "Michael Metz-Martini" who need Ext4 for
performance reasons and can't obviously go to BlueStore yet.

> 
> On Tue, 12 Apr 2016, Christian Balzer wrote:
> > Only RBD on all clusters so far and definitely no plans to change that 
> > for the main, mission critical production cluster. I might want to add 
> > CephFS to the other production cluster at some time, though.
> 
> That's good to hear.  If you continue to use ext4 (by adjusting down the 
> max object length), the only limitation you should hit is an indirect
> cap on the max RBD image name length.
> 
Just to parse this sentence correctly, is it the name of the object
(output of "rados ls"), the name of the image "rbd ls" or either?

> > No RGW, but if/when RGW supports "listing objects quickly" (is what I
> > vaguely remember from my conversation with Timo Sirainen, the Dovecot
> > author) we would be very interested in that particular piece of Ceph as
> > well. On a completely new cluster though, so no issue.
> 
> OT, but I suspect he was referring to something slightly different
> here. Our conversations about object listing vs the dovecot backend
> surrounded the *rados* listing semantics (hash-based, not prefix/name
> based).  RGW supports fast sorted/prefix name listings, but you pay for
> it by maintaining an index (which slows down PUT).  The latest RGW in
> Jewel has experimental support for a non-indexed 'blind' bucket as well
> for users that need some of the RGW features (ACLs, striping, etc.) but
> not the ordered object listing and other index-dependent features.
> 
Sorry about the OT, but since the Dovecot (Pro) backend supports S3 I
would have thought that RGW would be a logical expansion from there, not
going for a completely new (but likely a lot faster) backend using rados.
Oh well, I shall go poke them.

> > Again, most people that deploy Ceph in a commercial environment (that
> > is working for a company) will be under pressure by the penny-pinching
> > department to use their HW for 4-5 years (never mind the pace of
> > technology and Moore's law).
> > 
> > So you will want to:
> > a) Announce the end of FileStore ASAP, but then again you can't really
> > do that before BlueStore is stable.
> > b) support FileStore for 4 years at least after BlueStore is the
> > default. This could be done by having a _real_ LTS release, instead of
> > dragging Filestore into newer version.
> 
> Right.  Nothing can be done until the preferred alternative is
> completely stable, and from then it will take quite some time to drop
> support or remove it given the install base.
> 
> > > > Which brings me to the reasons why people would want to migrate
> > > > (NOT talking about starting freshly) to bluestore.
> > > > 
> > > > 1. Will it be faster (IOPS) than filestore with SSD journals? 
> > > > Don't think so, but feel free to prove me wrong.
> > > 
> > > It will absolutely faster on the same hardware.  Whether BlueStore on
> > > HDD only is faster than FileStore HDD + SSD journal will depend on
> > > the workload.
> > > 
> > Where would the Journal SSDs enter the picture with BlueStore? 
> > Not at all, AFAIK, right?
> 
> BlueStore can use as many as three devices: one for the WAL (journal, 
> though it can be much smaller than FileStores, e.g., 128MB), one for 
> metadata (e.g., an SSD partition), and one for data.
> 
Right, I blanked on that, despite having read the K/V storage back when
they first showed up. Just didn't make the connection with BlueStore.

OK, so we have a small write-intent-log, probably even better hosted on
NVRAM with new installs. 
The metadata is the same/similar to what lives in ...current/meta/... on
OSDs these days?
If so, that's 30MB per PG in my case, so not a lot either.

> > I'm thinking again about people with existing HW again. 
> > What do they do with those SSDs, which aren't necessarily sized in a
> > fashion to be sensible SSD pools/cache tiers?
> 
> We can either use them for BlueStore wal and metadata, or as a cache for 
> the data device (e.g., dm-cache, bcache, FlashCache), or some
> combination of the above.  It will take some time to figure out which
> gives the best performance (and for which workloads).
>
Including finding out which sauce these caching layers prefer when eating
your data. ^_- 
Given the current state of affairs and reports of people here I'll likely
take a comfy backseat there.
 
> > > > 2. Will it be bit-rot proof? Note the deafening silence from the
> > > > devs in this thread: 
> > > > http://www.spinics.net/lists/ceph-users/msg26510.html
> > > 
> > > I missed that thread, sorry.
> > > 
> > > We (Mirantis, SanDisk, Red Hat) are currently working on checksum
> > > support in BlueStore.  Part of the reason why BlueStore is the
> > > preferred path is because we will probably never see full
> > > checksumming in ext4 or XFS.
> > > 
> > Now this (when done correctly) and BlueStore being a stable default
> > will be a much, MUCH higher motivation for people to migrate to it than
> > terminating support for something that works perfectly well (for my use
> > case at least).
> 
> Agreed.
> 
> > > > > How:
> > > > > 
> > > > > To make this change as visible as possible, the plan is to make
> > > > > ceph-osd refuse to start if the backend is unable to support the
> > > > > configured max object name (osd_max_object_name_len).  The OSD
> > > > > will complain that ext4 cannot store such an object and refuse
> > > > > to start. A user who is only using RBD might decide they don't
> > > > > need long file names to work and can adjust the
> > > > > osd_max_object_name_len setting to something small (say, 64) and
> > > > > run successfully.  They would be taking a risk, though, because
> > > > > we would like to stop testing on ext4.
> > > > > 
> > > > > Is this reasonable?  
> > > > About as reasonable as dropping format 1 support, that is not at
> > > > all.
> > > > https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg28070.html
> > > 
> > > Fortunately nobody (to my knowledge) has suggested dropping format 1 
> > > support.  :)
> > > 
> > I suggest you look at that thread and your official release notes:
> > ---
> > * The rbd legacy image format (version 1) is deprecated with the Jewel
> > release. Attempting to create a new version 1 RBD image will result in
> > a warning. Future releases of Ceph will remove support for version 1
> > RBD images. ---
> 
> "Future releases of Ceph *may* remove support" might be more accurate,
> but it doesn't make for as compelling a warning, and it's pretty likely
> that *eventually* it will make sense to drop it.  That won't happen
> without a proper conversation about user impact and migration, though.
> There are real problems with format 1 besides just the lack of new
> features (e.g., rename vs watchers).
> 
> This is what 'deprecation' means: we're not dropping support now (that 
> *would* be unreasonable), but we're warning users that at some future 
> point we (probably) will.  If there is any reason why new images
> shouldn't be created with v2, please let us know.  Obviously v1 -> v2
> image conversion remains an open issue.
> 
Yup, I did change my default format on the other cluster early on to 2,
but the mission critical one is a lot older and at 1 with over 450
images/VMs. 
So having something that will convert things with a light touch is very
much needed.

Thanks again,

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
