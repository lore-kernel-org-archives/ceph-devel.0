From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: session lost, hunting for new mon
Date: Fri, 18 May 2012 23:08:51 -0700
Message-ID: <4FB738F3.1060602@inktank.com>
References: <4FB72E28.2040709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40010 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2ESGIx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 May 2012 02:08:53 -0400
Received: by dady13 with SMTP id y13so4685226dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 23:08:53 -0700 (PDT)
In-Reply-To: <4FB72E28.2040709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 05/18/2012 10:22 PM, Stefan Priebe wrote:
> Hi,
>
> while doing my first tests with ceph i'm always struggling about these
> kernel messages:
>
> [ 273.332472] libceph: client0 fsid d3aa8d88-3aa8-4f74-bb87-aa8de4975a84
> [ 273.351025] libceph: mon1 10.0.255.101:6789 session established
> [ 459.830296] libceph: mon1 10.0.255.101:6789 socket closed
> [ 459.847044] libceph: mon1 10.0.255.101:6789 session lost, hunting for
> new mon
> [ 472.226073] libceph: mon0 10.0.255.100:6789 session established
>
> Always while stress testing the session to the mon's got lost. Any ideas?

These aren't a problem - it's just the connection to a monitor being
lost, and the client connecting to another one.
