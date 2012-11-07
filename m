From: Martin Mailand <martin@tuxadero.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 23:13:39 +0100
Message-ID: <509ADD13.9080308@tuxadero.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com> <509ACE8A.5090708@tuxadero.com> <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com> <509AD42A.9060108@tuxadero.com> <509AD646.30903@profihost.ag> <509AD8CA.3080502@tuxadero.com> <509AD9A7.5070208@profihost.ag>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:43773 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab2KGWNr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 17:13:47 -0500
In-Reply-To: <509AD9A7.5070208@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I *think* the HP is Broadcom based, the Arista is Fulcrum based, and I 
don't know which chips Mellanox is using.

Our NOC tested both of them, an the Arista was the clear winner, at 
least in our workload.

-martin

Am 07.11.2012 22:59, schrieb Stefan Priebe:
> HP told me they all use the same ships and Arista measures latency while
> only one port is in use. HP guarentees the latency when all ports are in
> use. If this is correct or just somehing hp told me - i don't know. They
> told me the arista is slower and the statistics are not comporable...
