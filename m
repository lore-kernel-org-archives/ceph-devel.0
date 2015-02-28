From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next firefly release
Date: Sat, 28 Feb 2015 11:55:42 -0500 (EST)
Message-ID: <1610756257.12816609.1425142542413.JavaMail.zimbra@redhat.com>
References: <54F19BF7.6030808@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34931 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbbB1Q4r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 11:56:47 -0500
In-Reply-To: <54F19BF7.6030808@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 28, 2015 2:44:07 AM
> Subject: rgw and the next firefly release
> 
> Hi Yehuda,
> 
> The rados teuthology suite for the next firefly release as found in
> https://github.com/ceph/ceph/commits/firefly-backports came back green
> http://pulpito.ceph.com/loic-2015-02-27_18:04:18-rgw-firefly-backports---basic-multi/.
> Do you think it is ready for QE to start their own round of testing ?
> 
> Cheers

I think the following issues need to get in:
 - 10978 (fix still hasn't made it upstream, current commit: b6e43e30b39aed701bb4cdfaa0f6b27c1f207d86)
 - 10965 (fix still hasn't made it upstream, current commits: f28fe744285117a1715eac0d08911cdb37285103, caa90225bad9fe5e9c275e6189b3396b4d396e3f)
 - 10907 (commit: 986d7554426764a149621ba733c5c075b94e0431)


I prepared the top two branches, need to do a sanity check on them first, then I'll send a pull request to master. I think 10978 is critical, the bottom two are important for civetweb and less risky.

Yehuda
