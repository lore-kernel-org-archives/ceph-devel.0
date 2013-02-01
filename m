From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: on disk encryption
Date: Fri, 1 Feb 2013 16:37:06 +0100
Message-ID: <CAJafhzSbLwjcW4p0p2_yT87p2RuNH4hDG9tqv8eOLWJR_Hhqvg@mail.gmail.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
	<CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
	<50C5A894.8020507@ubuntu.com>
	<6EACA8977B8949FE9A17B74B37772B4A@inktank.com>
	<50FF0478.7020702@ubuntu.com>
	<alpine.DEB.2.00.1301221603360.17154@cobra.newdream.net>
	<CALFpzo5WBnRa=LTVqnqo+iG4FziyCxJxjYVp=tvE=aYJEBw4zw@mail.gmail.com>
	<alpine.DEB.2.00.1301311643530.15832@cobra.newdream.net>
	<CANygib93zBh-TjRqzZkRGz3HiAHy4AU51yuTZs5qjKGTKycEUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:41648 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3BAPhH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 10:37:07 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so5398054iaj.20
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 07:37:06 -0800 (PST)
In-Reply-To: <CANygib93zBh-TjRqzZkRGz3HiAHy4AU51yuTZs5qjKGTKycEUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

As a special use-case I would propose to do the encryption inside the
qemu-rbd driver (similar to the qcow2 driver). This would also encrypt the
network traffic from the KVM host to the osd.

I know that this is probably not the generic aproach for on disk
encryption, but it would provide some extra secuity for the "EBS" user.

Is there someone working on this / do others have interest in this solution?

Christian
