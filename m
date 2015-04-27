From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 23:40:14 -0500
Message-ID: <553DBDAE.7080603@ieee.org>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org> <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com> <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net> <DAE9CF5D-1D64-4A73-9469-DA2EDC00F69D@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34050 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbD0EkU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 00:40:20 -0400
Received: by pacyx8 with SMTP id yx8so116344620pac.1
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 21:40:19 -0700 (PDT)
In-Reply-To: <DAE9CF5D-1D64-4A73-9469-DA2EDC00F69D@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 04/26/2015 11:35 PM, Douglas Fuller wrote:
> This solution just feels hacky and inefficient, so I think there is a
> desire to feel like we at least tried to come up something simpler
> and more efficient before proceeding.

Right.  And somehow more fitting with the existing code, if
that's possible.  There are a few things in this proposal
that are just special case code, and it would be nice to
avoid that.

I'm sorry I've been too busy today to get back to this.  I spent
a lot of time on Saturday getting ramped back up on this code
so I could provide a decent review...

I'm going to at least look at the code (error on a read op)
before going to bed, so I at least know what the problem is.
I'll try to have something to say (even if it's "I've got
nothing") in the next day or two.

					-Alex
