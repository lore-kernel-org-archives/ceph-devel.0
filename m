From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph performance on Ubuntu Oneiric vs Ubuntu Precise
Date: Mon, 18 Jun 2012 13:17:47 -0500
Message-ID: <4FDF70CB.2000903@inktank.com>
References: <4FDF6BB8.4080401@inktank.com> <CADvuQREzVbnw5xFSJLx5CSDPXdZOhOpHLHGr-CFYmtRWJmxZYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63885 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2FRSRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:17:54 -0400
Received: by ghrr11 with SMTP id r11so3931192ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 11:17:54 -0700 (PDT)
In-Reply-To: <CADvuQREzVbnw5xFSJLx5CSDPXdZOhOpHLHGr-CFYmtRWJmxZYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/18/2012 01:12 PM, Tommi Virtanen wrote:
> On Mon, Jun 18, 2012 at 10:56 AM, Mark Nelson<mark.nelson@inktank.com>  wrote:
>> I've been tracking down some performance issues over the past month with our
>> internal test nodes and believe I have narrowed it down to something related
>> to Ubuntu Oneiric.  Tests done on nodes running Ubuntu Precise are
>> significantly faster.
>
> Did you use Ubuntu kernels or our own builds? Different/same across runs?

Each set of nodes is using our kernel from gitbuilder:

http://gitbuilder.ceph.com/kernel-deb-oneiric-x86_64-basic/ref/v3.4/

and

http://gitbuilder.ceph.com/kernel-deb-precise-x86_64-basic/ref/v3.4/

respectively.

I should note that this problem was also seen on kernel 3.3 from 
gitbuilder with oneiric, though I do not have comparative numbers available.

Mark
