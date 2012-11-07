From: Martin Mailand <martin@tuxadero.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 23:39:44 +0100
Message-ID: <509AE330.7070808@tuxadero.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com> <509ACE8A.5090708@tuxadero.com> <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com> <509AD42A.9060108@tuxadero.com> <CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:44038 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2KGWjt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 17:39:49 -0500
In-Reply-To: <CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

good question, probably we do not have enough experience with IPoIB.
But it looks good on paper, so it's definitely a try worth.

-martin

Am 07.11.2012 23:28, schrieb Gandalf Corvotempesta:
> 2012/11/7 Martin Mailand <martin@tuxadero.com>:
>> I tested a Arista 7150S-24, a HP5900 and in a few weeks I will get a
>> Mellanox MSX1016. ATM the Arista is may favourite.
>
> Why not infiniband?
>
