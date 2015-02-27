From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Manila] Ceph native driver for manila
Date: Fri, 27 Feb 2015 13:31:26 +0800
Message-ID: <CACJqLyawH41nvSVM5tL3dbktkGi4adYmdsswTf3hmnxR3tDpiQ@mail.gmail.com>
References: <alpine.DEB.2.00.1502261520050.23918@cobra.newdream.net>
	<CACJqLyZfTL9c38Eiuxr7JRsfTE4biHay1mVOEfVvDD8po54JYA@mail.gmail.com>
	<alpine.DEB.2.00.1502262102040.14643@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40322 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbbB0Fb1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 00:31:27 -0500
Received: by paceu11 with SMTP id eu11so19912724pac.7
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 21:31:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502262102040.14643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 27, 2015 at 1:19 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 27 Feb 2015, Haomai Wang wrote:
>> > Anyway, this leads to a few questions:
>> >
>> >  - Who is interested in using Manila to attach CephFS to guest VMs?
>>
>> Yeah, actually we are doing this
>> (https://www.openstack.org/vote-vancouver/Presentation/best-practice-of-ceph-in-public-cloud-cinder-manila-and-trove-all-with-one-ceph-storage).
>>
>> Hmm, the link seemed redirect and useless:-(
>>
>> >  - What use cases are you interested?
>>
>> We uses Manila + OpenStack for our NAS service
>>
>> >  - How important is security in your environment?
>>
>> Very important, we need to provide with qos, network isolation(private
>> network support).
>>
>> Now we use default Manila driver, attach a rbd image to service vm and
>> this service vm export NFS endpoint.
>>
>> Next as we showed in the presentation, we will use qemu driver to
>> directly passthrough filesystem command instead of block command. So
>> host can directly access cephfs safely and network isolation can be
>> ensured. It will make clearly for internal network(or storage network)
>> and virtual network.
>
> Is this using the qemu virtfs/9p server and 9p in the guest?  With a
> cephfs kernel mount on the host?  How reliable have you found it to be?
>
> That brings us to 4 options:
>
> 1) default driver: map rbd to manila VM, export NFS
> 2) ganesha driver: reexport cephfs as NFS
> 3) native ceph driver: let guest mount cephfs directly
> 4) mount cephfs on host, guest access via virtfs
>
> I think in all but #3 you get decent security isolation between tenants as
> long as you trust KVM and/or ganesha to enforce permissions.  In #3 we
> need to enforce that in CephFS (and have some work to do).
>
> I like #3 because it promises the best performance and shines the light on
> the multitenancy gaps we have now, and I have this feeling that
> multitenant security isn't a huge issue for a lot of users, but.. that's
> why I'm asking!

FOR us, the #3's main problem is that guest vm need to access ceph cluster
via *virtual network*. With private network supported, in theory guest vm can't
access internal network especially storage network. Maybe we can make
manila service vm special and let it passthrough via NET or others. But it still
has network impaction which may influent the IO performance.

Actually, #4 may got better performance because it passthrough io via qemu
queue ring and #3 need to translate guest vm network bandwidth from virtual
network to internal network.

Of course, maybe other users don't need to consider this case :-)

>
> sage



-- 
Best Regards,

Wheat
