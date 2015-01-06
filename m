From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-deploy osd destroy feature
Date: Mon, 5 Jan 2015 21:08:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501052107140.10525@cobra.newdream.net>
References: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com> <54A91EDA.8080008@42on.com> <CACkq2mr9yxmiLd028hQmsC4TLqb3FBgww-6O_pML3ubyybFo5g@mail.gmail.com> <alpine.DEB.2.00.1501050921040.5967@cobra.newdream.net>
 <CACkq2mq1MrVi430=F+xvOcYw+vY+B_qXimWUtSynN0WB1R-c8A@mail.gmail.com> <alpine.DEB.2.00.1501051017041.5967@cobra.newdream.net> <CAANLjFpE1-9hOsFFdCkyLP7M8s99xuWXKfss7atTRd7MAc-5iA@mail.gmail.com>
 <CABF_e-GcU6KyFD7LneiEi4ExpJ5i7MoDZycGeS_qzrM_HH-vCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58478 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbAFFIU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 00:08:20 -0500
In-Reply-To: <CABF_e-GcU6KyFD7LneiEi4ExpJ5i7MoDZycGeS_qzrM_HH-vCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, Travis Rhoden <trhoden@gmail.com>, Wido den Hollander <wido@42on.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 6 Jan 2015, Wei-Chung Cheng wrote:
> Dear all:
> 
> I agree Robert opinion because I hit the similar problem once.
> I think that how to handle journal partition is another problem about
> destroy subcommand.
> (Although it will work normally most time)
> 
> I also agree we need the "secure erase" feature.
> As my experience, I just make new label for disk by "parted" command.
> I will think how could we do a secure erase or someone have a good
> idea for this?

The simplest secure erase is to encrypt the disk and destroy the key.  You 
can do that with dm-crypt today.  Most drives also will do this in the 
firmware but I'm not familiar with the toolchain needed to use that 
feature.  (It would be much preferable to go that route, though, since it 
will avoid any CPU overhead.)

sage


