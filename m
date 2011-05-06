From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: rbd speed: write vs read
Date: Fri, 06 May 2011 21:01:29 +0300
Message-ID: <4DC43779.3090506@ufm.su>
References: <4DC40249.7020903@ufm.su> <Pine.LNX.4.64.1105060906440.9905@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:47461 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470Ab1EFSBd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2011 14:01:33 -0400
In-Reply-To: <Pine.LNX.4.64.1105060906440.9905@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/06/2011 07:08 PM, Sage Weil wrote:
> On Fri, 6 May 2011, Fyodor Ustinov wrote:
>> Hi!
>>
>> oops. This my misconfiguration.
> Out of curiousity, what was the misconfiguration?
I have 20 OSD server. 10 in one vlan and 10 in other (btw, question: mon 
server can listen on all ip addressessimultaneously?).
Because our NOC, 10 servers have anisotropic configuration - 800Mbps in 
one direction and 150Mbps to another.
> Doing a streaming read in 10MB chunks when RBD is striped over 4MB
> objects won't be terribly efficient.  You should get the best sync read
> performance when the object sizes match up.  You'll get better performance
> if whatever is sitting above the block layer dispatches multiple read
> requests in parallel (i.e. something smarter than dd, like a file system).
Hmm. But it's linear read. I do not know how it works internally, but 
did reading 10MB by 4MB chunk can not be executed in parallel?

WBR,
     Fyodor.
