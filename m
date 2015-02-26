From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW : Transaction Id in response?
Date: Thu, 26 Feb 2015 12:21:49 -0500 (EST)
Message-ID: <986670957.11758198.1424971309700.JavaMail.zimbra@redhat.com>
References: <CAGoDY9=k7MFQVv_cJaV5jPtJUQwHddr=OmCySSC599vW4hLB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40944 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbBZRVv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 12:21:51 -0500
In-Reply-To: <CAGoDY9=k7MFQVv_cJaV5jPtJUQwHddr=OmCySSC599vW4hLB6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Dixit <dixitabhi@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Abhishek Dixit" <dixitabhi@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 25, 2015 8:35:40 PM
> Subject: RGW : Transaction Id in response?
> 
> Hi,
> 
> I was doing comparison of Open Stack Swift response headers and Ceph
> RGW response.
> This is in regard to X-Trans-Id header in response from Open Stack
> Swift storage.
> Swift response to a request always have the header "X-Trans-Id".
> X-Trans-Id : A unique transaction identifier for this request.
> 
> X-Trans-Id seems to serve two purpose:
> 1. Every log messages for a request will carry this and aid in
> debugging/analyzing.
> 2. Benchmarking for latency.
> 
> So, do we have similar unique identifier in Ceph RGW response which
> associates with each request?
> 
> Or do we need add support for this?
> 

At the moment there is no such identifier. We can leverage the rados client instance id that each radosgw instance gets when connecting to the backend, and there's also a unique running number that we use to identify each request within that gateway. We can probably concatenate these and return it as the unique identifier.

Yehuda

