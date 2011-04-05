From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: Question about librados
Date: Tue, 05 Apr 2011 08:44:15 +0200
Message-ID: <inedo0$3v2$1@dough.gmane.org>
References: <incab7$gnn$1@dough.gmane.org> <BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50200 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab1DEGo2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Apr 2011 02:44:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q7003-0002hG-1f
	for ceph-devel@vger.kernel.org; Tue, 05 Apr 2011 08:44:27 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 08:44:27 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 08:44:27 +0200
In-Reply-To: <BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 04/04/2011 06:09 PM, Gregory Farnum wrote:
> On Mon, Apr 4, 2011 at 4:33 AM, Rutger ter Borg<rutger@terborg.net>  wrote:
>>
>> Hello,
>>
>> I'm in the progress of evaluating librados as an object store. I'm using
>> Debian's latest packages as of today, and noted that I need to define
>> NO_ATOMIC_OPS to get something compiled that includes librados.hpp.
> Hmmm, that's not right! Can you elaborate? It just doesn't build
> librados.hpp unless you define NO_ATOMIC_OPS? Is there a build error
> at some point?

[snip]

Hello Greg,

thanks for the elaborate answer! With respect to the compile error, I 
got this in an empty file with just including rados/librados.hpp

$ g++ ./rados.cpp
In file included from /usr/include/rados/buffer.h:55:0,
                  from /usr/include/rados/librados.hpp:10,
                  from ./rados.cpp:6:
/usr/include/rados/atomic.h:25:24: fatal error: atomic_ops.h: No such 
file or directory 

compilation terminated.

Maybe it has to do with the .deb, apt pulled in librados2,

$ dpkg --status librados-dev
Version: 0.25.2-1 


Cheers,

Rutger


