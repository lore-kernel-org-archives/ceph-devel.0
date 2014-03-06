From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 11:28:18 +0100
Message-ID: <CAJH6TXjvu4A_1pZKfOr22M00kCx+k08uEN8JFaYrTwXRmXQjjA@mail.gmail.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
	<CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
	<90E136A4-51C0-4991-BC23-4ECF078D6B52@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60848 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaCFK2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 05:28:19 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so2600520qcv.33
        for <ceph-devel@vger.kernel.org>; Thu, 06 Mar 2014 02:28:18 -0800 (PST)
In-Reply-To: <90E136A4-51C0-4991-BC23-4ECF078D6B52@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

2014-03-06 11:14 GMT+01:00 Sebastien Han <sebastien.han@enovance.com>:
> No this is currently not supported.
> We can only select on drive per server.
> Can you submit an issue on Github for enhancement?

I'll do in a couple of minutes.

> Yes they must be identical. If a device doesn't exist Ansible will simply hang on the "parted" test, it will probably timeout at some point, however I haven't tested this.
> However I just pushed a pull request to workaround this issue.
> https://github.com/ceph/ceph-ansible/pull/4

Cool.
In this case I'll be able to specify all 12 spinning disks for my
servers even if they aren't installed.
Is Ansible smart enough to detect and configure newly added disks in
the next run ?
