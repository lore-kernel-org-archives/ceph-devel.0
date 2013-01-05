From: Sage Weil <sage@inktank.com>
Subject: Re: ceph caps (Ganesha + Ceph pnfs)
Date: Sat, 5 Jan 2013 08:36:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301050829030.15430@cobra.newdream.net>
References: <849744156.177.1357347094206.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45055 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab3AEQgU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 11:36:20 -0500
In-Reply-To: <849744156.177.1357347094206.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

Hi Matt,

I have a few higher-level questions first to make sure I understand what 
you're targetting.

It sounds like the DS agents/targets are also using the libcephfs 
interfaces to do IO... is that right?  Does that mean you're using the 
'file' driver, and the DS pNFS requests are directed at files?  If that is 
the case, the 'lazy' option for IO may be closer to what you want here.

More generally, if you are not tied to using an existing client layout 
type, I still struggle to understand but it means to 'commit' an layout in 
a Ceph context.  From the (ceph) client perspective, the layout of a 
file's data is fixed: it is a sequence of objects like $inode.$block.  
Which servers you talk to to store those may change over time, but that is 
a matter of efficiency (contacting the optimal DS) and not correctness 
(the DS could write directly to the appropriate rados objects via 
either libcephfs or librados).

Maybe just describing what exactly is contained in the layout would help 
me understand the context.

Thanks!
sage



On Fri, 4 Jan 2013, Matt W. Benjamin wrote:
> Hi Ceph folks,
> 
> Summarizing from Ceph IRC discussion by request, I'm one of the 
> developers of a pNFS (parallel nfs) implementation that is built atop 
> the Ceph system.
> 
> I'm working on code that wants to use the Ceph caps system to control 
> and sequence i/o operations and file metadata, for example, so that 
> ordinary Ceph clients see a coherent view of the objects being exported 
> via pNFS.
> 
> The basic pNFS model (sorry for those who know all this, RFC 5661, etc) 
> is to extend NFSv4 with a distributed/parallel access model.  To do 
> parallel access in pNFS, the NFS client gets a `layout` from an NFS 
> metadata (MDS) server.  A layout is a recallable object, a bit like an 
> oplock/delegation/DCE token, see spec, it basically presents a list of 
> subordinate data servers (DSes) on which to read and/or write regions of 
> a specific file.
> 
> Ok, so in our implementation, we would typically expect to have a DS 
> server collocated with each Ceph OSD.  When an NFS client has a layout 
> on a given inode, its i/o requests will be performed "directly" by the 
> appropriate OSD.  When an MDS is asked to issue a layout on a file, it 
> should hold a cap or caps which ensure the layout will not conflict with 
> other Ceph clients and ensure the MDS will be notified when it must 
> recall the layout later if other clients attempt conflicting operations.  
> In turn, involved DS servers need the correct caps to read and/or write 
> the data, plus, they need to update file metadata periodically.  (This 
> can be upon a final commit of the client's layout, or inline with a 
> write operation, if the client specifies the write be 'sync' stability.)
> 
> The current set of behaviors we're modeling are:
> 
> a) allow MDS to hold a Ceph caps, tracking issued pNFS layouts, such 
> that it will be able to handle events which should trigger layout 
> recalls at its pNFS clients (e.g., on conflicts)--currently we it holds 
> CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD
> 
> b) on a given DS, we currently get CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD 
> caps when asked to perform i/o on behalf of a valid layout--but we need 
> to update metadata (size, mtime) and my question in IRC was cross 
> checking these capabilities as correct to send an update message
> 
> In the current pass I'm trying to clean up/refine the model 
> implementation, leaving some room for adjustment.
> 
> Thanks!
> 
> Matt
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
