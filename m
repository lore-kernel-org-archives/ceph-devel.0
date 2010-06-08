From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 08 Jun 2010 14:04:07 +0200
Message-ID: <4C0E31B7.4010606@wpkg.org>
References: <4C0E1BAC.8070306@wpkg.org> <1275994413.1933.1.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:55152 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab0FHMEM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jun 2010 08:04:12 -0400
In-Reply-To: <1275994413.1933.1.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wido@pcextreme.nl
Cc: ceph-devel@vger.kernel.org

Am 08.06.2010 12:53, Wido den Hollander wrote:
> Hi,
>
> I'm not aware of any of those features in Ceph and i don't think that it
> will be possible in the near future.
>
> But while thinking about it, is ZFS an option for you? You could then
> use a lot of SATA disks and add some SAS disks for your caching. ZFS
> will then place the most used blocks on the SAS disks.

Not sure, perhaps not.

I was thinking of something in the line of:

http://en.wikipedia.org/wiki/Hierarchical_storage_management


-- 
Tomasz Chmielewski
http://wpkg.org
