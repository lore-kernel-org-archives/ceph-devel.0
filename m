From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next dumpling release
Date: Thu, 5 Feb 2015 17:59:14 -0500 (EST)
Message-ID: <974116011.8222626.1423177154743.JavaMail.zimbra@redhat.com>
References: <54D3F0E5.8060906@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56084 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbBEXAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 18:00:18 -0500
In-Reply-To: <54D3F0E5.8060906@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Thursday, February 5, 2015 2:38:29 PM
> Subject: rgw and the next dumpling release
> 
> Hi Yehuda,
> 
> The rados teuthology suite for the next dumpling release as found in
> https://github.com/ceph/ceph/commits/dumpling-backports came back green
> http://pulpito.ceph.com/loic-2015-02-03_14:46:09-rgw-dumpling-backports---basic-multi/.
> Do you think it is ready for QE to start their own round of testing ?
> 

We should also backport a9dd4af401328e8f9071dee52470a0685ceb296b to dumpling. I think I saw a dumpling run failing due to the lack of this one, and since we now run on environments that use apache 2.4. Looking at this commit, it's not going to be applied trivially, so I'm preparing one for dumpling now.

Yehuda
