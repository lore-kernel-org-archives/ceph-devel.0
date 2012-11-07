From: Gregory Farnum <greg@inktank.com>
Subject: Re: Mons network
Date: Wed, 7 Nov 2012 16:14:08 +0100
Message-ID: <CAPYLRzhvX3D4RUGmj=VT74=prLdxh0abeUOCGwiYOO0qQexhMQ@mail.gmail.com>
References: <CAJH6TXiqRbuX=8gKL9hkVd=9X3vZew5jFHwM8xe=wjpu7_+5-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46009 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab2KGPOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:14:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2481926iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 07:14:09 -0800 (PST)
In-Reply-To: <CAJH6TXiqRbuX=8gKL9hkVd=9X3vZew5jFHwM8xe=wjpu7_+5-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 7, 2012 at 1:31 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> Which kind of network should I plain for 3 or 4 MONs nodes?
> Are these node called by the ceph client (RBD, RGW, and so on) or only by OSD?
>
> Can I use some virtual machines distributed across multiple Xen nodes
> on a 100mbit/s netoworks reachable by the whole storage cluster
> (client, server, ods, rbd, rgw) on should I put a gigabit network
> reachable only by OSD (for performance and security purposes)

The mons need to be reachable by everybody. They don't do a ton of
network traffic, but 100Mb/s might be pushing it a bit low...
