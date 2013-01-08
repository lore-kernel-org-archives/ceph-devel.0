From: Sage Weil <sage@inktank.com>
Subject: Re: ceph caps (Ganesha + Ceph pnfs)
Date: Mon, 7 Jan 2013 16:23:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301071537140.4728@cobra.newdream.net>
References: <1424966577.14.1357406987759.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43033 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab3AHAXr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 19:23:47 -0500
In-Reply-To: <1424966577.14.1357406987759.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

On Sat, 5 Jan 2013, Matt W. Benjamin wrote:
> Hi SAge,
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > Hi Matt,
> > 
> > I have a few higher-level questions first to make sure I understand
> > what 
> > you're targetting.
> > 
> > It sounds like the DS agents/targets are also using the libcephfs 
> > interfaces to do IO... is that right?  Does that mean you're using the
> > 
> > 'file' driver, and the DS pNFS requests are directed at files?  If
> > that is 
> > the case, the 'lazy' option for IO may be closer to what you want
> > here.
> 
> We're using those interfaces currently, with currently small changes.  
> IIUC, IO_LAZY or some specialization of it might be correct for some 
> usage, but not all, depending on desired semantics?

Yeah.. I think it's close, but not exactly right. 

> > 
> > More generally, if you are not tied to using an existing client layout
> > 
> > type, I still struggle to understand but it means to 'commit' an
> > layout in 
> > a Ceph context.  From the (ceph) client perspective, the layout of a 
> > file's data is fixed: it is a sequence of objects like $inode.$block. 
> > 
> > Which servers you talk to to store those may change over time, but
> > that is 
> > a matter of efficiency (contacting the optimal DS) and not correctness
> > 
> > (the DS could write directly to the appropriate rados objects via 
> > either libcephfs or librados).
> 
> We currently use Ceph file layout, yes, and relative to our integration 
> with Ceph, it's felt like a good fit so far.
> 
> Sadly, LAYOUT is now a piece of pNFS terminology, and I meant committing 
> -that-. Basically, the LAYOUT is a kind of abstract object that has 
> operations GET, RETURN, RECALL, COMMIT. 

So for all intents and purposes, LAYOUT just means a capability or 
permission to write.  And the content, since it's a standard file layout, 
is the name of the DS (ip address or something?) and an fh to use on that 
DS?

> The current spec defines just a 
> kind of layout that describes how to do parallel access on a file.  A 
> pnfs layout structure has a few subtypes which, somewhat messily, are 
> quite different, but a typical implementation would only do one.  We do 
> the 'files' layout described in RFC 5661.  You get a pnfs layout on a 
> specific inode in a file system, on a range of the file.  Currently, the 
> Linux client in the files layout style will only deal correctly with a 
> layout on the whole file, but that's slated to be fixed, so think of it 
> as being on a range of the file.  The layout then carries sufficient 
> info on the real location of data in the range so as to map regular 
> subranges of the original range to one (sometimes more) 
> "devices"--another abstraction--which basically can be looked up to 
> resolve a mapping to a DS.
>
> So yes, we defer to Ceph to decide where blocks are or will be placed.  
> But presume further there is a DS instance anywhere there is a Ceph OSD 
> instance.  Call this DS -the- DS associated with $inode.$block. Today, 
> the prototype basically uses libcephfs to perform i/o through an MDS, 
> and librados when performing i/o at a DS.  (In fact, since libcephfs 
> necessarily uses librados, we're using the lower level path but both MDS 
> and DS are library clients of libcephs).

Your prevoius question made it sound like the DS was interacting with 
libcephfs and dealing with (some) MDS capabilities.  Is that right?

I wonder if a much simpler approach would be to make a different fh format 
or type, and just cram the inode and ceph object/block number in there.  
Then the DS can just go direct to rados and avoid interacting with the fs 
at all.  There are some additional semantics surrounding the truncate 
metadata, but if we're lucky that can fit inside the fh, and the DS 
servers could really just act like object targets--no libcephfs or MDS 
interaction at all.

