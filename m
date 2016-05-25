From: Sage Weil <sage@newdream.net>
Subject: Re: boost::container::static_vector
Date: Wed, 25 May 2016 12:14:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605251128080.14180@cpach.fuggernut.com>
References: <1185676289.39418531.1464189847415.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52596 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbcEYQOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 12:14:16 -0400
In-Reply-To: <1185676289.39418531.1464189847415.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 25 May 2016, Matt Benjamin wrote:
> Hi Radek (CC's),
> 
> It seems that static_vector isn't on the boost on RHEL/Centos 7;  I'm 
> not sure if small_vector is;  I think we were approaching consensus on 
> solving this... I'll revisit this in #ceph-devel and on standup.

We most recently tabled the boost question until the cmake transition was 
done so that we can ignore any automake-related complexity.  I still think 
that will save us some time/effort...

sage
