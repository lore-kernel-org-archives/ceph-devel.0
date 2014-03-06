From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 14:19:07 +0100
Message-ID: <CAJH6TXhSTRvn3NRqh=WXY5VdPhbW+HxPZAbUGCEqtX6rB6YFWg@mail.gmail.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
	<CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
	<53186512.6080405@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40702 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaCFNTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 08:19:08 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so2740183qcy.26
        for <ceph-devel@vger.kernel.org>; Thu, 06 Mar 2014 05:19:07 -0800 (PST)
In-Reply-To: <53186512.6080405@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm37@cam.ac.uk>
Cc: Sebastien Han <sebastien.han@enovance.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

2014-03-06 13:07 GMT+01:00 David McBride <dwm37@cam.ac.uk>:
> This causes the IO load to be nicely balanced across the two SSDs,
> removing any hot spots, at the cost of enlarging the failure domain of
> the loss of an SSD from half a node to a full node.

This is not a solution for me.
Why not using LVM with a VG striped across both SSD ?
I've never used LVM without raid, what happens in case of failure
of a phisical disks?  The whole VG is lost ?
