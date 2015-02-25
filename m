From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 15:31:58 -0800
Message-ID: <CACkq2mqf-aBBOuWwDVhXU4U1tsQdqLLQqr5Yxet9T=YdJXYHXw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45572 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbbBYXcT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:32:19 -0500
Received: by lbjb6 with SMTP id b6so7315032lbj.12
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 15:32:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

<sorry to sage and somnath for double-post -- ceph-devel got me with
plain text again.  :) >

On Debian/Ubuntu, the uninstall/purge will remove the following packages:

ceph
ceph-mds
ceph-common
ceph-fs-common.

Ironically, ceph-deploy will spit out on the CLI that it does *not*
remove librados2 and librbd1, because yes that would break
qemu/libvirt.  The intent is to leave those libraries.

I wonder if something has changed along these lies.  those libraries
should have stayed on the host.

So I am curious what ceph-deploy command you actually ran.
ceph-deploy should not be able to uninstall librados2 or librbd1, but
you mentioned that you purged them.  How?  Was it through ceph-deploy?

On Wed, Feb 25, 2015 at 3:21 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 25 Feb 2015, Somnath Roy wrote:
>> Hi,
>> We are facing problem that ceph-deploy purge is uninstalling latest Mellanox ofed driver packages.
>> Digging down more we found libvirt-bin is dependent on librados2/librbd1.
>> So, here is what happening.
>>
>> 1. Mellanox ofed driver has a dependency on the libvirt-bin*
>>
>> 2. purging librados2/librbd1 is removing libvirt-bin and resulting the removal of the Mellanox driver package as well.
>>
>> Here is what I found.
>>
>> http://packages.ubuntu.com/trusty/devel/libvirt-bin
>>
>> ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2
>> [...]
>
> The problem is that libvirt (and probably qemu) are built against librbd1.
> If you remove librbd1, those get removed too.
>
>> So, I am curious why libvirt-bin has a depencey on librados2/librbd1 ?
>
> qemu needs it for obvious reasons.  libvirt needs it to manage it's
> (rbd) storage pools.
>
>> Also, how come we get rid of this issue ?
>> Ceph-deploy should not remove any package other than ceph's.
>
> Purge could skip the libraries that may have other dependencies, but then
> it's a purge-lite.  Honestly I thought it skipped them for that reason but
> we probably changed it at some point because it (also confusingly)
> wouldn't remove librados etc...
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
