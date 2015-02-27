From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: [Manila] Ceph native driver for manila
Date: Fri, 27 Feb 2015 20:26:28 +1100
Message-ID: <CA+z5DswY2pB8cr-82yWVmP2DfMXMANokhvLJY2wTLyFxDQPjeA@mail.gmail.com>
References: <alpine.DEB.2.00.1502261520050.23918@cobra.newdream.net>
 <CACJqLyZfTL9c38Eiuxr7JRsfTE4biHay1mVOEfVvDD8po54JYA@mail.gmail.com> <alpine.DEB.2.00.1502262102040.14643@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:38438 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbB0J0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 04:26:50 -0500
Received: by lbiz11 with SMTP id z11so16101476lbi.5
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 01:26:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502262102040.14643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I like #4, but I'm not clear about the impact of the different
security models. Using "mapped" covers file-sharing inside the cloud,
but seems to have a gap for accessing the same share externally due to
the use of xattrs for permissions etc. Though perhaps the standard
kernel client could be made to recognise these?
#3 would be great, along with the necessary isolation bits in CephFS.
#2 seems acceptable assuming one could scale-out the Ganesha
CephFS-NFS servers, which avoids the problems of #1, which sucks. :-)

On 27 February 2015 at 16:19, Sage Weil <sweil@redhat.com> wrote:
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
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
