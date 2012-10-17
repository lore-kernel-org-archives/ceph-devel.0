From: Sage Weil <sage@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Wed, 17 Oct 2012 12:53:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210171242510.5342@cobra.newdream.net>
References: <1161967657.118.1350502807306.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40611 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab2JQTxT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 15:53:19 -0400
In-Reply-To: <1161967657.118.1350502807306.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <casey@linuxbox.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, aemerson <aemerson@linuxbox.com>, peter honeyman <peter.honeyman@gmail.com>

On Wed, 17 Oct 2012, Casey Bodley wrote:
> To expand on what Matt said, we're also trying to address this issue of 
> lookups by inode number for use with NFS.
> 
> The design we've been exploring is to create a single system inode, 
> designated the 'inode container' directory, which stores the primary 
> links to all inodes in the filesystem. These links are named by their 
> inode number to satisfy lookups and obviate the need for an anchor 
> table. This design allows the inode container to make use of existing 
> directory fragmentation and load balancing to distribute the inodes over 
> the MDS cluster.
> 
> When a new file is created, it then adds two links: a primary link into 
> the inode container, and a remote link into the filesystem namespace. In 
> the case where the parent directory fragment's authority is different 
> than the corresponding inode container fragment's, it is created in the 
> parent directory then exported to the inode container via an 
> asynchronous slave request.
> 
> We welcome additional discussion, both on this design specifically and 
> on the general topic of scalable ino lookups.

This would certainly work.  It essentially gives up on the idea of 
embedding inodes in directories, however, and the performance advantages 
that offers in the common case, because every file has to be resolved via 
the inode directory.  I also suspect that if that is the end goal, we 
could get there more easily without grafting it onto directory fragments.

My hope is that these backpointers on file data objects will satisfy our 
need to look up by ino in the rare case where it's necessary, while 
avoiding the overhead with an inode table and the second lookup for each 
file in the general case.

Do you see issues or pitfalls with that approach, given your experience 
with the NFS ESTALE stuff so far?

sage



> 
> Casey
> 
> ----- Original Message -----
> From: "Matt W. Benjamin" <matt@linuxbox.com>
> To: "Sage Weil" <sage@inktank.com>
> Cc: ceph-devel@vger.kernel.org, "aemerson" <aemerson@linuxbox.com>, "casey" <casey@linuxbox.com>, "peter honeyman" <peter.honeyman@gmail.com>
> Sent: Tuesday, October 16, 2012 5:35:12 PM
> Subject: Re: parent xattrs on file objects
> 
> Hi Sage,
> 
> We've been exploring (experimentally implementing) a different solution to this problem, basically refactoring dirents and inodes, extending fragmentation logic, and adding new metadata location operations.  We also remove the anchor table.  We were planning to ask for some feedback once we had some initial results, but since you're floating a related idea, we'd like to share what we have so far.  CC'ing people.
> 
> Regards,
> 
> Matt
> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > Hey-
> > 
> > One of the design goals of the ceph fs was to keep metadata separate
> > from 
> > data.  This means, among other things, that when a client is creating
> > a 
> > bunch of files, it creates the inode via the mds and writes the file
> > data 
> > to the OSD, but no mds->osd interaction is necessary.
> > 
> > One of the challenges we currently have is that it is difficult to
> > lookup 
> > an inode by ino.  Normally clients traverse the hierarchy to get
> > there, so 
> > things are fine for native ceph clients, but when reexporting via NFS
> > we 
> > can get ESTALE because we an ancient nfs file handle can be presented
> > and 
> > the ceph MDS won't know where to find it.  We have a similar problem
> > with 
> > the fsck design in that it is not always possible to discover orphaned
> > 
> > children of directory that was somehow lost.
> > 
> > One option is to put an ancestor xattr on the first object for each
> > file, 
> > similar to what we do for directories.  This basically means that each
> > 
> > file creation will be followed (eventually) by a setxattr osd
> > operation.  
> > This used to scare me, but now it's seeming like a pretty small price
> > to 
> > pay for robust NFS reexport and additional information for fsck to 
> > utilize.
> > 
> > It's also nice because it means we could get rid of the anchor table
> > (used 
> > for locating files with multiple hard links) entirely and use the 
> > ancestore xattrs instead.  That means one less thing to fsck, and
> > avoids 
> > having to invest any time in making the anchor table effectively scale
> > (it 
> > currently doesn't).
> > 
> > Anyone feel like we shouldn't go ahead and do this?
> > 
> > sage
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
