From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: SSD journal suggestion
Date: Thu, 8 Nov 2012 08:55:26 -0500
Message-ID: <FB2218CC-8F8F-480A-A5E5-DEF933100612@ornl.gov>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
 <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net>
 <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com>
 <509A77CA.5030206@inktank.com>
 <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov>
 <509A8A32.9020701@inktank.com>
 <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov>
 <509A8F4F.7090404@inktank.com>	<509ACE8A.5090708@tuxadero.com>
 <CAJH6TXifJmKc-g-FaijgwwGh_yVAQ+5ebGO_Du7C43u+_rZ49g@mail.gmail.com>
 <509AD42A.9060108@tuxadero.com>
 <CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com>
 <509AE330.7070808@tuxadero.com>
 <CAJH6TXjqMc3mOU7LLPW2oPp+jTC_V_r=JtRU2bGEmtH4vdb3ag@mail.gmail.com>
 <509AEAF4.30309@inktank.com>
 <CAJH6TXgoHTNKhfRTsZ4pSZs4Qk32e-ctr1-6NkBQ=BDiVSBM+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:4524 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab2KHNzc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 08:55:32 -0500
In-Reply-To: <CAJH6TXgoHTNKhfRTsZ4pSZs4Qk32e-ctr1-6NkBQ=BDiVSBM+g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "martin@tuxadero.com" <martin@tuxadero.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Nov 8, 2012, at 3:22 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:

> 2012/11/8 Mark Nelson <mark.nelson@inktank.com>:
>> I haven't done much with IPoIB (just RDMA), but my understanding is that it
>> tends to top out at like 15Gb/s.  Some others on this mailing list can
>> probably speak more authoritatively.  Even with RDMA you are going to top
>> out at around 3.1-3.2GB/s.
> 
> 15Gb/s is still faster than 10Gbe
> But this speed limit seems to be kernel-related and should be the same
> even in a 10Gbe environment, or not?

We have a test cluster with Mellanox QDR HCAs (i.e. NICs). When using Verbs (the native IB API), I see ~27 Gb/s between two hosts. When running Sockets over these devices using IPoIB, I see 13-22 Gb/s depending on whether I use interrupt affinity and process binding.

For our Ceph testing, we will set the affinity of two of the mlx4 interrupt handlers to cores 0 and 1 and we will not using process binding. For single stream Netperf, we do use process binding and bind it to the same core (i.e. 0) and we see ~22 Gb/s. For multiple, concurrent Netperf runs, we do not use process binding but we still see ~22 Gb/s.

We used all of the Mellanox tuning recommendations for IPoIB available in their tuning pdf:

http://www.mellanox.com/related-docs/prod_software/Performance_Tuning_Guide_for_Mellanox_Network_Adapters.pdf

We looked at their interrupt affinity setting scripts and then wrote our own.

Our testing is with IPoIB in "connected" mode, not "datagram" mode. Connected mode is less scalable, but currently I only get ~3 Gb/s with datagram mode. Mellanox claims that we should get identical performance with both modes and we are looking into it.

We are getting a new test cluster with FDR HCAs and I will look into those as well.

Scott