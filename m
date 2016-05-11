From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [ceph-users] Hammer vs Jewel librbd performance testing and git
 bisection results
Date: Wed, 11 May 2016 10:19:09 -0400
Message-ID: <CA+aFP1DRcM5AwKpo6sU_14-YA764e9ZOHq=qtJWYkFN983O+kQ@mail.gmail.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
	<CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
	<bcf1b2db-b7c7-7ffe-1970-7469f7ff7cb4@redhat.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33154 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbcEKOTK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 10:19:10 -0400
Received: by mail-pa0-f54.google.com with SMTP id xk12so18470371pac.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 07:19:10 -0700 (PDT)
In-Reply-To: <bcf1b2db-b7c7-7ffe-1970-7469f7ff7cb4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "cbt@lists.ceph.com" <cbt@lists.ceph.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Wed, May 11, 2016 at 10:07 AM, Mark Nelson <mnelson@redhat.com> wrote:
> Perhaps 0024677 or 3ad19ae introduced another regression that was being
> masked by c474e4 and when 66e7464 improved the situation, the other
> regression appeared?

0024677 is in Hammer as 7004149 and 3ad19ae is in Hammer as b38da480.
I opened two tickets [1] [2] to investigate further.  Can you attach
the fio job you used?

[1] http://tracker.ceph.com/issues/15847
[2] http://tracker.ceph.com/issues/15848

Thanks,

-- 
Jason
