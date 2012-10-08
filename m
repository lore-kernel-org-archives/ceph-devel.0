From: Sage Weil <sage@inktank.com>
Subject: Re: Problem with "ceph osd create <uuid>"
Date: Mon, 8 Oct 2012 11:34:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210081133460.9864@cobra.newdream.net>
References: <CA+jddaOBZ2cm-R2uQnOCa_yMN+2DDOMAZMB6uNMo4XwFUfYouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47088 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab2JHSeb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Oct 2012 14:34:31 -0400
In-Reply-To: <CA+jddaOBZ2cm-R2uQnOCa_yMN+2DDOMAZMB6uNMo4XwFUfYouw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Hi Mandell,

On Mon, 8 Oct 2012, Mandell Degerness wrote:
> Hi list,
> 
> I've run into a bit of a weird error and I'm hoping that you can tell
> me what is going wrong.  There seems to be a race condition in the way
> I am using "ceph osd create <uuid>" and actually creating the OSD's.
> The log from one of the servers is at:
> 
> https://gist.github.com/528e347a5c0ffeb30abd
> 
> The process I am trying to follow (for the OSDs) is:
> 
> 1) Create XFS file system on disk.
> 2) Use FS UUID as source to get a new OSD id #.
> 'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
> (Returns 2.)
> 3) Pass the UUID and OSD id to the create osd command
> 
> ceph-osd -c /etc/ceph/ceph.conf --fsid
> e61c1b11-4a1c-47aa-868d-7b51b1e610d3 --osd-uuid
> 32895846-ca1c-4265-9ce7-9f2a42b41672 -i 2 --mkfs --osd-journal-size
> 8192
> 4) Start the OSD, as part of the start process, I verify that the
> whoami and osd fsid agree (in case this disk came from a previous
> cluster, somehow) - should be just a sanity check
> 'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
> (Returns 1!)
> 
> This is clearly a race condition because we have several cluster
> creations without this happening and then this happens about once
> every 8 times or so.  Thoughts?

That definitely sounds like a race.  I'm not seeing it by inspection, 
though, and wasn't able to reproduce.  Is it possible to capture a monitor 
log (debug ms = 1, debug mon = 20) of this occurring and share that?

Thanks!
sage
