From: Peter Smith <peterfruits@gmail.com>
Subject: Re: Understanding Ceph
Date: Sun, 20 Jan 2013 01:25:15 +0800
Message-ID: <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
	<50FAC92C.8030709@bmrb.wisc.edu>
	<alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f193.google.com ([209.85.210.193]:61710 "EHLO
	mail-ia0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3ASRZR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 12:25:17 -0500
Received: by mail-ia0-f193.google.com with SMTP id k27so531798iad.8
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 09:25:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, ceph-devel@vger.kernel.org

Thanks for the reply, Sage and everyone.

Sage, so I can expect Ceph-rbd works well on Centos 6.3 if I only use
it as the Cinder volume backend because the librbd in QEMU doesn't
make use of kernel client, right?

Could you explain a bit more about what are the functions of kernel
client? Will it influence the daily operations, such as listing
volumes, devices by using ceph commands?






On Sun, Jan 20, 2013 at 1:13 AM, Sage Weil <sage@inktank.com> wrote:
> On Sat, 19 Jan 2013, Dimitri Maziuk wrote:
>> On 1/19/2013 9:50 AM, Peter Smith wrote:
>>
>> > 3. OS recommendation: The OS recommendation page:
>> > http://ceph.com/docs/master/install/os-recommendations/#bobtail-0-56
>> > says CentOS 6.3 has a default kernel with old kernel client. CentOS
>> > 6.3 is our production environment.
>>
>> I was unable to get ceph to run on centos 6.3 following the "5 minute quick
>> start" document. I did get one machine to "unclean" cluster state using
>> elrepo's kernel 3.7, but that kernel doesn't boot on most of our boxen
>> (boot-time oops in pata-acpi).
>>
>> It looks to me that unless inktank backports rbd.ko to 2.6.32, centos/sl users
>> won't be able to test ceph for a couple of years: until centos 7.1 comes out
>> and we get the chance to reimage our hardware.
>
> If you want to use the kernel client(s), that is true: there are no plans
> to backport the client code to the ancient RHEL kernels.  Nothing prevents
> you from running the server side, though, or the userland clients
> (ceph-fuse, librbd, qemu/KVM, radosgw, etc.)
>
> sage
