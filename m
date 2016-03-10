From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 2/2] ceph osd: add support for new op cmpext
Date: Thu, 10 Mar 2016 11:06:22 -0600
Message-ID: <56E1A98E.6030405@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
 <1457591672-17430-1-git-send-email-mchristi@redhat.com>
 <1457591672-17430-3-git-send-email-mchristi@redhat.com>
 <20160310130341.444c76af@g21.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcCJRGX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 12:06:23 -0500
In-Reply-To: <20160310130341.444c76af@g21.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org

On 03/10/2016 06:03 AM, David Disseldorp wrote:
> Hi Mike,
> 
> On Thu, 10 Mar 2016 00:34:32 -0600, Mike Christie wrote:
> 
>> This adds support for a new op cmpext. The request will read
>> extent.length bytes and compare them to extent.length bytes at
>> extent.offset on disk. If there is a miscompare the osd will return
>> -EILSEQ, and the mismatched buffer that was read.
>>
>> rbd will use this in a multi op request to implement the
>> SCSI COMPARE_AND_WRITE request which is used by VMware for
>> its atomic test and set request.
>>
>> v2:
>> - Merge David's tracing fixes.
>> - Instead of returning the mismatch offset and buffer on matching
>> failure just return the buffer. The client can figure out the offset
>> if it needs it.
> 
> What's your reason for dropping the mismatch offset?

I was not sure if anyone else was going to use it. I can add it back. It
does not matter to me.
