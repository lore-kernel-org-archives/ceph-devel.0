From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Wed, 15 Oct 2014 14:11:10 +0200
Message-ID: <543E645E.4080405@redhat.com>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <543CD16C.6060708@m-privacy.de> <alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net> <543E179E.4070704@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbaJOMMa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Oct 2014 08:12:30 -0400
In-Reply-To: <543E179E.4070704@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On 10/15/2014 08:43 AM, Amon Ott wrote:
> Am 14.10.2014 16:23, schrieb Sage Weil:
>> On Tue, 14 Oct 2014, Amon Ott wrote:
>>> Am 13.10.2014 20:16, schrieb Sage Weil:
>>>> We've been doing a lot of work on CephFS over the past few months. This
>>>> is an update on the current state of things as of Giant.
>>> ...
>>>> * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fuse
>>>>    or libcephfs) clients are in good working order.
>>> Thanks for all the work and specially for concentrating on CephFS! We
>>> have been watching and testing for years by now and really hope to
>>> change our Clusters to CephFS soon.
>>>
>>> For kernel maintenance reasons, we only want to run longterm stable
>>> kernels. And for performance reasons and because of severe known
>>> problems we want to avoid Fuse. How good are our chances of a stable
>>> system with the kernel client in the latest longterm kernel 3.14? Will
>>> there be further bugfixes or feature backports?
>> There are important bug fixes missing from 3.14.  IIRC, the EC, cache
>> tiering, and firefly CRUSH changes aren't there yet either (they landed in
>> 3.15), and that is not appropriate for a stable series.
>>
>> They can be backported, but no commitment yet on that :)
> If the bugfixes are easily identified in one of your Ceph git branches,
> I would even try to backport them myself. Still, I would rather see
> someone from the Ceph team with deeper knowledge of the code port them.
>
> IMHO, it would be good for Ceph to have stable support in at least the
> latest longterm kernel. No need for new features, but bugfixes should be
> there.
>
> Amon Ott

Long term support and aggressive, tedious backports are what you go to distro 
vendors for normally - I don't think that it is generally a good practice to 
continually backport anything to stable series kernels that is not a 
bugfix/security issue (or else, the stable branches rapidly just a stale version 
of the upstream tip :)).

Not meant as a commercial for RH, other vendors also do this kind of thing of 
course...

Regards,

Ric

