From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel 10.2.8 -> QE
Date: Fri, 30 Jun 2017 22:04:56 +0200
Message-ID: <5e48dd6f-6493-aeb0-3e57-537caa3858e6@suse.cz>
References: <078ac38a-9f3b-3d8a-ff8b-7764eb9c13c1@suse.cz>
 <CAMMFjmH5coCEnnx79Jpr3U1fx56PMBGQTfZHsRO-i6iVP0t6dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752117AbdF3UE6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Jun 2017 16:04:58 -0400
In-Reply-To: <CAMMFjmH5coCEnnx79Jpr3U1fx56PMBGQTfZHsRO-i6iVP0t6dw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> This SHA1 build on trusty failed.
> Can you do another pls ?
> 
> https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=trusty,DIST=trusty,MACHINE_SIZE=huge/8736//consoleFull

Hi Yuri:

That's a build infrastructure failure. Though I could change the SHA1 by 
adding a bogus commit to the jewel branch, I'd much rather ask someone 
in the CI team (Alfredo, Andrew, David G., Dan?) to trigger a rebuild.

Please talk to them about it.

Nathan
