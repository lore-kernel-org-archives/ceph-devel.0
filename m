From: Sage Weil <sage@newdream.net>
Subject: Re: defaults paths
Date: Thu, 5 Apr 2012 08:17:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204050812040.2059@cobra.newdream.net>
References: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net>
 <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be>
 <CABYiri_sVOpvbZnJ7rEBsrtDtW+qzo-vSyVLZjEa9gcv8j-+hA@mail.gmail.com>
 <51BE8674-B8FE-41D0-B284-6D99669CD4CA@openminds.be>
 <CABYiri9reZTxDTAchovCyuBT6x1OiZYgB72qj=YpzpnMD+WqJw@mail.gmail.com>
 <ACF4E321-F922-41A1-B4EE-A5DD7238F7CA@openminds.be> <4F7D913C.9030508@widodh.nl>
 <AD2AC4FF-7BAF-46F3-951D-708B9AFDBEE2@openminds.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34351 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab2DEPSC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 11:18:02 -0400
In-Reply-To: <AD2AC4FF-7BAF-46F3-951D-708B9AFDBEE2@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Thu, 5 Apr 2012, Bernard Grymonpon wrote:
> On 05 Apr 2012, at 14:34, Wido den Hollander wrote:
> 
> > On 04/05/2012 10:38 AM, Bernard Grymonpon wrote:
> >> I assume most OSD nodes will normally run a single OSD, so this would not apply to most nodes.
> >> 
> >> Only in specific cases (where multiple OSDs run on a single node) this would come up, and these specific cases might even require to have the journals split over multiple devices (multiple ssd-disks ...)
> > 
> > I think that's a wrong assumption. On most systems I think multiple OSDs will exist, it's debatable if one would run OSDs from different clusters very often.
> 
> If it is recommended setup to have multiple OSDs per node (like, one OSD 
> per physical drive), then we need to take that in account - but don't 
> assume that one node only has one SSD disk for journals, which would be 
> shared between all OSDs...
> 
> > 
> > I'm currently using: osd data = /var/lib/ceph/$name
> > 
> > To get back to what sage mentioned, why add the "-data" suffix to a directory name? Isn't it obvious that a directory will contain data?
> 
> Each osd has data and a journal... there should be some way to identify 
> both...

Yes.  The plan is for the chef/juju/whatever bits to that part.  For 
example, the scripts triggered by udev/chef/juju would look at the GPT 
labesl to identify OSD disks and mount them in place.  It will similarly 
identify journals by matching the osd uuids and start up the daemon with 
the correct journal.

The current plan is that if /var/lib/ceph/osd-data/$id/journal doesn't 
exist (e.g., because we put it on another device), it will look/wait until 
a journal appears.  If it is present, ceph-osd can start using that.

> > /var/lib/ceph/$type/$id

I like this.  We were originally thinking

 /var/lib/ceph/osd-data/
 /var/lib/ceph/osd-journal/
 /var/lib/ceph/mon-data/

but managing bind mounts or symlinks for journals seems error prone.  TV's 
now thinking we should just start ceph-osd with

  ceph-osd --osd-journal /somewhere/else -i $id

from upstart/whatever if we have a matching journal elsewhere.

sage



