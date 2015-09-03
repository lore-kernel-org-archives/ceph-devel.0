From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Ceph Write Path Improvement
Date: Thu, 03 Sep 2015 11:42:10 -0500
Message-ID: <55E87862.5060809@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE354DD@SACMBXIP01.sdcorp.global.sandisk.com> <CAANLjFpmO+rGnEFM5+u6piVoa4YqvoVCcTWjYOQJ2cXEEk7T-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbbICQmP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Sep 2015 12:42:15 -0400
In-Reply-To: <CAANLjFpmO+rGnEFM5+u6piVoa4YqvoVCcTWjYOQJ2cXEEk7T-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 09/03/2015 11:23 AM, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Somnath,
>
> I'm having a hard time with your slide deck. Am I understanding
> correctly that the default Hammer install was performed on SSDs with
> co-located journals, but the optimized code was performed on the same
> SSDs but the journal was in NVRAM? If so I'm having a hard time
> understanding how these tests can be comparable. I really like the
> performance gains you are seeing, but I'm trying to understand how
> much the optimized code alone helps performance.

Hi Robert,

We talked about this a bit at the weekly performance meeting.  I think 
Somnath just hasn't gotten a chance to do those tests yet and is 
planning on doing them in the coming weeks.  I believe he started out 
with hammer on the SSDs and then tried to figure out how to tweak things 
to make the NVRAM configuration perform better.  Now he has to go back 
and retest the original configuration but with the new code.

Mark
