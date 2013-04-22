From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Mon, 22 Apr 2013 11:48:51 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4F3637AD@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
 <517159C3.5030100@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
 <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
 <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
 <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com>
 <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
 <51752156.9050004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:60785 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab3DVLtE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 07:49:04 -0400
In-Reply-To: <51752156.9050004@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > My read speed is consistently around 40MB/second, and my write speed is
> > consistently around 22MB/second. I had expected better of read...
> 
> You may want to try increasing your read_ahead_kb on the OSD data disks
> and see if that helps read speeds.
> 

Default appears to be 128 and I was getting 40MB/second
Increasing to 256 takes me up to 48MB/second
Increasing to 512 takes me up to 53Mb/second

Any further increases don't do anything that I can measure

Is increasing read_ahead_kb good for general performance, or just for impressing people with benchmarks? If the kernel spent time reading ahead woult it hurt random read/write performance?

Thanks
 
James