> 
> Anyway, I rework and implement the deactivate first.
> 
> 
> 
> 
> 2015-01-06 8:42 GMT+08:00 Robert LeBlanc <robert@leblancnet.us>:
> > I do think the "find a journal partition" code isn't particularly robust.
> > I've had experiences with ceph-disk trying to create a new partition even
> > though I had wiped/zapped a disk previously. It would make the operational
> > component of Ceph much easier with replacing disks if the journal partition
> > is cleanly removed and able to be reused automatically.
> >
> > On Mon, Jan 5, 2015 at 11:18 AM, Sage Weil <sage@newdream.net> wrote:
> >> On Mon, 5 Jan 2015, Travis Rhoden wrote:
> >>> On Mon, Jan 5, 2015 at 12:27 PM, Sage Weil <sage@newdream.net> wrote:
> >>> > On Mon, 5 Jan 2015, Travis Rhoden wrote:
> >>> >> Hi Loic and Wido,
> >>> >>
> >>> >> Loic - I agree with you that it makes more sense to implement the core
> >>> >> of the logic in ceph-disk where it can be re-used by other tools (like
> >>> >> ceph-deploy) or by administrators directly.  There are a lot of
> >>> >> conventions put in place by ceph-disk such that ceph-disk is the best
> >>> >> place to undo them as part of clean-up.  I'll pursue this with other
> >>> >> Ceph devs to see if I can get agreement on the best approach.
> >>> >>
> >>> >> At a high-level, ceph-disk has two commands that I think could have a
> >>> >> corollary -- prepare, and activate.
> >>> >>
> >>> >> Prepare will format and mkfs a disk/dir as needed to make it usable by Ceph.
> >>> >> Activate will put the resulting disk/dir into service by allocating an
> >>> >> OSD ID, creating the cephx key, and marking the init system as needed,
> >>> >> and finally starting the ceph-osd service.
> >>> >>
> >>> >> It seems like there could be two opposite commands that do the following:
> >>> >>
> >>> >> deactivate:
> >>> >>  - set "ceph osd out"
> >>> >
> >>> > I don't think 'out out' belongs at all.  It's redundant (and extra work)
> >>> > if we remove the osd from the CRUSH map.  I would imagine it being a
> >>> > possibly independent step.  I.e.,
> >>> >
> >>> >  - drain (by setting CRUSH weight to 0)
> >>> >  - wait
> >>> >  - deactivate
> >>> >  - (maybe) destroy
> >>> >
> >>> > That would make deactivate
> >>> >
> >>> >>  - stop ceph-osd service if needed
> >>> >>  - remove OSD from CRUSH map
> >>> >>  - remove OSD cephx key
> >>> >>  - deallocate OSD ID
> >>> >>  - remove 'ready', 'active', and INIT-specific files (to Wido's point)
> >>> >>  - umount device and remove mount point
> >>> >
> >>> > which I think make sense if the next step is to destroy or to move the
> >>> > disk to another box.  In the latter case the data will likely need to move
> >>> > to another disk anyway so keeping it around it just a data safety thing
> >>> > (keep as many copies as possible).
> >>> >
> >>> > OTOH, if you clear out the OSD id then deactivate isn't reversible
> >>> > with activate as the OSD might be a new id even if it isn't moved.  An
> >>> > alternative approach might be
> >>> >
> >>> > deactivate:
> >>> >   - stop ceph-osd service if needed
> >>> >   - remove 'ready', 'active', and INIT-specific files (to Wido's point)
> >>> >   - umount device and remove mount point
> >>>
> >>> Good point.  It would be a very nice result if activate/deactivate
> >>> were reversible by each other.  perhaps that should be the guiding
> >>> principle, with any additional steps pushed off to other commands,
> >>> such as destroy...
> >>>
> >>> >
> >>> > destroy:
> >>> >   - remove OSD from CRUSH map
> >>> >   - remove OSD cephx key
> >>> >   - deallocate OSD ID
> >>> >   - destroy data
> >>>
> >>> I like this demarcation between deactivate and destroy.
> >>>
> >>> >
> >>> > It's not quite true that the OSD ID should be preserved if the data
> >>> > is, but I don't think there is harm in associating the two...
> >>>
> >>> What if we make destroy data optional by using the --zap flag?  Or,
> >>> since zap is just removing the partition table, do we want to add more
> >>> of a "secure erase" feature?  Almost seems like that is difficult
> >>> precedent.  There are so many ways of trying to "securely" erase data
> >>> out there that that may be best left to the policies of the cluster
> >>> administrator(s).  In that case, --zap would still be a good middle
> >>> ground, but you should do more if you want to be extra secure.
> >>
> >> Sounds good to me!
> >>
> >>> One other question -- should we be doing anything with the journals?
> >>
> >> I think destroy should clear the partition type so that it can be reused
> >> by another OSD.  That will need to be tested, though.. I forget how smart
> >> the "find a journal partiiton" code is (it might blindly try to create a
> >> new one or something).
> >>
> >> sage
> >>
> >>
> >>
> >>>
> >>> >
> >>> > sage
> >>> >
> >>> >
> >>> >
> >>> >>
> >>> >> destroy:
> >>> >>  - zap disk (removes partition table and disk content)
> >>> >>
> >>> >> A few questions I have from this, though.  Is this granular enough?
> >>> >> If all the steps listed above are done in deactivate, is it useful?
> >>> >> Or are there usecases we need to cover where some of those steps need
> >>> >> to be done but not all?  Deactivating in this case would be
> >>> >> permanently removing the disk from the cluster.  If you are just
> >>> >> moving a disk from one host to another, Ceph already supports that
> >>> >> with no additional steps other than stop service, move disk, start
> >>> >> service.
> >>> >>
> >>> >> Is "destroy" even necessary?  It's really just zap at that point,
> >>> >> which already exists.  It only seems necessary to me if we add extra
> >>> >> functionality, like the ability to do a wipe of some kind first.  If
> >>> >> it is just zap, you could call zap separate or with --zap as an option
> >>> >> to deactivate.
> >>> >>
> >>> >> And all of this would need to be able to fail somewhat gracefully, as
> >>> >> you would often be dealing with dead/failed disks that may not allow
> >>> >> these commands to run successfully.  That's why I'm wondering if it
> >>> >> would be best to break the steps currently in "deactivate" into two
> >>> >> commands -- (1) deactivate: which would deal with commands specific to
> >>> >> the disk (osd out, stop service, remove marker files, umount) and (2)
> >>> >> remove: which would undefine the OSD within the cluster (remove from
> >>> >> CRUSH, remove cephx key, deallocate OSD ID).
> >>> >>
> >>> >> I'm mostly talking out loud here.  Looking for more ideas, input.  :)
> >>> >>
> >>> >>  - Travis
> >>> >>
> >>> >>
> >>> >> On Sun, Jan 4, 2015 at 6:07 AM, Wido den Hollander <wido@42on.com> wrote:
> >>> >> > On 01/02/2015 10:31 PM, Travis Rhoden wrote:
> >>> >> >> Hi everyone,
> >>> >> >>
> >>> >> >> There has been a long-standing request [1] to implement an OSD
> >>> >> >> "destroy" capability to ceph-deploy.  A community user has submitted a
> >>> >> >> pull request implementing this feature [2].  While the code needs a
> >>> >> >> bit of work (there are a few things to work out before it would be
> >>> >> >> ready to merge), I want to verify that the approach is sound before
> >>> >> >> diving into it.
> >>> >> >>
> >>> >> >> As it currently stands, the new feature would do allow for the following:
> >>> >> >>
> >>> >> >> ceph-deploy osd destroy <host> --osd-id <id>
> >>> >> >>
> >>> >> >> From that command, ceph-deploy would reach out to the host, do "ceph
> >>> >> >> osd out", stop the ceph-osd service for the OSD, then finish by doing
> >>> >> >> "ceph osd crush remove", "ceph auth del", and "ceph osd rm".  Finally,
> >>> >> >> it would umount the OSD, typically in /var/lib/ceph/osd/...
> >>> >> >>
> >>> >> >
> >>> >> > Prior to the unmount, shouldn't it also clean up the 'ready' file to
> >>> >> > prevent the OSD from starting after a reboot?
> >>> >> >
> >>> >> > Although it's key has been removed from the cluster it shouldn't matter
> >>> >> > that much, but it seems a bit cleaner.
> >>> >> >
> >>> >> > It could even be more destructive, that if you pass --zap-disk to it, it
> >>> >> > also runs wipefs or something to clean the whole disk.
> >>> >> >
> >>> >> >>
> >>> >> >> Does this high-level approach seem sane?  Anything that is missing
> >>> >> >> when trying to remove an OSD?
> >>> >> >>
> >>> >> >>
> >>> >> >> There are a few specifics to the current PR that jump out to me as
> >>> >> >> things to address.  The format of the command is a bit rough, as other
> >>> >> >> "ceph-deploy osd" commands take a list of [host[:disk[:journal]]] args
> >>> >> >> to specify a bunch of disks/osds to act on at one.  But this command
> >>> >> >> only allows one at a time, by virtue of the --osd-id argument.  We
> >>> >> >> could try to accept [host:disk] and look up the OSD ID from that, or
> >>> >> >> potentially take [host:ID] as input.
> >>> >> >>
> >>> >> >> Additionally, what should be done with the OSD's journal during the
> >>> >> >> destroy process?  Should it be left untouched?
> >>> >> >>
> >>> >> >> Should there be any additional barriers to performing such a
> >>> >> >> destructive command?  User confirmation?
> >>> >> >>
> >>> >> >>
> >>> >> >>  - Travis
> >>> >> >>
> >>> >> >> [1] http://tracker.ceph.com/issues/3480
> >>> >> >> [2] https://github.com/ceph/ceph-deploy/pull/254
> >>> >> >> --
> >>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> >> >> the body of a message to majordomo@vger.kernel.org
> >>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> >> >>
> >>> >> >
> >>> >> >
> >>> >> > --
> >>> >> > Wido den Hollander
> >>> >> > 42on B.V.
> >>> >> > Ceph trainer and consultant
> >>> >> >
> >>> >> > Phone: +31 (0)20 700 9902
> >>> >> > Skype: contact42on
> >>> >> --
> >>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> >> the body of a message to majordomo@vger.kernel.org
> >>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> >>
> >>> >>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
