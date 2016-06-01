From: Sage Weil <sage@newdream.net>
Subject: Re: Compression tasks
Date: Wed, 1 Jun 2016 08:46:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606010840050.6221@cpach.fuggernut.com>
References: <D373CB01.562D6%manavalan.krishnan@sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-433291326-1464785165=:6221"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37725 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757634AbcFAMpk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 08:45:40 -0400
In-Reply-To: <D373CB01.562D6%manavalan.krishnan@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, Roushan Ali <Roushan.Ali@sandisk.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-433291326-1464785165=:6221
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jun 2016, Manavalan Krishnan wrote:
> Hi Igor, Sage 
> 
> Igor, I am writing this email as per your suggestion in the stand meeting
> today.
> 
> Roushan from our team spent some time on Blue store and compression code and
> he is familiar with it. 
> Is there any pending tasks in the compression feature that he can work on?
>  If so, could you please suggest one or more tasks?
> If there are no pending tasks in compression, he can work on other tasks. 

I think there are 2 directions to go here, since the core write path is 
working...

1- We want the ability to set tunables on a per-pool basis, such as 
compression algorithm and other policy info, in pool_opts_t, and then pass 
them down to a Collection in the ObjectStore interface.  Right now all the 
tunables are just osd config options.

2- We (probably?) need some sort of policy/heuristics around writes to 
ensure that we garbage collect when the lextent/blob mapping gets too 
inefficient.  For example, we might have writes like

   (compressed blob)
      (compressed blob)
         (compressed blob)
             (compressed blob)

that result in largish allocations that can't be partially 
deallocated when obscured.  A simple rule might be that if the lextent -> 
blob mapping reaches more than 3 layers deep (above it is 4) then on 
write we would spend the extra time to do some reads and write out a 
larger, non-overlapping/obscured blob, so that this

   (compressed blob)
      (compressed blob)
         (compressed blob)
             (compressed blob)
                 (new write...   )

makes us

   (read this in)
   (and write this big blob out )

or maybe

   (new blob    )(new blob      )

...so long as they are non-overlapping.

sage
--8323329-433291326-1464785165=:6221--
