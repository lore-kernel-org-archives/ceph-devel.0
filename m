From: Mark Nelson <mnelson@redhat.com>
Subject: Re: ceph-osd: microbenchmark for 4k read operations
Date: Wed, 27 May 2015 09:03:18 -0500
Message-ID: <5565CEA6.8090903@redhat.com>
References: <20150520181339.0a630c07@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59440 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbE0ODY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 May 2015 10:03:24 -0400
In-Reply-To: <20150520181339.0a630c07@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/20/2015 11:13 AM, Andreas Bluemle wrote:
> Hi,
>
> as discussed on todays performance meeting: find attached the
> spreadsheet which I had shown during the meeting.
>
> @Sam: your are right concerning the make_blist part: this
> probably is expensive due to message signing being turned on.
> For the osd daemon which I took the benchmarks, I see
>      "cephx_sign_messages": "true"
>
>
> Regards
>
> Andreas
>

Thank you Andreas!  Looking forward to hearing how much 
cephx_sign_messages is affecting things.

Mark
