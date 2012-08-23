From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-commit] sudo apt-get install radosgw command not working.
Date: Thu, 23 Aug 2012 14:55:54 +0100
Message-ID: <5036366A.5060400@inktank.com>
References: <CAKC2VXpGUywpe6P1S59Paxffy4VOSXN9CUAkRqRBFxthdnE_oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37228 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030334Ab2HWN40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 09:56:26 -0400
Received: by eeil10 with SMTP id l10so287602eei.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Aug 2012 06:56:25 -0700 (PDT)
In-Reply-To: <CAKC2VXpGUywpe6P1S59Paxffy4VOSXN9CUAkRqRBFxthdnE_oQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: RamuNaidu Eppa <eppa.ramu@gmail.com>
Cc: ceph-commit@lists.ceph.newdream.net, ceph-devel@vger.kernel.org

On 08/23/2012 06:02 AM, RamuNaidu Eppa wrote:
> Hi all,
> 
>    I want to install radosgw,ifollwed the steps
> "http://ceph.com/docs/master/radosgw/manual-install/" but after i tried
> the command "sudo apt-get install radosgw"
> was not working it is showing error,
> Reading package lists... Done
> Building dependency tree       
> Reading state information... Done
> E: Unable to locate package radosgw
> So please help me to install radosgw and also i want to install s3.
> 
> Thanks,
> Ramu

This email's place is definitely the ceph-devel list (also CC'ed).

Regarding the radosgw package, it should be available on Ubuntu 12.04.
Maybe you need to update your apt package list (apt-get update)?

Alternatively you could use ceph's own repository
(http://ceph.com/debian). A quick 5-minute guide is available in

http://ceph.com/docs/master/start/quick-start/

  -Joao

