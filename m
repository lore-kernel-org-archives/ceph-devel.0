From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: dedupe and compression in ceph
Date: Fri, 18 Feb 2011 09:29:02 -0800
Message-ID: <230A55CC1BE841CCB6DE1BD9DFB367CD@gmail.com>
References: <AANLkTinTbdiV56oYWf7CL7dr6xLSYG==01TDRvqDgrux@mail.gmail.com>
 <AANLkTimQcd9ViH=r9jxu_zCNQH_RJvGd2uef3BubEinN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54051 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab1BRR33 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 12:29:29 -0500
Received: by ywo7 with SMTP id 7so1691002ywo.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 09:29:29 -0800 (PST)
In-Reply-To: <AANLkTimQcd9ViH=r9jxu_zCNQH_RJvGd2uef3BubEinN@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kiran Patil <kirantpatil@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Friday, February 18, 2011 at 5:30 AM, Kiran Patil wrote:
Hello,
> 
> May I know when would it be possible to use the underlying btrfs
> features such as dedupe(offline) and compression for ceph cosds ?
> 
> Is it possible to access btrfs features in cosd seamlessly ?
Well, there are two ways to run Ceph on btrfs. One is to give it a raw partition and tell it to set up the partition itself. I'm not sure how difficult it would be to enable these features under that situation, although I think it would be pretty simple. 
The other way is to just create a btrfs filesystem and point the OSD at a directory on that filesystem as its backend storage. In that scenario you can set whatever mount options etc that you like. I'm not personally that familiar with btrfs but I imagine this should let you enable whatever options you like. :)

-Greg 
