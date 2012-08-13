From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph setup
Date: Mon, 13 Aug 2012 12:29:44 +0200
Message-ID: <5028D718.3030705@widodh.nl>
References: <loom.20120813T064451-323@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40302 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2HMK3q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 06:29:46 -0400
In-Reply-To: <loom.20120813T064451-323@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hemant Surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/13/2012 06:50 AM, Hemant Surale wrote:
> Hi ALL,
>
>
> Can anyone help me out to install ceph. Official site is having many leads and
> thats kind of confusing for a new developer. uptill now I have tried installing
> ceph by following sections listed below
>
> 1) Installing Debian/Ubuntu Packages
> 2) Installing RPM Packages ( here i tried building ceph from tar file)
> 3) Installing Chef
> ..

What do you want to achieve? What I mean, what hardware do you have and 
how big will the cluster be you want to build?

Right now it's probably best practice to run Ubuntu 12.04 with the 
official 0.48 packages, that should work just fine.

Wido

>
>
> Any help is appreciable.
>
> - Hemant Surale.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

