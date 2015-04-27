From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Mon, 27 Apr 2015 00:35:18 -0400 (EDT)
Message-ID: <DAE9CF5D-1D64-4A73-9469-DA2EDC00F69D@redhat.com>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org> <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com> <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53219 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbD0EfW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 00:35:22 -0400
In-Reply-To: <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alex Elder <elder@ieee.org>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>





> On Apr 27, 2015, at 12:15 AM, Sage Weil <sage@newdream.net> wrote:
> 
> Two basic approaches come to mind:
> 
> 1) add an up-call between the front and data portions.  Right now we have 
> a get_reply between header and front that is used to get the buffers for 
> front (and data).  We could add a second that comes after front to prepare 
> the data buffers.  This would basically change teh sequence from
> 
> - read header
> - get/allocate ceph_msg, along with front, middle, and data buffers
> - read front, middle, data
> - dispatch message
>    - decode
>    - process
> 
> to
> 
> - read header
> - get/allocate ceph_msg, along with front, maybe middle, and data buffers
> - read front, middle
> - call get_data hook
>    - decode front, prepare/allocate data buffers
> - read data
> - dispatch message
>    - process
> 
> I think that's a viable approach, but it means a fair bit of refactoring 
> to separate the decoding from the processing (at least for 
> osd_reply)--right now those two steps are combined in all of the 
> handle_* functions.

In the kernel client, the data buffers are allocated before the message is even sent. The messaging code reads the reply data directly into those preallocated buffers. If we add a call up to decode the message size and allocate the data buffers when we process the reply, we have to change the osd_client interface.

> 2) Introduce a protocol change so that the section boundaries are 
> described in a generic way.  Even more work!

We could also pad the relevant op replies so that each has a fixed length. It would be a protocol change, but a smaller one, I assume.

> Given the only uesrs we have in mind have very small data payloads, 
> copying seems simplest to me, but it's up to you guys.  Maybe there is 
> something much simpler I'm missing?  Somehow we have to do the front 
> parsing before reading data... and probably we want to avoid parsing it 
> twice...


This solution just feels hacky and inefficient, so I think there is a desire to feel like we at least tried to come up something simpler and more efficient before proceeding.

-Doug