From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Best insertion point for storage shim
Date: Fri, 31 Aug 2012 12:08:59 -0400
Message-ID: <CADvuQRELJmUde=1jC-WS_dvp6HjL7OrdT+NmgETiyqb645hLJQ@mail.gmail.com>
References: <00b201cd8210$077de070$1679a150$@netmass.com> <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
 <002f01cd8786$31b62340$952269c0$@netmass.com> <CADvuQRFoReXqk0h2f_RpG-T9KJHV2p-7zzh4ceo6jqcC0BQDtw@mail.gmail.com>
 <038F2DC9-0576-4372-BA5C-BD5B196934A4@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36954 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab2HaQJU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:09:20 -0400
Received: by vcbfk26 with SMTP id fk26so3456395vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 09:09:20 -0700 (PDT)
In-Reply-To: <038F2DC9-0576-4372-BA5C-BD5B196934A4@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Stephen Perkins <perkins@netmass.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 31, 2012 at 11:59 AM, Atchley, Scott <atchleyes@ornl.gov> wrote:
> I think what he is looking for is not to bring data to a client to convert from replication to/from erasure coding, but to have the servers do it based on some metric _or_ have the client indicate which file needs to be converted and have the servers do the work.
>
> I believe what you are saying is that I can have a directory using the replicated pool and another directory (or sub-directory) that uses the coding pool. The client would then copy the file from one directory to the other. The question becomes "Who does the erasure encoding?". The client (read back from the replica pool and write to the erasure pool) or the servers (copy data to the erasure pool and calculate on the servers)?

I was aiming more for "I can see where this could sit in the
architecture". You don't have to make the client effectively download
and re-upload a file; that logic can be pushed closer to the OSDs.