Either way, to your first (original question), yes, we should expose a way 
via libcephfs to take a reference on the capability that isn't released 
until the layout is committed.  That should be pretty straightforward to 
do, I think.

Hopefully my understanding is getting closer!

:) sage

 
> Having said this, a key design goal of the DS is to take advantage of 
> the 1-1 relationship of DS to OSD, so at the level of caps/coordination, 
> when the pNFS MDS issues a layout, what we intend is that the mapping of 
> $inode.$block is stable for the duration of the layout (until 
> returned/recalled), and hence client and DS may both safely rely on 
> this.  Plus, of course, other Ceph clients see a sane view of the 
> affected objects at any point in this process.


> 
> Matt
> 
> > 
> > Maybe just describing what exactly is contained in the layout would
> > help 
> > me understand the context.
> > 
> > Thanks!
> > sage
> > 
> > 
> > 
> > On Fri, 4 Jan 2013, Matt W. Benjamin wrote:
> > > Hi Ceph folks,
> > > 
> > > Summarizing from Ceph IRC discussion by request, I'm one of the 
> > > developers of a pNFS (parallel nfs) implementation that is built
> > atop 
> > > the Ceph system.
> > > 
> > > I'm working on code that wants to use the Ceph caps system to
> > control 
> > > and sequence i/o operations and file metadata, for example, so that
> > 
> > > ordinary Ceph clients see a coherent view of the objects being
> > exported 
> > > via pNFS.
> > > 
> > > The basic pNFS model (sorry for those who know all this, RFC 5661,
> > etc) 
> > > is to extend NFSv4 with a distributed/parallel access model.  To do
> > 
> > > parallel access in pNFS, the NFS client gets a `layout` from an NFS
> > 
> > > metadata (MDS) server.  A layout is a recallable object, a bit like
> > an 
> > > oplock/delegation/DCE token, see spec, it basically presents a list
> > of 
> > > subordinate data servers (DSes) on which to read and/or write
> > regions of 
> > > a specific file.
> > > 
> > > Ok, so in our implementation, we would typically expect to have a DS
> > 
> > > server collocated with each Ceph OSD.  When an NFS client has a
> > layout 
> > > on a given inode, its i/o requests will be performed "directly" by
> > the 
> > > appropriate OSD.  When an MDS is asked to issue a layout on a file,
> > it 
> > > should hold a cap or caps which ensure the layout will not conflict
> > with 
> > > other Ceph clients and ensure the MDS will be notified when it must
> > 
> > > recall the layout later if other clients attempt conflicting
> > operations.  
> > > In turn, involved DS servers need the correct caps to read and/or
> > write 
> > > the data, plus, they need to update file metadata periodically. 
> > (This 
> > > can be upon a final commit of the client's layout, or inline with a
> > 
> > > write operation, if the client specifies the write be 'sync'
> > stability.)
> > > 
> > > The current set of behaviors we're modeling are:
> > > 
> > > a) allow MDS to hold a Ceph caps, tracking issued pNFS layouts, such
> > 
> > > that it will be able to handle events which should trigger layout 
> > > recalls at its pNFS clients (e.g., on conflicts)--currently we it
> > holds 
> > > CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD
> > > 
> > > b) on a given DS, we currently get CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD
> > 
> > > caps when asked to perform i/o on behalf of a valid layout--but we
> > need 
> > > to update metadata (size, mtime) and my question in IRC was cross 
> > > checking these capabilities as correct to send an update message
> > > 
> > > In the current pass I'm trying to clean up/refine the model 
> > > implementation, leaving some room for adjustment.
> > > 
> > > Thanks!
> > > 
> > > Matt
> > > 
> > > -- 
> > > Matt Benjamin
> > > The Linux Box
> > > 206 South Fifth Ave. Suite 150
> > > Ann Arbor, MI  48104
> > > 
> > > http://linuxbox.com
> > > 
> > > tel. 734-761-4689
> > > fax. 734-769-8938
> > > cel. 734-216-5309
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel. 734-761-4689
> fax. 734-769-8938
> cel. 734-216-5309
> 
> 
