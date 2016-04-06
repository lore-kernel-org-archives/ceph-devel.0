From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Wed, 6 Apr 2016 09:15:32 +0200
Message-ID: <CABZ+qqmjbD_75X93Mef4pqHkYFyuEvrsOFXiJH=SJqYi=3BqEQ@mail.gmail.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au> <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au> <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au> <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au> <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au> <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <CABZ+qqkEMrWeQvgYC7eTsXvZY5zECaV7VC0nNiK8BfSSzfU+RQ@mail.gmail.com> <CY1PR0201MB1897166E1328EF7895DD8136E89E0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35468 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbcDFHQR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 03:16:17 -0400
Received: by mail-lf0-f45.google.com with SMTP id c126so27254103lfb.2
        for <ceph-devel@vger.kernel.org>; Wed, 06 Apr 2016 00:16:16 -0700 (PDT)
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com. [209.85.217.182])
        by smtp.gmail.com with ESMTPSA id um4sm256640lbb.1.2016.04.06.00.16.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 00:16:12 -0700 (PDT)
Received: by mail-lb0-f182.google.com with SMTP id vo2so24016743lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 Apr 2016 00:16:12 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1897166E1328EF7895DD8136E89E0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 5, 2016 at 10:50 PM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
> If messenger is doing CRC-32, then it's probably not yielding as much value as you would like. That's because the NIC has ALREADY done a CRC-32 on data over the wire. Doing the extra CRC in software will certainly help verify that the NIC, PCIe bus, DRAM system is working well -- but the real value is an end-to-end integrity check of the software (i.e., most likely failure is a software failure). You don't need a CRC for that. However, CRC is cheap enough not to worry.

It would depend in which layer the corruption was introduced. crc32 is
in the ethernet frame, AFAIK. We've observed corrupted packets where
the TCP checksum validated but the data was clearly corrupted [1].
Ceph messenger crc32c helped in that case, but from this discussion
it's not strong enough to detect all levels of corruptions in long
messages.

> As for scrub, it's different -- presumably you're already downstream of the HW ECC and whatever strong checksums you put on BlueStore. Totally different discussion. Plus, many of the "failure" modes here aren't actual failures. In other words some of the failures don't deliver corrupt data, they just rebuild data that was already good :)

I was referring to deep scrub of the non-bluestores. Perhaps FileStore
deep-scrub needs to be stronger than crc32c.

-- Dan

[1] http://cds.cern.ch/record/2026187/
