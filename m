From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph for email storage
Date: Wed, 4 Jul 2012 12:10:48 -0700
Message-ID: <4CBADE42F9654101B57D0AAC18FD9795@inktank.com>
References: <4FF48B9C.3010803@webcenter.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34788 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab2GDTKq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 15:10:46 -0400
Received: by ghrr11 with SMTP id r11so6749337ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 12:10:46 -0700 (PDT)
In-Reply-To: <4FF48B9C.3010803@webcenter.com.br>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mitsue Acosta Murakami <mitsue@webcenter.com.br>
Cc: ceph-devel@vger.kernel.org

On Wednesday, July 4, 2012 at 11:29 AM, Mitsue Acosta Murakami wrote:
> Hello,
> 
> We are examining Ceph to use as email storage. In our current system, 
> several clients servers with different services (imap, smtp, etc) access 
> a NFS storage server. The mailboxes are stored in Maildir format, with 
> many small files. We use Amazon AWS EC2 for clients and storage server. 
> In this scenario, we have some questions about Ceph:
> 
> 1. Is Ceph recommended for heavy write/read of small files?
> 
> 2. Is there any problem in installing Ceph on Amazon instances?
> 
> 3. Does Ceph already support quota?
> 
> 4. What File System would you encourage us to use?
Are you interested in using RBD to back your mail servers, or in using the Ceph FS to provide shared storage? Ceph FS isn't considered production-ready at this time, but RBD should be, for appropriate use cases.

In general:
1) If you allow your caching layers to do their job, any Ceph system should handle small writes fine. Reads will require normal disk accesses.
2) There shouldn't be.
3) None of the Ceph systems support quotas right now, although CephFS does easy usage reports.
4) Assuming you mean for the OSDs, XFS seems to be your best bet right now, but we work to make Ceph perform as well as possible under btrfs and ext4 too.
-Greg


