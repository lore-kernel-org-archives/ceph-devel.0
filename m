From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 21:15:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org>
 <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43471 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbD0EPf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 00:15:35 -0400
In-Reply-To: <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Alex Elder <elder@ieee.org>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 26 Apr 2015, Douglas Fuller wrote:
> >> I?d really like a solution to this, but I don?t think one is
> >> available given the constraints.
> > 
> > Now that I know I understand it, I will at least provide
> > some review comments on the patches.  I'll also think about
> > it a little.  My instinct says there should be no need to
> > make the copies, but the devil will be in the details.
> 
> Yeah, it seems like it should be simpler. To fix it, I think we would have to either commit a layering violation (decode the call ops? response sizes in the message receive flow) or change the interface to osd_client (don?t provide preallocated pagevecs for call response data even though that?s what?s done for other types of ops). I?m the new guy, though, so it?s certainly possible I?m missing something.
> 
> >> I was told that the preferred way to proceed for now was to avoid
> >> changing the osd_client interface and to handle this case in
> >> osd_client instead of the messaging layer. Given those constraints,
> >> it was agreed in the standups and on #ceph-devel that it should be
> >> done this way.
> > 
> > Sorry, I haven't been keeping up with all the activity on the
> > mailing list.  I pay closest attention to patches to the kernel
> > code.
> 
> Well, this was worked out mainly in the standups and on IRC. There wasn?t a mailing list discussion on it. Having said that, the attention to the patch is certainly appreciated.

Two basic approaches come to mind:

1) add an up-call between the front and data portions.  Right now we have 
a get_reply between header and front that is used to get the buffers for 
front (and data).  We could add a second that comes after front to prepare 
the data buffers.  This would basically change teh sequence from

 - read header
 - get/allocate ceph_msg, along with front, middle, and data buffers
 - read front, middle, data
 - dispatch message
    - decode
    - process

to

 - read header
 - get/allocate ceph_msg, along with front, maybe middle, and data buffers
 - read front, middle
 - call get_data hook
    - decode front, prepare/allocate data buffers
 - read data
 - dispatch message
    - process

I think that's a viable approach, but it means a fair bit of refactoring 
to separate the decoding from the processing (at least for 
osd_reply)--right now those two steps are combined in all of the 
handle_* functions.

2) Introduce a protocol change so that the section boundaries are 
described in a generic way.  Even more work!

Given the only uesrs we have in mind have very small data payloads, 
copying seems simplest to me, but it's up to you guys.  Maybe there is 
something much simpler I'm missing?  Somehow we have to do the front 
parsing before reading data... and probably we want to avoid parsing it 
twice...

sage
