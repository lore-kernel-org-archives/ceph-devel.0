From: Wido den Hollander <wido@widodh.nl>
Subject: Re: UBUNTU kernel version and ceph 0.51 compatibility
Date: Mon, 05 Nov 2012 12:09:16 +0100
Message-ID: <50979E5C.1020007@widodh.nl>
References: <CAGfy=6nbGBRL+-1H3zqQD-dSjenE5e3-EJnyB7pX3AumwxwYag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56402 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab2KELKj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 06:10:39 -0500
In-Reply-To: <CAGfy=6nbGBRL+-1H3zqQD-dSjenE5e3-EJnyB7pX3AumwxwYag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 05-11-12 05:55, hemant surale wrote:
> Hi Community,
>      I want to know that is there any compatibility chart between
> UBUNTU kernel version & ceph v 0.51 ?
>      Or does anyone know best suite kernel version of UBUNTU with ceph v0.51.
>      Till now I was working with UBUNTU 12.04 kernel 3.2.0 . But want
> to know that is it ok if I move to UBUNTU kernel v 3.6.2. + ceph
> v0.51.

The 3.6 kernel should work just fine with both the Ceph OSD and the 
CephFS filesystem.

On the #cephday I had a Ubuntu 12.04 system running with a backported 
3.6 kernel, both btrfs and cephfs worked fine with 3.6

It depends on your use-case, but there is no chart which tells you what 
works and what doesn't.

If you are going to use XFS as a filesystem behind your OSDs you don't 
need to run a bleeding-edge kernel.

Wido

>
>
> Thanks & Regards,
> Hemant Surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
