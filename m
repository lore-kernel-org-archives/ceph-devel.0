From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 20:45:07 -0500
Message-ID: <51130723.3030101@gmail.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu> <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net> <5112D723.3030500@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:40897 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab3BGBpN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 20:45:13 -0500
Received: by mail-vc0-f182.google.com with SMTP id fl17so1310945vcb.27
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 17:45:12 -0800 (PST)
In-Reply-To: <5112D723.3030500@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: ceph-devel@vger.kernel.org

Dimitri Maziuk wrote:
> (Last I looked "?op=create&poolname=foo" was the Old Busted CGI, The New
> Shiny Hotness(tm) was supposed to look like "/create/foo" -- and I never
> understood how the optional parameters are supposed to work. But that's
> beside the point.)

They're different. One is using the path to interpret functionality; one is using query parameters. The former requires custom path parsing/interpreting code for your particular application; the latter is a very well supported/understood way of getting key/value pairs.

Neither is right or wrong, they're just different. People seem to prefer the path method these days because it seems cleaner/nicer; the other thing people do is just POST the parameters instead of GETting, which lets you still use key/value parameters but not have an ugly URL.

--Jeff
