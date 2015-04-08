From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Tue, 07 Apr 2015 20:45:58 -0500
Message-ID: <55248856.1010808@redhat.com>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34335 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbbDHBqB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Apr 2015 21:46:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 8B59C2B9DFB
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 01:46:01 +0000 (UTC)
Received: from [10.3.112.84] (ovpn-112-84.phx2.redhat.com [10.3.112.84])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t381jwUV003526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 7 Apr 2015 21:46:00 -0400
In-Reply-To: <55242D15.8080800@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>



On 04/07/2015 02:16 PM, Mark Nelson wrote:
> On 04/07/2015 09:57 AM, Mark Nelson wrote:
>> Hi Guys,
>>
>> I ran some quick tests on Sage's newstore branch.  So far given that
>> this is a prototype, things are looking pretty good imho.  The 4MB
>> object rados bench read/write and small read performance looks
>> especially good.  Keep in mind that this is not using the SSD journals
>> in any way, so 640MB/s sequential writes is actually really good
>> compared to filestore without SSD journals.
>>
>> small write performance appears to be fairly bad, especially in the RBD
>> case where it's small writes to larger objects.  I'm going to sit down
>> and see if I can figure out what's going on.  It's bad enough that I
>> suspect there's just something odd going on.
>>
>> Mark
>
> Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for those
> interested:
>
> http://nhm.ceph.com/newstore/
>
> Interestingly small object write/read performance with 4 OSDs was about
> 1/3-1/4 the speed of the same cluster with 36 OSDs.
>
> Note: Thanks Dan for fixing the directory column width!
>
> Mark

New fio/librbd results using Sage's latest code that attempts to keep 
small overwrite extents in the db.  This is 4 OSD so not directly 
comparable to the 36 OSD tests above, but does include seekwatcher 
graphs.  Results in MB/s:

	write	read	randw	randr
4MB	57.9	319.6	55.2	285.9
128KB	2.5	230.6	2.4	125.4
4KB	0.46	55.65	1.11	3.56

Seekwatcher graphs:

http://nhm.ceph.com/newstore/20150407/

Mark
