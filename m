From: Gregory Farnum <greg@inktank.com>
Subject: Re: Assertion error in librados
Date: Mon, 31 Mar 2014 10:10:08 -0700
Message-ID: <CAPYLRzg3Qfpt+QS40iREznhCHgVEv=MAWaGNHZREr65AD9SRgQ@mail.gmail.com>
References: <20140225144900.GA30739@philipgian-mac>
	<CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
	<20140225155838.GB30739@philipgian-mac>
	<CA+Hcz59dVj1CPiV6Xzo8_Z4WzhehNRiHyef_DE+MPBT19FHd4Q@mail.gmail.com>
	<530CD824.2000107@inktank.com>
	<CA+Hcz59FC07EfPgPSo2TT6=oUQjEMmfDYLROB1p2QG7CxRLLWQ@mail.gmail.com>
	<20140328095443.GZ28819@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33401 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbaCaRKJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Mar 2014 13:10:09 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so7721606qgz.34
        for <ceph-devel@vger.kernel.org>; Mon, 31 Mar 2014 10:10:08 -0700 (PDT)
In-Reply-To: <20140328095443.GZ28819@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@inktank.com>, Noah Watkins <noah.watkins@inktank.com>, synnefo-devel@googlegroups.com

Nope, I don't think anybody's looked into it. If you have core dumps
you could get a backtrace and the return value referenced.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Mar 28, 2014 at 2:54 AM, Filippos Giannakos <philipgian@grnet.gr> wrote:
> Hello,
>
> We recently bumped again into the same assertion error.
> Do you have any indications or update regarding the cause ?
>
> On Tue, Feb 25, 2014 at 11:26:15AM -0800, Noah Watkins wrote:
>> On Tue, Feb 25, 2014 at 9:51 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> > That's a good idea. This particular assert in a Mutex is almost always
>> > a use-after-free of the Mutex or structure containing it though.
>>
>> I think that a use-after-free will also throw an EINVAL (assuming it
>> isn't a pathalogical case) as pthread_mutex_lock checks an
>> initialization magic variable. I think that particular mutex isn't
>> initialized with flags that would cause any of the other possible
>> return values.
>
> Kind regards,
> --
> Filippos
> <philipgian@grnet.gr>
