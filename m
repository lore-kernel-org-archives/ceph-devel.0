From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 09 Jan 2013 14:30:35 +0100
Message-ID: <50ED70FB.8020902@de-punkt.de>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET> <50ED6C9F.5030107@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-10.de-punkt.de ([93.190.68.161]:48345 "EHLO
	mail-10.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757846Ab3AINak (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 08:30:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-10.de-punkt.de (Postfix) with ESMTP id D8BDA3A32F
	for <ceph-devel@vger.kernel.org>; Wed,  9 Jan 2013 14:30:37 +0100 (CET)
Received: from mail-10.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6aUU7fdtOOi for <ceph-devel@vger.kernel.org>;
	Wed,  9 Jan 2013 14:30:37 +0100 (CET)
Received: from Christophers-MacBook-Pro.local (p4FFFEC0C.dip.t-dialin.net [79.255.236.12])
	(Authenticated sender: chris@de-punkt.de)
	by mail-10.de-punkt.de (Postfix) with ESMTPSA id 747EB3A32D
	for <ceph-devel@vger.kernel.org>; Wed,  9 Jan 2013 14:30:36 +0100 (CET)
In-Reply-To: <50ED6C9F.5030107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
> 
> Yes, 0.56(.1) has a significant performance increase compared to 0.48
> 
That is not exactly the OP's question, though. If I understand
correctly, she is concerned about ongoing performance improvements
within the "bobtail" branch, i.e. between 0.56.1 and 0.56.X (with X>1).

Jutta, what kind of use case do you have in mind, i.e. how complex are
your benchmarking scenarios?

Regards,

--ck
