From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Firefly v0.80.10 backports (rgw)
Date: Mon, 16 Mar 2015 17:47:54 -0400 (EDT)
Message-ID: <788437467.22080577.1426542474307.JavaMail.zimbra@redhat.com>
References: <55074AE9.8080008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:35642 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbCPVs5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 17:48:57 -0400
In-Reply-To: <55074AE9.8080008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Monday, March 16, 2015 2:28:09 PM
> Subject: Firefly v0.80.10 backports (rgw)
> 
> Hi Yehuda,
> 
> A few issues related to rgw were backported to firefly[1]. They passed the
> rgw suite[2]. Could you please take a look ?
> 
> Cheers
> 
> [1]
> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Afirefly+sort%3Aupdated-desc+label%3Argw
> [2] http://tracker.ceph.com/issues/11090#rgw
> 
> 

It all looks fine. There are a couple of fixes that went in that are more features than bug fixes. They're pretty limited in scope, but the changes are bigger than the usual trivial changes that go into firefly.
There's also another issue that I think we'll need to see going in: 11125. I just sent a pull request for master on it today, and it applies cleanly to firefly.

Yehuda
