From: Alphe Salas <asalas@kepler.cl>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 14:17:50 -0400
Message-ID: <53C8134E.8030802@kepler.cl>
References: <53C7D97D.3010607@kepler.cl> <20140717164712.GA4690@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:56958 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaGQSRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 14:17:54 -0400
Received: by mail-qc0-f179.google.com with SMTP id r5so2445429qcx.10
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 11:17:53 -0700 (PDT)
In-Reply-To: <20140717164712.GA4690@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



Alphe Salas
I.T ingeneer

On 07/17/2014 12:47 PM, Christoph Hellwig wrote:
> On Thu, Jul 17, 2014 at 10:11:09AM -0400, Alphe Salas wrote:
>> Usually when I talk to dev team about this problem they tell me that the
>> real problem is the lack of trim in XFS, but my own analysis shows that the
>> real problem is ceph internal way to handle data. It is ceph that never
>> discard any replicas and never "clean" itself to only keep records of the
>> data in use.
>
> XFS supports TRIM just fine - with -o discard it will issue TRIMs on
> unlink, and with fstrim you can do it explicitly.  Note that the online
> discard might be very slow for all Linux filesystems, although I've not
> actually tested it on top of RBD.
>
I will test it again probably the point I missed it that you have to 
unmount / remount the XFS RBD image in order to see the data disapear 
from the real disk space old in ceph. I will try it today and comeback 
with copy /paste of ceph -s etc..


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
