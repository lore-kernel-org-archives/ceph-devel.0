From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Tue, 10 Oct 2017 09:50:14 +0900
Message-ID: <20171010095014.64940afa@batzmaru.gol.ad.jp>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1710091448500.26711-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Hello,

(pet peeve alert)
On Mon, 9 Oct 2017 15:09:29 +0000 (UTC) Sage Weil wrote:

> To put this in context, the goal here is to kill ceph-disk in mimic.  
> 
> One proposal is to make it so new OSDs can *only* be deployed with LVM, 
> and old OSDs with the ceph-disk GPT partitions would be started via 
> ceph-volume support that can only start (but not deploy new) OSDs in that 
> style.
> 
> Is the LVM-only-ness concerning to anyone?
>
If the provision below is met, not really.
 
> Looking further forward, NVMe OSDs will probably be handled a bit 
> differently, as they'll eventually be using SPDK and kernel-bypass (hence, 
> no LVM).  For the time being, though, they would use LVM.
>
And so it begins.
LVM does a lot of nice things, but not everything for everybody. 
It is also another layer added with all the (minor) reductions in
performance (with normal storage, not NVMe) and of course potential bugs.
 
> 
> On Fri, 6 Oct 2017, Alfredo Deza wrote:
> > Now that ceph-volume is part of the Luminous release, we've been able
> > to provide filestore support for LVM-based OSDs. We are making use of
> > LVM's powerful mechanisms to store metadata which allows the process
> > to no longer rely on UDEV and GPT labels (unlike ceph-disk).
> > 
> > Bluestore support should be the next step for `ceph-volume lvm`, and
> > while that is planned we are thinking of ways to improve the current
> > caveats (like OSDs not coming up) for clusters that have deployed OSDs
> > with ceph-disk.
> > 
> > --- New clusters ---
> > The `ceph-volume lvm` deployment is straightforward (currently
> > supported in ceph-ansible), but there isn't support for plain disks
> > (with partitions) currently, like there is with ceph-disk.
> > 
> > Is there a pressing interest in supporting plain disks with
> > partitions? Or only supporting LVM-based OSDs fine?  
> 
> Perhaps the "out" here is to support a "dir" option where the user can 
> manually provision and mount an OSD on /var/lib/ceph/osd/*, with 'journal' 
> or 'block' symlinks, and ceph-volume will do the last bits that initialize 
> the filestore or bluestore OSD from there.  Then if someone has a scenario 
> that isn't captured by LVM (or whatever else we support) they can always 
> do it manually?
> 
Basically this.
Since all my old clusters were deployed like this, with no
chance/intention to upgrade to GPT or even LVM.
How would symlinks work with Bluestore, the tiny XFS bit?

> > --- Existing clusters ---
> > Migration to ceph-volume, even with plain disk support means
> > re-creating the OSD from scratch, which would end up moving data.
> > There is no way to make a GPT/ceph-disk OSD become a ceph-volume one
> > without starting from scratch.
> > 
> > A temporary workaround would be to provide a way for existing OSDs to
> > be brought up without UDEV and ceph-disk, by creating logic in
> > ceph-volume that could load them with systemd directly. This wouldn't
> > make them lvm-based, nor it would mean there is direct support for
> > them, just a temporary workaround to make them start without UDEV and
> > ceph-disk.
> > 
> > I'm interested in what current users might look for here,: is it fine
> > to provide this workaround if the issues are that problematic? Or is
> > it OK to plan a migration towards ceph-volume OSDs?  
> 
> IMO we can't require any kind of data migration in order to upgrade, which 
> means we either have to (1) keep ceph-disk around indefinitely, or (2) 
> teach ceph-volume to start existing GPT-style OSDs.  Given all of the 
> flakiness around udev, I'm partial to #2.  The big question for me is 
> whether #2 alone is sufficient, or whether ceph-volume should also know 
> how to provision new OSDs using partitions and no LVM.  Hopefully not?
> 
I really disliked the udev/GPT stuff from the get-go and flakiness is
being kind for sometimes completely indeterministic behavior.

Since there never was an (non-disruptive) upgrade process from non-GPT
based OSDs to GPT based ones, I wonder what changed minds here.
Not that the GPT based users won't appreciate it.

Christian
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 


-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Rakuten Communications
