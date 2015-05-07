From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Thu, 07 May 2015 10:28:58 -0500
Message-ID: <554B84BA.9000501@ieee.org>
References: <cover.1429881439.git.dfuller@redhat.com> <553C85D6.3010407@ieee.org> <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com> <CD78243E-DADC-49D1-A23F-4E4880045A30@redhat.com> <553CF887.6000803@ieee.org> <E52372BD-69F7-4D41-B9AF-BEEBFE2FF9B0@redhat.com> <alpine.DEB.2.00.1504262110090.5458@cobra.newdream.net> <DAE9CF5D-1D64-4A73-9469-DA2EDC00F69D@redhat.com> <553DBDAE.7080603@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38141 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbEGP3B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 11:29:01 -0400
Received: by igbhj9 with SMTP id hj9so48643461igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 08:29:01 -0700 (PDT)
In-Reply-To: <553DBDAE.7080603@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 04/26/2015 11:40 PM, Alex Elder wrote:
> On 04/26/2015 11:35 PM, Douglas Fuller wrote:
>> This solution just feels hacky and inefficient, so I think there is a
>> desire to feel like we at least tried to come up something simpler
>> and more efficient before proceeding.
> 
> Right.  And somehow more fitting with the existing code, if
> that's possible.  There are a few things in this proposal
> that are just special case code, and it would be nice to
> avoid that.
> 
> I'm sorry I've been too busy today to get back to this.  I spent
> a lot of time on Saturday getting ramped back up on this code
> so I could provide a decent review...
> 
> I'm going to at least look at the code (error on a read op)
> before going to bed, so I at least know what the problem is.
> I'll try to have something to say (even if it's "I've got
> nothing") in the next day or two.
> 
>                     -Alex

It's been a week and a half since I sent this.  I don't
expect to be able to contribute anything for at least a
few more days.

If adding this functionality is something you need quickly,
I don't want you to be waiting for me.

If you can wait, I will gladly review it and offer my
suggestions for a better way (if I can think of one...).

But if not, you should just proceed with what you have
if it solves the problem.

I just don't want to keep you waiting.

					-Alex
