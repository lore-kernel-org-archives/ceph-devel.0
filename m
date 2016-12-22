From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Clone data inconsistency in hammer
Date: Thu, 22 Dec 2016 13:21:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612221319400.10615@piezo.novalocal>
References: <20161221125712.7074b217@desk613732.desk.int.gns.ovh.net>
	<CA+aFP1Dx9mzYmtNNqTUifpT2JGMsDKECLt69mZBmerm+a=db5A@mail.gmail.com>
	<20161222101009.32e14565@desk613732.desk.int.gns.ovh.net>
	<20161222133341.0f4a3976@desk613732.desk.int.gns.ovh.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2115469208-1482412907=:10615"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20161222133341.0f4a3976-Q8zpDM2kqfNz3UrvHfEF4cXErentcBXJSavXxUIaH7I@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-2?Q?Bart=B3omiej_=A6wi=EAcki?= <bartlomiej.swiecki-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2115469208-1482412907=:10615
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Dec 2016, Bartłomiej Święcki wrote:
> Hi,
> 
> I have problems runnign Kraken tools on Hammer/Jewel cluster (official 11.1.0 debs),
> it asserts:
> 
> /build/ceph-11.1.0/src/mon/MonMap.cc: In function 'void MonMap::sanitize_mons(std::map<std::basic_string<char>, entity_addr_t>&)' thread 7fffd37fe700 time 2016-12-22 12:26:23.457058
> /build/ceph-11.1.0/src/mon/MonMap.cc: 70: FAILED assert(mon_info.count(p.first))

See http://tracker.ceph.com/issues/18265 and 
https://github.com/ceph/ceph/pull/12611

sage


> I tried to debug it a bit and it looks like mon_info has temporary mon names:
> 
> (gdb) p mon_info
> $1 = std::map with 3 elements = {["noname-a"] = {name = "noname-a", .....
> 
> while it checks for a correct one:
> 
> (gdb) p p
> $2 = {first = "mon-01-690d38c0-2567-447b-bdfb-0edd137183db", ....
> 
> 
> Anyway, I was thinking about the missing image problem - maybe it would be easier
> to recreate removed image? Would restoring rbd_header object be enough?
> 
> 
> P.S. Adding ceph-devel
> 
> On Thu, 22 Dec 2016 10:10:09 +0100
> Bartłomiej Święcki <bartlomiej.swiecki-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org> wrote:
> 
> > Hi Jason,
> > 
> > I'll test kraken tools since it happened on production, everything works there
> > since the clone is flattened after being created and the production equivalent
> > of "test" user can access the image only after it has been flattened.
> > 
> > The issue happened when someone accidentally removed not-yet-flattened image
> > using the user with weaker permissions. Good to hear this has been spotted
> > already.
> > 
> > Thanks for help,
> > Bartek
> > 
> > 
> > 
> > On Wed, 21 Dec 2016 11:53:57 -0500
> > Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > 
> > > You are unfortunately the second person today to hit an issue where
> > > "rbd remove" incorrectly proceeds when it hits a corner-case error.
> > > 
> > > First things first, when you configure your new user, you needed to
> > > give it "rx" permissions to the parent image's pool. If you attempted
> > > the clone operation using the "test" user, the clone would have
> > > immediately failed due to this issue.
> > > 
> > > Second, unless this is a test cluster where you can delete the
> > > "rbd_children" object in the "rbd" pool (i.e. you don't have any
> > > additional clones in the rbd pool) via the rados CLI, you will need to
> > > use the Kraken release candidate (or master branch) version of the
> > > rados CLI to manually manipulate the "rbd_children" object to remove
> > > the dangling reference to the deleted image.
> > > 
> > > On Wed, Dec 21, 2016 at 6:57 AM, Bartłomiej Święcki
> > > <bartlomiej.swiecki-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org> wrote:
> > > > Hi,
> > > >
> > > > I'm currently investigating a case where Ceph cluster ended up with inconsistent clone information.
> > > >
> > > > Here's a what I did to quickly reproduce:
> > > > * Created new cluster (tested in hammer 0.94.6 and jewel 10.2.3)
> > > > * Created two pools: test and rbd
> > > > * Created base image in pool test, created snapshot, protected it and created clone of this snapshot in pool rbd:
> > > >         # rbd -p test create --size 10 --image-format 2 base
> > > >         # rbd -p test snap create base@base
> > > >         # rbd -p test snap protect base@base
> > > >         # rbd clone test/base@base rbd/destination
> > > > * Created new user called "test" with rwx permissions to rbd pool only:
> > > >         caps: [mon] allow r
> > > >         caps: [osd] allow class-read object_prefix rbd_children, allow rwx pool=rbd
> > > > * Using this newly creted user I removed the cloned image in rbd pool, had errors but finally removed the image:
> > > >         # rbd --id test -p rbd rm destination
> > > >         2016-12-21 11:50:03.758221 7f32b7459700 -1 librbd::image::OpenRequest: failed to retreive name: (1) Operation not permitted
> > > >         2016-12-21 11:50:03.758288 7f32b6c58700 -1 librbd::image::RefreshParentRequest: failed to open parent image: (1) Operation not permitted
> > > >         2016-12-21 11:50:03.758312 7f32b6c58700 -1 librbd::image::RefreshRequest: failed to refresh parent image: (1) Operation not permitted
> > > >         2016-12-21 11:50:03.758333 7f32b6c58700 -1 librbd::image::OpenRequest: failed to refresh image: (1) Operation not permitted
> > > >         2016-12-21 11:50:03.759366 7f32b6c58700 -1 librbd::ImageState: failed to open image: (1) Operation not permitted
> > > >         Removing image: 100% complete...done.
> > > >
> > > > At this point there's no cloned image but the original snapshot still has reference to it:
> > > >
> > > > # rbd -p test snap unprotect base@base
> > > > 2016-12-21 11:53:47.359060 7fee037fe700 -1 librbd::SnapshotUnprotectRequest: cannot unprotect: at least 1 child(ren) [29b0238e1f29] in pool 'rbd'
> > > > 2016-12-21 11:53:47.359678 7fee037fe700 -1 librbd::SnapshotUnprotectRequest: encountered error: (16) Device or resource busy
> > > > 2016-12-21 11:53:47.359691 7fee037fe700 -1 librbd::SnapshotUnprotectRequest: 0x7fee39ae9340 should_complete_error: ret_val=-16
> > > > 2016-12-21 11:53:47.360627 7fee037fe700 -1 librbd::SnapshotUnprotectRequest: 0x7fee39ae9340 should_complete_error: ret_val=-16
> > > > rbd: unprotecting snap failed: (16) Device or resource busy
> > > >
> > > > # rbd -p test children base@base
> > > > rbd: listing children failed: (2) No such file or directory2016-12-21
> > > > 11:53:08.716987 7ff2b2eaad80 -1 librbd: Error looking up name for image
> > > > id 29b0238e1f29 in pool rbd
> > > >
> > > >
> > > > Any ideas on how this could be fixed?
> > > >
> > > >
> > > > Thanks,
> > > > Bartek
> > > > _______________________________________________
> > > > ceph-users mailing list
> > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > 
> > > 
> > > 
> > > -- 
> > > Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-2115469208-1482412907=:10615
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-2115469208-1482412907=:10615--
