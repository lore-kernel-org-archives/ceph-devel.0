From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Fwd: Which IDE do you use for ceph-development?
Date: Thu, 15 Sep 2016 22:07:56 +0100
Message-ID: <18ba07ef-a59b-9da5-d5cd-551502a64f28@suse.de>
References: <CAA8xDw3OPGikoYF3Knef5tBrCsg+Hvekhyh7BVGJZCq4Yn93Fw@mail.gmail.com>
 <CAA8xDw1RA2RhZ=ERPKK0ZjD1Zc4iWYgm_zSvNHHEdJ+q7FcJag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbcIOVH6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 17:07:58 -0400
In-Reply-To: <CAA8xDw1RA2RhZ=ERPKK0ZjD1Zc4iWYgm_zSvNHHEdJ+q7FcJag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/11/2016 05:33 PM, Elita Lobo wrote:
> Hi,
>
> I tried using NEtbeans and Eclipse . Netbeans gave this error.
> https://paste.fedoraproject.org/426622/61053414/
>
> And Eclipse is not able to detect header files although I added the
> path of the include directory.
>
> Has anyone successfully built the ceph code on any IDE?

Ceph used to build on Eclipse with CDT. Up to Ganymede or something, but 
that was ages ago.

Eventually ended up moving to 'vim' because Eclipse started going nuts 
due to boost, unable to recognize the library. Also, vim ends up being 
nicer to develop on a remote server.

Sorry if this doesn't help much.

   -Joao
