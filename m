From: Mike Bryant <mike.bryant@ocado.com>
Subject: Re: mon crash on v0.59
Date: Wed, 3 Apr 2013 10:59:10 +0100
Message-ID: <CAPkekMshcwY=4SEFMcn1EC2HkmumahqeWATJ+e9oeqG-SAnh4w@mail.gmail.com>
References: <CAPkekMtiZSs4q-U1uVDaGvv3vqKfu27d1pPMs1_0sHcsMfsq1Q@mail.gmail.com>
	<515B16A8.6050806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:50125 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755463Ab3DCJ7Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 05:59:24 -0400
Received: by mail-qe0-f72.google.com with SMTP id 1so2249699qec.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 02:59:10 -0700 (PDT)
In-Reply-To: <515B16A8.6050806@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

>
> Hi Mike,
>
> Are you able to reproduce this?  If so, could you set 'debug mon = 10' and
> point me to the logs?
>
>
>   -Joao

I've just had it happen with the debug logging on.
Log: http://xelix.net/ceph/20130403/ceph-mon.hotcpc9039.log

-- 
Notice:  This email is confidential and may contain copyright material of 
Ocado Limited (the "Company"). Opinions and views expressed in this message 
may not necessarily reflect the opinions and views of the Company.

If you are not the intended recipient, please notify us immediately and 
delete all copies of this message. Please note that it is your 
responsibility to scan this message for viruses.

Company reg. no. 3875000.

Ocado Limited
Titan Court
3 Bishops Square
Hatfield Business Park
Hatfield
Herts
AL10 9NE
