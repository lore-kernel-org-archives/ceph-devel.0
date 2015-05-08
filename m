From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 8 May 2015 12:57:01 -0400 (EDT)
Message-ID: <1915251220.16254469.1431104221321.JavaMail.zimbra@redhat.com>
References: <554C7CE5.4070600@dachary.org> <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com> <554CC970.3040701@dachary.org> <209815215.14051495.1431097392961.JavaMail.zimbra@redhat.com> <554CD2A0.3040101@dachary.org> <554CDF3F.7020703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40000 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbbEHQ6E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 12:58:04 -0400
In-Reply-To: <554CDF3F.7020703@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

In what suite(s) do we anticipate failures for next week hammer QE validation?

Thx
YuriW

----- Original Message -----
From: "Josh Durgin" <jdurgin@redhat.com>
To: "Loic Dachary" <loic@dachary.org>, "Jason Dillaman" <dillaman@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Friday, May 8, 2015 9:07:27 AM
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
