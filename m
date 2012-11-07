From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: SSD journal suggestion
Date: Wed, 7 Nov 2012 22:14:27 +0100
Message-ID: <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
	<alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net>
	<CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com>
	<509A77CA.5030206@inktank.com>
	<670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov>
	<509A8A32.9020701@inktank.com>
	<8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov>
	<509A8F4F.7090404@inktank.com>
	<509ACE8A.5090708@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51944 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab2KGVO2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 16:14:28 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so1178545eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 13:14:27 -0800 (PST)
In-Reply-To: <509ACE8A.5090708@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Mark Nelson <mark.nelson@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/7 Martin Mailand <martin@tuxadero.com>:
> I have 16 SAS disk on a LSI 9266-8i and 4 Intel 520 SSD on a HBA, the node
> has dual 10G Ethernet. The clients are 4 nodes with dual 10GeB, as test I
> use rados bench on each client. The aggregated write speed is around 1,6GB/s
> with single replication.

Just for curiosity, which switches do you have?
