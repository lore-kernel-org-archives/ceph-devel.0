From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: SSD journal suggestion
Date: Thu, 8 Nov 2012 10:02:40 -0500
Message-ID: <B2FEDEA2-4A94-4878-B8B9-839E14CD1C9D@ornl.gov>
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
 <FB2218CC-8F8F-480A-A5E5-DEF933100612@ornl.gov>
 <509BC407.4030406@inktank.com>
 <FB2859AE-F86A-4C4A-8EF5-5878CD8ABDC7@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.14.62]:10033 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab2KHPCn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:02:43 -0500
In-Reply-To: <FB2859AE-F86A-4C4A-8EF5-5878CD8ABDC7@ornl.gov>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "martin@tuxadero.com" <martin@tuxadero.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Nov 8, 2012, at 10:00 AM, Scott Atchley <atchleyes@ornl.gov> wrote:

> On Nov 8, 2012, at 9:39 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
> 
>> On 11/08/2012 07:55 AM, Atchley, Scott wrote:
>>> On Nov 8, 2012, at 3:22 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:
>>> 
>>>> 2012/11/8 Mark Nelson <mark.nelson@inktank.com>:
>>>>> I haven't done much with IPoIB (just RDMA), but my understanding is that it
>>>>> tends to top out at like 15Gb/s.  Some others on this mailing list can
>>>>> probably speak more authoritatively.  Even with RDMA you are going to top
>>>>> out at around 3.1-3.2GB/s.
>>>> 
>>>> 15Gb/s is still faster than 10Gbe
>>>> But this speed limit seems to be kernel-related and should be the same
>>>> even in a 10Gbe environment, or not?
>>> 
>>> We have a test cluster with Mellanox QDR HCAs (i.e. NICs). When using Verbs (the native IB API), I see ~27 Gb/s between two hosts. When running Sockets over these devices using IPoIB, I see 13-22 Gb/s depending on whether I use interrupt affinity and process binding.
>>> 
>>> For our Ceph testing, we will set the affinity of two of the mlx4 interrupt handlers to cores 0 and 1 and we will not using process binding. For single stream Netperf, we do use process binding and bind it to the same core (i.e. 0) and we see ~22 Gb/s. For multiple, concurrent Netperf runs, we do not use process binding but we still see ~22 Gb/s.
>> 
>> Scott, this is very interesting!  Does setting the interrupt affinity 
>> make the biggest difference then when you have concurrent netperf 
>> processes going?  For some reason I thought that setting interrupt 
>> affinity wasn't even guaranteed in linux any more, but this is just some 
>> half-remembered recollection from a year or two ago.
> 
> We are using RHEL6 with a 3.5.1 kernel. I tested single stream Netperf with and without affinity:
> 
> Default (irqbalance running)   12.8 Gb/s
> IRQ balance off                13.0 Gb/s
> Set IRQ affinity to socket 0   17.3 Gb/s   # using the Mellanox script
> 
> When I set the affinity to cores 0-1 _and_ I bind Netperf to core 0, I get ~22 Gb/s for a single stream.

Note, I used hwloc to determine which socket was closer to the mlx4 device on our dual socket machines. On these nodes, hwloc reported that both sockets were equally close, but a colleague has machines where one socket is closer than the other. In that case, bind to the closer socket (or to cores within the closer socket).

> 
>>> We used all of the Mellanox tuning recommendations for IPoIB available in their tuning pdf:
>>> 
>>> http://www.mellanox.com/related-docs/prod_software/Performance_Tuning_Guide_for_Mellanox_Network_Adapters.pdf
>>> 
>>> We looked at their interrupt affinity setting scripts and then wrote our own.
>>> 
>>> Our testing is with IPoIB in "connected" mode, not "datagram" mode. Connected mode is less scalable, but currently I only get ~3 Gb/s with datagram mode. Mellanox claims that we should get identical performance with both modes and we are looking into it.
>>> 
>>> We are getting a new test cluster with FDR HCAs and I will look into those as well.
>> 
>> Nice!  At some point I'll probably try to justify getting some FDR cards 
>> in house.  I'd definitely like to hear how FDR ends up working for you.
> 
> I'll post the numbers when I get access after they are set up.
> 
> Scott
> 

