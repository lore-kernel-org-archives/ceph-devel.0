From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 08:39:15 -0500
Message-ID: <5187B283.5040104@inktank.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:53756 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3EFNjW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 09:39:22 -0400
Received: by mail-ve0-f174.google.com with SMTP id pb11so3135194veb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 06:39:21 -0700 (PDT)
In-Reply-To: <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2013 08:35 AM, Gandalf Corvotempesta wrote:
> 2013/5/6 Mark Nelson <mark.nelson@inktank.com>:
>> It would be very interesting to hear how SDP does.  With IPoIB I've gotten
>> about 2GB/s on QDR with Ceph, which is roughly also what I can get in an
>> ideal round-robin setup with 2 bonded 10GbE links.
>
> Yes, but IB costs 1/4 than 10GbE and will be much expandible in future.
>

QDR shouldn't be that much cheaper.  Maybe SDR or DDR.  But I agree with 
your general sentiment.  I think rsockets may be a really good 
benefit/cost solution for the short term to get IB support into Ceph. 
It sounds like there is some work planned for a kernel implementation 
which would be fantastic on the file system side as well.

Mark
