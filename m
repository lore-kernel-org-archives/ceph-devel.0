From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: BUG: problem when removing / creating rbd image (format v2)
Date: Sat, 03 Nov 2012 09:18:45 -0700
Message-ID: <fdab665c0c79278012d1e8642a584a86@hq.newdream.net>
References: <5094F19E.7010401@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ps79606.dreamhost.com ([66.33.206.83]:35928 "EHLO
	webmail.hq.newdream.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756820Ab2KCQSq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 12:18:46 -0400
In-Reply-To: <5094F19E.7010401@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 2012-11-03 03:27, Stefan Priebe wrote:
> Hello list,
>
> [systemI: ~]# rbd -p kvmstor rm vm-113-disk-1
> 2012-11-03 11:25:43.520833 7fb191d71760 -1 librbd::ImageCtx: error
> finding header: (2) No such file or directory
> Removing image: 0% complete...failed.
> rbd: delete error: (2) No such file or directory
> 2012-11-03 11:25:43.531708 7fb191d71760 -1 librbd: error removing img
> from new-style directory: (2) No such file or directory
>
> [systemI: ~]# rbd create -p kvmstor --format 2 --size 32000
> --stripe-count 4 --stripe-unit 1048576 -s 4194304 kvm-113-disk-1
> rbd: create error: (17) File exists
> 2012-11-03 11:25:41.017364 7fae8b832760 -1 librbd: rbd image
> kvm-113-disk-1 already exists

   ^ this k wasn't in your other commands. Is this a copy-paste error
or a typo?

> [systemI: ~]# rbd -p kvmstor rm vm-113-disk-1
> 2012-11-03 11:26:55.552217 7f1349114760 -1 librbd::ImageCtx: error
> finding header: (2) No such file or directory
> 2012-11-03 11:26:55.564664 7f1349114760 -1 librbd: error removing img
> from new-style directory: (2) No such file or directory
> Removing image: 0% complete...failed.
> rbd: delete error: (2) No such file or directory
>
> There seems to be a bug ;-)
>
> Stefan

