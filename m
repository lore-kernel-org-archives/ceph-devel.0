From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Breaks & Replaces in debian/control in backports
Date: Wed, 22 Jul 2015 10:47:43 -0600
Message-ID: <55AFC92F.60101@redhat.com>
References: <55AB89C4.50503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934322AbbGVQro (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jul 2015 12:47:44 -0400
In-Reply-To: <55AB89C4.50503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/19/2015 05:28 AM, Loic Dachary wrote:

> I think it achieves the same thing and is less error prone in the case of backports. The risk is that upgrading from v0.94.2-34 to the version with this change will fail because the conditions are satisified (it thinks all versions after v0.94.2 have the change). But the odds of having a test machine with this specific version already installed are close to non-existent. The odds of us picking the wrong number and ending up with something that's either too high or too small are higher.
> 
> What do you think ?
> 

I think this is great, thanks for proposing it. We should also write our
convention down someplace (SubmittingPatches, or the wiki, or something)

- Ken
