From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: rbd and the next firefly release
Date: Sat, 28 Feb 2015 19:16:56 -0500 (EST)
Message-ID: <1434104180.13097157.1425169016883.JavaMail.zimbra@redhat.com>
References: <54F24F94.2020402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45235 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbbCAASA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 19:18:00 -0500
In-Reply-To: <54F24F94.2020402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Josh Durgin" <jdurgin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 28, 2015 3:30:28 PM
> Subject: rbd and the next firefly release
> 
> Hi Josh,
> 
> The rbd teuthology suite for the next firefly release as found in
> https://github.com/ceph/ceph/commits/firefly-backports is green. The details
> of the run is at http://tracker.ceph.com/issues/10641#rbd. Note that today's
> run were to repeat the jobs that failed because of environmental problems
> (i.e. problems that were fixed by fixing the test suite itself, not by
> adding a patch to Ceph). Do you think it is ready for QE to start their own
> round of testing ?

Looks ready to me!

Josh
