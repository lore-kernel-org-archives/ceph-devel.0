From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 08 May 2015 09:07:27 -0700
Message-ID: <554CDF3F.7020703@redhat.com>
References: <554C7CE5.4070600@dachary.org> <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com> <554CC970.3040701@dachary.org> <209815215.14051495.1431097392961.JavaMail.zimbra@redhat.com> <554CD2A0.3040101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbbEHQIW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 May 2015 12:08:22 -0400
In-Reply-To: <554CD2A0.3040101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/08/2015 08:13 AM, Loic Dachary wrote:
>
>
> On 08/05/2015 17:03, Jason Dillaman wrote:
>> Since it sounds like the next hammer release is more or less ready, my vote would be that the fix can wait until the next release.  Since it will only occur if the new exclusive lock feature is enabled (disabled on images by default) and the connection between librbd and the OSD is reset with writeback data waiting in the cache, it sounds like a rare enough issue.
>>
>> Final decision rests w/ Josh.
>
> Ok :-) Would you be so kind as to point me to the corresponding issue in the tracker for reference ?

I agree with Jason, this doesn't need to block the release. I think the
issue he refers to is the last sentence in 
http://tracker.ceph.com/issues/11537

Josh
