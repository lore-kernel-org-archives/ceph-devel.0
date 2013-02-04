From: "aleonov@nazarianin.com" <aleonov@nazarianin.com>
Subject: Re: Maintenance mode
Date: Mon, 04 Feb 2013 13:40:20 +0600
Message-ID: <510F65E4.1050404@nazarianin.com>
References: <CAEqYNSaOVFQyYaN=e0JeBBvj7r3hnjc3f=gtw3_HQsSsxJBLFw@mail.gmail.com> <16B6063F84B648D2BC7A4B01D365C070@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33466 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab3BDHkd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 02:40:33 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so4331964lab.31
        for <ceph-devel@vger.kernel.org>; Sun, 03 Feb 2013 23:40:27 -0800 (PST)
In-Reply-To: <16B6063F84B648D2BC7A4B01D365C070@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi All,

I have "slow requests" when set one of two osd  in "noout" and restart 
server. What can I do to safely shut down the server?

-Alex
> Try "ceph osd set noout" beforehand and then "ceph osd unset noout". That will prevent any OSDs from getting removed from the mapping, so no data will be rebalanced. I don't think there's a way to prevent OSDs from getting zapped on an individual basis, though.
> This is described briefly in the docs at http://ceph.com/docs/master/rados/operations/troubleshooting-osd/?highlight=noout, though it could probably be a bit more clear.
> -Greg
>
>
>

