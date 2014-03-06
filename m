From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph Ansible Repo
Date: Thu, 6 Mar 2014 10:36:43 +0100
Message-ID: <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:48466 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaCFJgo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 04:36:44 -0500
Received: by mail-qc0-f177.google.com with SMTP id w7so2503382qcr.8
        for <ceph-devel@vger.kernel.org>; Thu, 06 Mar 2014 01:36:43 -0800 (PST)
In-Reply-To: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

Hi to all.
Some question about ansible repo.

1. is possible to specify multiple journal devices for each OSD node?
We have OSD with 12 spinning disks and 2 SSD as journal. We would like
to use SSD1 for OSD1 to 6 and SSD2 for OSD 7 to 12. Is this possible ?

2. With this repo, each OSD node must be identical to each other,
right? What if OSD server1 has 3 spinning disks and OSD server2 has
just 2 ?


2014-03-03 0:26 GMT+01:00 Sebastien Han <sebastien.han@enovance.com>:
> Hi,
>
> As discussed during the Ceph day, I achieved the Ansible playbook for=
 Ceph.
> It currently lives on my github, but I'd like to see it on github.com=
/ceph.
>
> Does anyone can create the corresponding repo so I can send a pull re=
quest?
>
> Thanks!
>
> ----
> S=E9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood."
>
> Phone: +33 (0)1 49 70 99 72
> Mail: sebastien.han@enovance.com
> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
> Web : www.enovance.com - Twitter : @enovance
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
