From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 11:43:54 +0100
Message-ID: <CAJH6TXhGkK6fHyai_DMcyeYMsY3Uf4uqXyKoJwYz=_XmMpL9zw@mail.gmail.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
	<CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
	<90E136A4-51C0-4991-BC23-4ECF078D6B52@enovance.com>
	<CAJH6TXjvu4A_1pZKfOr22M00kCx+k08uEN8JFaYrTwXRmXQjjA@mail.gmail.com>
	<B43365B2-B0C1-4117-867B-3D7E772D30AA@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:46382 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaCFKnz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 05:43:55 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so2577798qcx.20
        for <ceph-devel@vger.kernel.org>; Thu, 06 Mar 2014 02:43:54 -0800 (PST)
In-Reply-To: <B43365B2-B0C1-4117-867B-3D7E772D30AA@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

2014-03-06 11:42 GMT+01:00 Sebastien Han <sebastien.han@enovance.com>:
> Cool :)
>
> Yes you will be able to pre-provision all the disks.
> During the next run it will retry all the disks, some will be installed some will not therefore it will configure them :).

Perfect.
Now the only missing thing is https://github.com/ceph/ceph-ansible/issues/5
