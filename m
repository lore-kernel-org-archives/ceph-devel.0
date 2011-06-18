From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: inconsistent chunk
Date: Sat, 18 Jun 2011 18:27:42 +0300
Message-ID: <4DFCC3EE.2090700@ufm.su>
References: <4DFAE436.9060606@ufm.su> <E58F9FF9-B13F-45D7-86D3-5C1940A919C7@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:48325 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab1FRP1r (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 18 Jun 2011 11:27:47 -0400
In-Reply-To: <E58F9FF9-B13F-45D7-86D3-5C1940A919C7@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, samuel.just@dreamhost.com

On 06/17/2011 07:27 PM, Gregory Farnum wrote:
> 4. Can I recover the data without backup?
> Possibly. If the inconsistency is just that one of the OSDs is storing the object and another OSD says the object shouldn't exist, that can be recovered from by working out which one is correct.
>
> Have you manually adjusted the contents of any OSDs? Can you think of anything you've done that might have triggered this?
  I step by step down osd servers until only one remains (hmm, it is not 
clear how this is consistent with "pg_size 2"). After one day I step by 
step up osd servers.

WBR,
     Fyodor.

