From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Deprecating ext4 support
Date: Mon, 11 Apr 2016 16:57:16 -0500
Message-ID: <570C1DBC.3040408@redhat.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
 <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbcDKV5T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Apr 2016 17:57:19 -0400
In-Reply-To: <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

On 04/11/2016 04:44 PM, Sage Weil wrote:
> On Mon, 11 Apr 2016, Sage Weil wrote:
>> Hi,
>>
>> ext4 has never been recommended, but we did test it.  After Jewel is out,
>> we would like explicitly recommend *against* ext4 and stop testing it.
>
> I should clarify that this is a proposal and solicitation of feedback--we
> haven't made any decisions yet.  Now is the time to weigh in.

To add to this on the performance side, we stopped doing regular 
performance testing on ext4 (and btrfs) sometime back around when ICE 
was released to focus specifically on filestore behavior on xfs.  There 
were some cases at the time where ext4 was faster than xfs, but not 
consistently so.  btrfs is often quite fast on fresh fs, but degrades 
quickly due to fragmentation induced by cow with 
small-writes-to-large-object workloads (IE RBD small writes).  If btrfs 
auto-defrag is now safe to use in production it might be worth looking 
at again, but probably not ext4.

Set sail for bluestore!

Mark

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