> > 
> > Wido
> > 
> >> 
> >> In my case, this doesn't really matter, it is up to the provision software to make the needed symlinks/mounts.
> >> 
> >> Rgds,
> >> Bernard
> >> 
> >> On 05 Apr 2012, at 09:37, Andrey Korolyov wrote:
> >> 
> >>> In ceph case, such layout breakage may be necessary in almost all
> >>> installations(except testing), comparing to almost all general-purpose
> >>> server software which need division like that only in very specific
> >>> setups.
> >>> 
> >>> On Thu, Apr 5, 2012 at 11:28 AM, Bernard Grymonpon<bernard@openminds.be>  wrote:
> >>>> I feel it's up to the sysadmin to mount / symlink the correct storage devices on the correct paths - ceph should not be concerned that some volumes might need to sit together.
> >>>> 
> >>>> Rgds,
> >>>> Bernard
> >>>> 
> >>>> On 05 Apr 2012, at 09:12, Andrey Korolyov wrote:
> >>>> 
> >>>>> Right, but probably we need journal separation at the directory level
> >>>>> by default, because there is a very small amount of cases when speed
> >>>>> of main storage is sufficient for journal or when resulting speed
> >>>>> decrease is not significant, so journal by default may go into
> >>>>> /var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
> >>>>> the fast disk.
> >>>>> 
> >>>>> On Thu, Apr 5, 2012 at 10:57 AM, Bernard Grymonpon<bernard@openminds.be>  wrote:
> >>>>>> 
> >>>>>> On 05 Apr 2012, at 08:32, Sage Weil wrote:
> >>>>>> 
> >>>>>>> We want to standardize the locations for ceph data directories, configs,
> >>>>>>> etc.  We'd also like to allow a single host to run OSDs that participate
> >>>>>>> in multiple ceph clusters.  We'd like easy to deal with names (i.e., avoid
> >>>>>>> UUIDs if we can).
> >>>>>>> 
> >>>>>>> The metavariables are:
> >>>>>>> cluster = ceph (by default)
> >>>>>>> type = osd, mon, mds
> >>>>>>> id = 1, foo,
> >>>>>>> name = $type.$id = osd.0, mds.a, etc.
> >>>>>>> 
> >>>>>>> The $cluster variable will come from the command line (--cluster foo) or,
> >>>>>>> in the case of a udev hotplug tool or something, matching the uuid on the
> >>>>>>> device with the 'fsid =<uuid>' line in the available config files found
> >>>>>>> in /etc/ceph.
> >>>>>>> 
> >>>>>>> The locations could be:
> >>>>>>> 
> >>>>>>> ceph config file:
> >>>>>>>  /etc/ceph/$cluster.conf     (default is thus ceph.conf)
> >>>>>>> 
> >>>>>>> keyring:
> >>>>>>>  /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)
> >>>>>>> 
> >>>>>>> osd_data, mon_data:
> >>>>>>>  /var/lib/ceph/$cluster.$name
> >>>>>>>  /var/lib/ceph/$cluster/$name
> >>>>>>>  /var/lib/ceph/data/$cluster.$name
> >>>>>>>  /var/lib/ceph/$type-data/$cluster-$id
> >>>>>>> 
> >>>>>>> TV and I talked about this today, and one thing we want is for items of a
> >>>>>>> given type to live together in separate directory so that we don't have to
> >>>>>>> do any filtering to, say, get all osd data directories.  This suggests the
> >>>>>>> last option (/var/lib/ceph/osd-data/ceph-1,
> >>>>>>> /var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.
> >>>>>>> 
> >>>>>>> Another option would be to make it
> >>>>>>> 
> >>>>>>> /var/lib/ceph/$type-data/$id
> >>>>>>> 
> >>>>>>> (with no $cluster) and make users override the default with something that
> >>>>>>> includes $cluster (or $fsid, or whatever) in their $cluster.conf if/when
> >>>>>>> they want multicluster nodes that don't interfere.  Then we'd get
> >>>>>>> /var/lib/ceph/osd-data/1 for non-crazy people, which is pretty easy.
> >>>>>> 
> >>>>>> As a osd consists of data and the journal, it should stay together, with all info for that one osd in one place:
> >>>>>> 
> >>>>>> I would suggest
> >>>>>> 
> >>>>>> /var/lib/ceph/osd/$id/data
> >>>>>> and
> >>>>>> /var/lib/ceph/osd/$id/journal
> >>>>>> 
> >>>>>> ($id could be replaced by $uuid or $name, for which I would prefer $uuid)
> >>>>>> 
> >>>>>> Rgds,
> >>>>>> Bernard
> >>>>>> 
> >>>>>>> 
> >>>>>>> Any other suggestions?  Thoughts?
> >>>>>>> sage
> >>>>>>> --
> >>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>>> 
> >>>>>> 
> >>>>>> --
> >>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>> 
> >>>> 
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> 
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
