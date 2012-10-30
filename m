From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:38:07 +0100
Message-ID: <508FD83F.9020308@profihost.ag>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com> <508EE540.5060303@inktank.com> <CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com> <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com> <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50135 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2J3Now (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:44:52 -0400
In-Reply-To: <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

Am 30.10.2012 14:36, schrieb Gandalf Corvotempesta:
> 2012/10/30 Gregory Farnum <greg@inktank.com>:
>> Not a lot of people are publicly discussing their sizes on things like
>> that, unfortunately. I believe DreamHost is still the most open. They
>> have an (RGW-based) object storage service which is backed by ~800
>> OSDs and are currently beta-testing a compute service using RBD, which
>> you can see described here:
>> http://www.youtube.com/watch?v=l_8Y988fO44&feature=plcp

But there's still the problem of slow random write IOP/s. At least i 
haven't seen any good benchmarks.

Stefan
