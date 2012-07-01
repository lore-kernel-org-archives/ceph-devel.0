From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Ceph and KVM live migration
Date: Sat, 30 Jun 2012 18:17:51 -0700
Message-ID: <4FEFA53F.4020503@inktank.com>
References: <4FEF9CF1.6030008@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36092 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2GABRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jun 2012 21:17:52 -0400
Received: by obbuo13 with SMTP id uo13so5893428obb.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jun 2012 18:17:52 -0700 (PDT)
In-Reply-To: <4FEF9CF1.6030008@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 06/30/2012 05:42 PM, Vladimir Bashkirtsev wrote:
> Dear all,
>
> Currently I testing KVMs running on ceph and particularly testing recent
> cache feature. Performance is of course vastly improved but still have
> occasional KVM hold ups - not sure who is at blame ceph of KVM. But I
> will deal with it later. Right now I've got myself a question which I
> could not get answered myself: if I do live migration of KVM while there
> some uncommitted data in ceph cache will this cache be committed prior
> cut-over to another host? Reading through the list I've got an
> impression that it may be left uncommitted and thus it may cause data
> corruption. I just would like a simple confirmation if code which
> commits cache on cut-over to new host does exist and no data corruption
> due to RBD cache+live migration should happen.
>
> Regards,
> Vladimir

QEMU does a flush on all the disks when it stops the guest on the
original host, so there will be no uncommitted data in the cache.

Josh
