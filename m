From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: MPI applications on ceph fs
Date: Sun, 26 Aug 2012 19:37:59 -0500
Message-ID: <503AC167.1060502@inktank.com>
References: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52432 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab2H0AiB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 20:38:01 -0400
Received: by ialo24 with SMTP id o24so7055989ial.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 17:38:01 -0700 (PDT)
In-Reply-To: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wright <jwright@psfc.mit.edu>
Cc: ceph-devel@vger.kernel.org

Hi John,

Is the MPI application writing to one file from multiple ranks?  Any 
idea what the application was doing when the lookup happens?

Mark

On 08/26/2012 09:03 AM, John Wright wrote:
> Hi All,
> We're running ceph 0.48 on  small three node test cluster. We've had good stability with I/O using dd and iozone especially after upgrading to 0.48. However, we're running into a repeatable lockup of the linux ceph client ( 3.3.5-2.fc16.x86_64 ) when running an mpi program that has simple I/O on a ceph mount. This is an mpi program running processes on two nodes. It is the remote node on which the ceph client locks up. The cient becomes immediately unresponsive and any attempt to access the mounted volume produces a process with status 'D'. I can see no indication in the server logs that it is ever contacted. Regular serial processes run fine on the volume. MPI runs on the nodes work fine when not using the ceph volume.
>
> So any suggestions on where to look? Any one have an experience testing parallel programs on ceph?
>
> thanks,
> -john
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
