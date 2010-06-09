From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Wed, 09 Jun 2010 16:55:34 +0200
Message-ID: <4C0FAB66.6030003@wpkg.org>
References: <4C0E1BAC.8070306@wpkg.org> <Pine.LNX.4.64.1006081047120.15202@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:36054 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755892Ab0FIOzn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Jun 2010 10:55:43 -0400
In-Reply-To: <Pine.LNX.4.64.1006081047120.15202@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Am 08.06.2010 19:51, Sage Weil wrote:
> On Tue, 8 Jun 2010, Tomasz Chmielewski wrote:
>> I'd like to build a cluster for storing large amounts of data.
>>
>> The cluster would consist of slow (cheap) storage and fast (expensive)
>> storage.
>>
>> I would like to migrate data from fast (expensive) storage to slow (cheap)
>> storage if it wasn't accessed for, say, 6 months.
>>
>> Would ceph somehow help me achieve that?
>
> We don't currently have that functionality.  In principle it's certainly
> something the system could do, and the underlying storage architecture
> lends itself to that:

Hmm, since quite recently, Linux kernel has FS-Cache, which:

	This facility is a general purpose cache for network
	filesystems, though it could be used for caching other things
	such as ISO9660 filesystems too.


I wonder if it could work with ceph and/or traditional filesystems, too?


-- 
Tomasz Chmielewski
http://wpkg.org
