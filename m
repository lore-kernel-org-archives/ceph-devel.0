From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 17:12:52 -0600
Message-ID: <509AEAF4.30309@inktank.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov> <509A8F4F.7090404@inktank.com> <509ACE8A.5090708@tuxadero.com> <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com> <509AD42A.9060108@tuxadero.com> <CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com> <509AE330.7070808@tuxadero.com> <CAJH6TXjqMc3mOU7LLPW2oPp+jTC_V_r=JtRU2bGEmtH4vdb3ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49336 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab2KGXMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 18:12:48 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3301031iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 15:12:48 -0800 (PST)
In-Reply-To: <CAJH6TXjqMc3mOU7LLPW2oPp+jTC_V_r=JtRU2bGEmtH4vdb3ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: martin@tuxadero.com, "Atchley, Scott" <atchleyes@ornl.gov>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2012 04:51 PM, Gandalf Corvotempesta wrote:
> 2012/11/7 Martin Mailand <martin@tuxadero.com>:
>> But it looks good on paper, so it's definitely a try worth.
>
> is at least 4x times faster than 10gbe and AFAIK should have a lower latency.
> I'm planning to use infiniband as backend storage network, used for
> OSD replication. 2 HBA for each OSD should give me 80Gbps and full
> redundancy
>

I haven't done much with IPoIB (just RDMA), but my understanding is that 
it tends to top out at like 15Gb/s.  Some others on this mailing list 
can probably speak more authoritatively.  Even with RDMA you are going 
to top out at around 3.1-3.2GB/s.

This thread may be helpful/interesting:
http://comments.gmane.org/gmane.linux.drivers.rdma/12279

Mark
