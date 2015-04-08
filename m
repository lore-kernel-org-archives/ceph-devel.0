From: Sage Weil <sage@newdream.net>
Subject: Re: Call for jenkins slaves to improve multi operating system
 support
Date: Wed, 8 Apr 2015 09:59:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504080957210.4469@cobra.newdream.net>
References: <55250954.1010305@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39975 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbbDHQ7A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 12:59:00 -0400
In-Reply-To: <55250954.1010305@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 8 Apr 2015, Loic Dachary wrote:
> Hi Ceph,
> 
> When a contribution is proposed to Ceph [1], a bot compiles and run 
> tests with it to provide feedback to the developer [2]. When something 
> goes wrong the failure can be repeated on the developer machine [3] for 
> debug. This also helps the reviewer who knows the code compiles and does 
> not break anything that would be detected by "make check".
> 
> The bot runs on CentOS 7 and Ubuntu 14.04 only, and problems related to 
> older operating systems (headers, compiler version, etc.) may be 
> detected later, when building packages [4] and after the pull request 
> has been merged in master. This is rare but requires extra attention 
> from the reviewer and needs to be dealt with urgently when it happens.

Do additional slaves block the message from appearing on the pull 
request?  I.e., what happens if a slave is very slow (e.g., armv7) or 
broken (network issue)?

What are the connectivity requirements?  Can slaves exist on other 
(private) networks?

Thanks!
sage
