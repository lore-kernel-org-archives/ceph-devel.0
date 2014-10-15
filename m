From: Alphe Salas <asalas@kepler.cl>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Tue, 14 Oct 2014 21:16:41 -0300
Message-ID: <543DBCE9.2080605@kepler.cl>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <543CD16C.6060708@m-privacy.de> <alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:61926 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbaJOAQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 20:16:46 -0400
Received: by mail-qa0-f41.google.com with SMTP id n8so143532qaq.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Oct 2014 17:16:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Hello sage, last time I used CephFS it had a strange behaviour when if 
used in conjunction with a nfs reshare of the cephfs mount point, I 
experienced a partial random disapearance of the tree folders.

According to people in the mailing list it was a kernel module bug (not 
using ceph-fuse) do you know if any work has been done recently in that 
topic?

best regards

Alphe Salas
I.T ingeneer

On 10/14/2014 11:23 AM, Sage Weil wrote:
> On Tue, 14 Oct 2014, Amon Ott wrote:
>> Am 13.10.2014 20:16, schrieb Sage Weil:
>>> We've been doing a lot of work on CephFS over the past few months. This
>>> is an update on the current state of things as of Giant.
>> ...
>>> * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fuse
>>>    or libcephfs) clients are in good working order.
>>
>> Thanks for all the work and specially for concentrating on CephFS! We
>> have been watching and testing for years by now and really hope to
>> change our Clusters to CephFS soon.
>>
>> For kernel maintenance reasons, we only want to run longterm stable
>> kernels. And for performance reasons and because of severe known
>> problems we want to avoid Fuse. How good are our chances of a stable
>> system with the kernel client in the latest longterm kernel 3.14? Will
>> there be further bugfixes or feature backports?
>
> There are important bug fixes missing from 3.14.  IIRC, the EC, cache
> tiering, and firefly CRUSH changes aren't there yet either (they landed in
> 3.15), and that is not appropriate for a stable series.
>
> They can be backported, but no commitment yet on that :)
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
