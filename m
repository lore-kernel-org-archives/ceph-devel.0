From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: Client can't reboot when rbd volume is mounted.
Date: Mon, 11 Feb 2013 16:24:10 +0400
Message-ID: <5118E2EA.2050407@gmail.com>
References: <511880D8.1000306@gmail.com> <alpine.DEB.2.00.1302102133260.5429@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:37508 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3BKMYO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 07:24:14 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so4483627lba.23
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 04:24:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302102133260.5429@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11.02.2013 09:36, Sage Weil wrote:
> On Mon, 11 Feb 2013, Roman Alekseev wrote:
>> Hi,
>>
>> When I try to reboot a client server  without unmounting of rbd volume
>> manually
>> its services stop working but server doesn't reboot completely and show the
>> following logs in KVM console:
>>
>> [235618.0202207] libceph: connect 192.168.0.19:6789 error -101
> That is
>
> #define        ENETUNREACH     101     /* Network is unreachable */
>
> Note that that (or any other) socket error is not necessarily fatal; the
> kernel client will retry and eventually connect to that or another OSD
> to complete the IO.  Are you observing that the RBD image hangs or
> something?
>
> You can peek at in-flight IO (and other state) with
>
>   cat /sys/kernel/debug/ceph/*/osdc
>
> unmount/unmap should not be necessarily in any case unless there is a bug.
> We backported a bunch of stuff to 3.6.6, so 3.6.10 ought to be okay.  You
> might try a newer 3.6.x kernel too; I forget if there was a second batch
> of fixes..
>
> sage

Hi Sage,

 > #define ENETUNREACH 101 /* Network is unreachable */

The reason of this error is that networking stop working after 
performing server reset request.

 > Are you observing that the RBD image hangs or something?

the RBD works properly. It is just mapped and mounted on the client server.

# /dev/rbd1              99G  616M   93G   1% /home/test

The "/sys/kernel/debug" folder is empty, how to put 'ceph/*/osdc' 
content into it?

I've update kernel to 3.7.4 version but problem is still persist.

Thanks

-- 
Kind regards,

R. Alekseev

