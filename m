From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 22:59:03 +0100
Message-ID: <509AD9A7.5070208@profihost.ag>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com> <509ACE8A.5090708@tuxadero.com> <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com> <509AD42A.9060108@tuxadero.com> <509AD646.30903@profihost.ag> <509AD8CA.3080502@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54838 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab2KGV7H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 16:59:07 -0500
In-Reply-To: <509AD8CA.3080502@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 07.11.2012 22:55, schrieb Martin Mailand:
> Hi Stefan,
>
> deep buffers means latency spikes, you should go for fast switching
> latency. The HP5900 has a latency of 1ms, the Arista and Mellanox of =
250ns.

HP told me they all use the same ships and Arista measures latency whil=
e=20
only one port is in use. HP guarentees the latency when all ports are i=
n=20
use. If this is correct or just somehing hp told me - i don't know. The=
y=20
told me the arista is slower and the statistics are not comporable...

 > And I you should think at the price the HP5900 cost 3 times of the
 > Mellanox.
Don't know what the Mellanox coests. I get the HP for a really good=20
price below 10.000 =80.

Greets,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
