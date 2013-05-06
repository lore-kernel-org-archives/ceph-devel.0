From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 08:23:40 -0500
Message-ID: <5187AEDC.6070202@inktank.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:42650 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab3EFNXq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 09:23:46 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so3227396veb.30
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 06:23:45 -0700 (PDT)
In-Reply-To: <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2013 07:36 AM, Gandalf Corvotempesta wrote:
> 2013/5/6 Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>:
>> To enable the LD_PRELOAD mechanism for the Ceph daemons only, a little
>> generic extension in the global section of /etc/ceph/ceph.conf would
>> be helpful, e.g.:
>>
>> [global]
>>          environment = LD_PRELOAD=/usr/lib64/libsdp.so.1
>>
>> The appending patch adds 5 lines in the Bobtail (0.56.6) init script.
>> The init script will then read the environment setting and - if present -
>> call the Ceph daemons with the preceding environment string.
>
> Cool! We are planning the same infrastructure with IB as networking.
> Could you share more details about this?
>   - which performance are you having and on which hardware?
>   - any issue with IB and SDP?
>   - are you able to use the newer rsockets and not SDP? It also has a
> preloader library and is still developed (SDP is deprecated)

Yeah, that's more or less the conclusion I came to as well.  With SDP 
being deprecated, rsockets is looking like an attractive potential 
alternative.  I'll let Sage or someone comment on the patch though.

It would be very interesting to hear how SDP does.  With IPoIB I've 
gotten about 2GB/s on QDR with Ceph, which is roughly also what I can 
get in an ideal round-robin setup with 2 bonded 10GbE links.

Mark

