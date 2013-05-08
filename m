From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Cuttlefish installation on debian 6.0 squeeze depends on cryptsetup-bin
Date: Wed, 8 May 2013 08:39:49 -0700
Message-ID: <6ADBB999-4C42-4B7F-ACDE-831589FF3F41@inktank.com>
References: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39224 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab3EHPjv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 11:39:51 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so1327851pdj.13
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 08:39:51 -0700 (PDT)
In-Reply-To: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henning Verbeek <hankipanky@gmail.com>
Cc: ceph-devel@vger.kernel.org

Thanks for letting us know.  I'll incorporate Wido's fix.

Cheers,
Gary

On May 8, 2013, at 1:09 AM, Henning Verbeek wrote:

> Dear ceph developers,
> 
> I just tried to upgrade my ceph installation from bobtail to
> cuttlefish on a debian 6.0 squeeze installation. The installation of
> package 'ceph' failed due to missing package 'cryptsetup-bin':
> 
>  $ sudo apt-get -y install ceph
>  Reading package lists... Done
>  Building dependency tree
>  Reading state information... Done
>  Some packages could not be installed. This may mean that you have
>  requested an impossible situation or if you are using the unstable
>  distribution that some required packages have not yet been created
>  or been moved out of Incoming.
>  The following information may help to resolve the situation:
> 
>  The following packages have unmet dependencies:
>   ceph : Depends: cryptsetup-bin but it is not installable
>          Recommends: ceph-mds but it is not going to be installed
>  E: Broken packages
> 
> Package 'cryptsetup-bin' is available only from wheezy onwards:
> http://packages.debian.org/search?keywords=cryptsetup-bin
> 
> On squeeze, the package is called 'cryptsetup'.
> 
> Can I suggest that the dependency be changed for the squeeze packages?
> Thank you.
> 
> Cheers,
> Henning
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

