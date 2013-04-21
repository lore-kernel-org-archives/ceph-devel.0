From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Sun, 21 Apr 2013 23:04:11 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
	<516FF893.1030309@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
	<517159C3.5030100@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
 <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:58393 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3DUXEo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 19:04:44 -0400
In-Reply-To: <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Hi,
> 
> > My goal is 4 OSD's, each on separate machines, with 1 drive in each for a
> start, but I want to see performance of at least the same order of magnitude
> as the theoretical maximum on my hardware before I think about replacing
> my existing setup.
> 
> My current understanding is that it's not even possible, you always
> have a min 2/3x slow down in the best case.
> 
> If you do sustained sequential write benchmark, and have a single
> drive, then that drive ends up writing the data twice (journal + final
> storage area) which with the seeks will more than divide by 2 the peak
> perf of the drive. And since it's sequential, it will only write to 1
> PG at a time (so not divided among several OSD).
> 
> Also AFAIU the OSD receiving the data will also have to send the data
> to the other OSD in the PG and wait for them to say everything is
> written before confirming the write, which slows it even more.
> 

Correct, but that's the theoretical maximum I was referring to. If I calculate that I should be able to get 50MB/second then 30MB/second is acceptable but 500KB/second is not :)

James

