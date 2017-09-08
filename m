From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 8 Sep 2017 20:02:23 +0300
Message-ID: <ac9fc2eb-7ac9-e4b3-394d-8b6a0809a57e@kirneh.eu>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal>
 <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
 <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com>
 <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:57204 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdIHRCb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 8 Sep 2017 13:02:31 -0400
In-Reply-To: <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>, Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On 17-09-08 18:59, Xiaoxi Chen wrote:
> CPU and Disk are fairly idle.
> I didnt use gdbprof but enable debug log seems it is not hanging. Also
> "gdb thread apply all bt" shows nothing intresting , all threads are
> waiting on condition for job.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

just an additional data point: I had Luminous cluster backfilling at few 
GB/s rate (when I changed mapping to include racks, almost everything 
remapped). Maybe problem is filestore<->bluestore interraction?

