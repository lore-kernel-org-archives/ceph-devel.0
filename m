From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: CEPH HEALTH NOT OK ceph version 0.56.2.!!!
Date: Mon, 04 Feb 2013 14:27:13 +0000
Message-ID: <510FC541.8060301@inktank.com>
References: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46861 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab3BDO1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 09:27:52 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so3349595eek.33
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 06:27:50 -0800 (PST)
In-Reply-To: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org

This wasn't obvious due to all the debug being outputted, but here's why 
'ceph health' wasn't replying with HEALTH_OK:

On 02/04/2013 12:21 PM, femi anjorin wrote:
> 2013-02-04 12:56:15.818985 7f149bfff700  1 HEALTH_WARN 4987 pgs
> peering; 4987 pgs stuck inactive; 5109 pgs stuck unclean

Furthermore, on your other email in which you ran 'ceph health detail', 
this appear to have gone away, as it is replying with HEALTH_OK again.

You might want to set '--debug-ms 0' when you run 'ceph', or set it in 
your ceph.conf, leaving it at a higher level only for daemons (i.e., 
under [mds], [mon], [osd]...).  The resulting output will be clearer and 
more easily understandable.

   -Joao

