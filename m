From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: mon crash on v0.59
Date: Tue, 02 Apr 2013 18:34:32 +0100
Message-ID: <515B16A8.6050806@inktank.com>
References: <CAPkekMtiZSs4q-U1uVDaGvv3vqKfu27d1pPMs1_0sHcsMfsq1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58426 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab3DBRfT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 13:35:19 -0400
Received: by mail-wi0-f181.google.com with SMTP id hj8so702233wib.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 10:35:17 -0700 (PDT)
In-Reply-To: <CAPkekMtiZSs4q-U1uVDaGvv3vqKfu27d1pPMs1_0sHcsMfsq1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Bryant <mike.bryant@ocado.com>
Cc: ceph-devel@vger.kernel.org

On 04/02/2013 06:08 PM, Mike Bryant wrote:
> Hi,
> I experienced a crash today on 2 out of my 3 monitors, leaving the cluster
> down.
>
> Logs have been uploaded here:
> http://xelix.net/ceph-mon.hotcpc9882.log (crashed)
> http://xelix.net/ceph-mon.hotcpc9039.log (crashed)
> http://xelix.net/ceph-mon.hotcpc12533.log (survived)
>
> Cheers
> Mike
>

Hi Mike,

Are you able to reproduce this?  If so, could you set 'debug mon = 10' 
and point me to the logs?


   -Joao
