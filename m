From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 3 Mar 2015 18:56:29 -0500 (EST)
Message-ID: <1016533327.32032554.1425426989540.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1503031512270.25972@cobra.newdream.net> <54F64382.7060308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52229 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbbCCX4a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 18:56:30 -0500
In-Reply-To: <54F64382.7060308@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

Ken

PLs se http://tracker.ceph.com/issues/10641 for more details

Thx
YuriW

----- Original Message -----
From: "Ken Dreyer" <kdreyer@redhat.com>
To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com
Sent: Tuesday, March 3, 2015 3:28:02 PM
Subject: Re: v0.80.8 and librbd performance

On 03/03/2015 04:19 PM, Sage Weil wrote:
> Hi,
> 
> This is just a heads up that we've identified a performance regression in 
> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way 
> through QA and should be out in a few days.  If you haven't upgraded yet 
> you may want to wait.
> 
> Thanks!
> sage

Hi Sage,

I've seen a couple Redmine tickets on this (eg
http://tracker.ceph.com/issues/9854 ,
http://tracker.ceph.com/issues/10956). It's not totally clear to me
which of the 70+ unreleased commits on the firefly branch fix this
librbd issue.  Is it only the three commits in
https://github.com/ceph/ceph/pull/3410 , or are there more?

- Ken
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
