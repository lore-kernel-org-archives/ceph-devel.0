From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Mon, 4 Apr 2016 15:14:19 +0300
Message-ID: <57025A9B.700@mirantis.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56FD572D.6070608@mirantis.com>
 <CY1PR0201MB1897E34D0EADBF59212AE047E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33177 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbcDDMOX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 08:14:23 -0400
Received: by mail-lb0-f169.google.com with SMTP id u8so158170578lbk.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2016 05:14:23 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1897E34D0EADBF59212AE047E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 31.03.2016 21:38, Allen Samuels wrote:
>> Another thing to consider is an ability to use introduced checksums for
>> scrubbing. One can probably extend objectstore interface to be able to
>> validate stored data without data sending back.
>> I don't see such an option at the moment. Please correct me if I missed that.
> No need for that option. Just read the data check the return code (good or checksum failure) then discard the data. This is essentially exactly the same code-path as a "please validate the checksum" specialized opcode.
>
I'd rather disagree.
In fact one can perform object verification more effectively when using 
specific op:

- No need for decompression that's present in the read data-path
- No need to select proper read  buffer size. Verify operation can run 
over blob map instead of lextent one and read data by pextents.
- Verify can be done via single op call.
- IMHO code is more elegant and readable having specific op handler. In 
your option one has to Implement  "sub data-path" for read handler to 
discard data and do other optimizations if any... More flags, if 
statements, etc...


