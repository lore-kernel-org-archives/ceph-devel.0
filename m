From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 13:10:20 -0800
Message-ID: <50FB0BBC.3080309@inktank.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <48082542-C93C-4732-8307-8D6F42C1D915@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:60170 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab3ASVKX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 16:10:23 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so2118087dak.11
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 13:10:23 -0800 (PST)
In-Reply-To: <48082542-C93C-4732-8307-8D6F42C1D915@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Smith <peterfruits@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/19/2013 10:16 AM, Peter Smith wrote:
> That is fine. What qemu version do u recommend? I can build one myself.

I'd recommend qemu 1.2+. You'll probably need a newer libvirt than 
Centos 6 has as well. libvirt 0.10+ is ideal. Ubuntu has an older
version, but with important fixes backported.

Josh
