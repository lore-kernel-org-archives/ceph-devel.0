From: Tommi Virtanen <tv@inktank.com>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 10:08:26 -0700
Message-ID: <CADvuQREy8sfOMJTWpLaMq8UHK6Mt_D8b8Mo7=OAfXk9DJUiKFw@mail.gmail.com>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl>
 <4FE195DE.50108@profihost.ag> <CADvuQRHGoXx4aMMfvyYeLpVKp2Vh7kyzZ1qWjhBSfrs8AMasTQ@mail.gmail.com>
 <0421100E-E107-4F83-B554-D7894E67EA28@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49772 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab2FTRIq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 13:08:46 -0400
Received: by dady13 with SMTP id y13so10085885dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 10:08:46 -0700 (PDT)
In-Reply-To: <0421100E-E107-4F83-B554-D7894E67EA28@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 20, 2012 at 9:46 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Actually, the short hostname of the machine is completely unrelated to
>> what IP addresses etc it has. The hostname is a configurable string.
>> We treat it as such -- it's just expected to be a unique identifier
>> for the host.
> Correct. So i should just change the /etc/hostname to the name that points to the internal ip via hosts file?

/etc/hostname is read into the kernel at bootup, using the
/bin/hostname command. So after editing, either reboot or use sudo
hostname --file /etc/hostname. Other than that, yes.
