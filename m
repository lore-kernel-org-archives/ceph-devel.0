From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore assert
Date: Thu, 11 Aug 2016 11:34:19 -0500
Message-ID: <7dc67e25-4e1c-09a1-8667-ee47572b9290@redhat.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>
 <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932301AbcHKQeW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 12:34:22 -0400
In-Reply-To: <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry if I missed this during discussion, but why are these being called 
if the file is deleted?

Mark

On 08/11/2016 11:29 AM, Sage Weil wrote:
> On Thu, 11 Aug 2016, Somnath Roy wrote:
>> Sage,
>> Please find the full log for the BlueFS replay bug in the following location.
>>
>> https://github.com/somnathr/ceph/blob/master/ceph-osd.1.log.zip
>>
>> For the db transaction one , I have added code to dump the rocksdb error code before the assert as you suggested and waiting to reproduce.
>
> I'm pretty sure this is the root cause:
>
> 	https://github.com/ceph/ceph/pull/10686
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
