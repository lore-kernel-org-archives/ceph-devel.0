From: Martin Mailand <martin@tuxadero.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 22:55:22 +0100
Message-ID: <509AD8CA.3080502@tuxadero.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com> <509ACE8A.5090708@tuxadero.com> <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com> <509AD42A.9060108@tuxadero.com> <509AD646.30903@profihost.ag>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:43690 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab2KGVzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 16:55:32 -0500
In-Reply-To: <509AD646.30903@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

deep buffers means latency spikes, you should go for fast switching 
latency. The HP5900 has a latency of 1ms, the Arista and Mellanox of 250ns.
And I you should think at the price the HP5900 cost 3 times of the Mellanox.

-martin

Am 07.11.2012 22:44, schrieb Stefan Priebe:
> Am 07.11.2012 22:35, schrieb Martin Mailand:
>> Hi,
>>
>> I tested a Arista 7150S-24, a HP5900 and in a few weeks I will get a
>> Mellanox MSX1016. ATM the Arista is may favourite.
>> For the dual 10GeB NICs I tested the Intel X520-DA2 and the Mellanox
>> ConnectX-3. My favourite is the Intel X520-DA2.
>
> That's pretty interesting i'll get the HP5900 and HP5920 in a few weeks.
> HP told me the deep packet buffers of the HP5920 will burst the
> performance and should be used for storage related stuff.
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
