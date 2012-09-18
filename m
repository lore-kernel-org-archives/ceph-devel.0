From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 09:35:02 -0700
Message-ID: <CANLRBozeRL5v+6RK3PDnxpqRLeCSLL3udhxq=WVB8sd7r9n0Og@mail.gmail.com>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
	<5057BAD0.8080201@smart-weblications.de>
	<CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com>
	<alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53943 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab2IRQfE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 12:35:04 -0400
Received: by vcbfo13 with SMTP id fo13so55295vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 09:35:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: f.wiessner@smart-weblications.de, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 17, 2012 at 7:32 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 17 Sep 2012, Tren Blackburn wrote:
>> On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
>> Wiessner <f.wiessner@smart-weblications.de> wrote:
>> >
>> > Hi,
>> >
>> > i use ceph to provide storage via rbd for our virtualization cluster delivering
>> > KVM based high availability Virtual Machines to my customers. I also use it
>> > as rbd device with ocfs2 on top of it for a 4 node webserver cluster as shared
>> > storage - i do this, because unfortunatelly cephfs is not ready yet ;)
>> >
>> Hi Florian;
>>
>> When you say "cephfs is not ready yet", what parts about it are not
>> ready? There are vague rumblings about that in general, but I'd love
>> to see specific issues. I understand multiple *active* mds's are not
>> supported, but what other issues are you aware of?
>
> Inktank is not yet supporting it because we do not have the QA in place
> and general hardening that will make us feel comfortable recommending it
> for customers.  That said, it works pretty well for most workloads.  In
> particular, if you stay away from the snapshots and multi-mds, you should
> be quite stable.
With regards to the multi-mds, is that multi-active mds? I have 3
mds's built, and only 1 active. The others are incase there's a
failure. Does that scenario work?

>
> The engineering team here is about to do a bit of a pivot and refocus on
> the file system now that the object store and RBD are in pretty good
> shape.  That will mean both core fs/mds stability and features as well as
> integration efforts (NFS/CIFS/Hadoop).
That's awesome news. The file system component is very important to me.

>
> 'Ready' is in the eye of the beholder.  There are a few people using the
> fs successfully in production, but not too many.
I'll keep you up to date as our testing builds out! I'm in the process
of building out a new test cluster.

t.
