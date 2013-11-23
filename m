From: Dan Mick <dan.mick@inktank.com>
Subject: Re: adminsocket
Date: Fri, 22 Nov 2013 19:07:33 -0800
Message-ID: <52901BF5.9070708@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B665FBE58@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:47173 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3KWDHi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Nov 2013 22:07:38 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so1422102yhz.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Nov 2013 19:07:35 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B665FBE58@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 11/22/2013 06:42 PM, James Harper wrote:
> What is an adminsocket used for? Would librbd use one in normal operation?

It's a way to send administrative and informational commands directly
to a Ceph entity (usually a daemon, but sometimes a client).  Almost
all the ceph entities create one...osd, mon, mds, client.  It's not 
really "normal" operation, but you can find stats there, and often
things like status, version of the software, etc.

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
