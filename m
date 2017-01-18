From: Sage Weil <sweil@redhat.com>
Subject: Re: Quota issues of pool
Date: Wed, 18 Jan 2017 00:23:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701180020280.1661@piezo.novalocal>
References: <2955E729-D7CF-481A-81AC-E1B72616CC30@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-979809229-1484699005=:1661"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbdARAXb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Jan 2017 19:23:31 -0500
In-Reply-To: <2955E729-D7CF-481A-81AC-E1B72616CC30@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-979809229-1484699005=:1661
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 Jan 2017, LIU, Fei wrote:
> Hi ,
> 
>    We have tested the quota features of pool, We found we can set up the quota of pool less than existing image size. We can also create a image with quota more than the pool size. Sometime ,we even set up a quota for a image, but we found we can write the data more than the quota we setup for a image. For example, we set up a poor with quota 100M and create a image inside of pool with 200M. but we found we can write more than 100M to the image which is way over 100M.
>    
>    ceph osd pool set-quota quota max_bytes 100M
>    rbd create –s 200M  quota/100
>    sudo rbd map quota/100
>    sudo dd  if= /dev/zero of=/dev/rbd0  bs=16k 
> 
>    we in the end  wrote 163M into the image.
> 
>   We are wondering the quota function of the pool did not work from our 
>   observation. Appreciate for any input?

Unlike a single storage server in which all IO passes through a single 
server, Ceph is distributed and can't easily do perfect 
quota enforcement.  It's a feedback loop, but there is always some 
delay:

 - osds report pg stats to mon
 - mon sees pool usage exceed quota, sets full flag on pool
 - new osdmap propagates to osds
 - osds block new writes

This is usually not a problem when limits are large, as we generally 
expect them to be.  (1 PB vs 1.00001 PB written doesn't really matter.)  
It doesn't work well on very small pools (e.g., 100 MB), but you generally 
don't want such small pools anyway or else you'll need to have millions of 
them in a single cluster, and that isn't supported.

sage
--8323329-979809229-1484699005=:1661--
