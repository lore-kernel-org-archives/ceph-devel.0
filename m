From: Huamin Chen <hchen@redhat.com>
Subject: Re: assert failure
Date: Fri, 15 Aug 2014 17:36:51 -0400 (EDT)
Message-ID: <178229523.21856716.1408138611841.JavaMail.zimbra@redhat.com>
References: <1229494305.20638287.1407961759048.JavaMail.zimbra@redhat.com> <BLU437-SMTP55D87E766F90EFADF2BDA0DFE80@phx.gbl> <2101679920.20989042.1408029715043.JavaMail.zimbra@redhat.com> <BLU436-SMTP20F2D351F8BDE3C60C9E39DFE90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57324 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaHOVgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 17:36:53 -0400
In-Reply-To: <BLU436-SMTP20F2D351F8BDE3C60C9E39DFE90@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Thanks. I was running a single node ceph fs cluster on a VM. Each time the VM is created, it downloads the latest bits and runs unit tests. There are many mount and unmount during the tests.
This issue can be reliably reproduced in one of these tests.

The test info can be found https://github.com/rootfs/tachyon/tree/wip-ceph/vagrant/ceph/README.md


----- Original Message -----
From: "Guang Yang" <yguang11@outlook.com>
To: "Huamin Chen" <hchen@redhat.com>
Cc: "Ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Friday, August 15, 2014 2:23:12 PM
Subject: Re: assert failure

+ ceph-devel.

Hi Huamin,
Did you upgrade the entire cluster to v0.80.5? If I remember correctly, if its peer has the old version, it could crash the new version as well.

Thanks,
Guang

On Aug 14, 2014, at 11:21 PM, Huamin Chen <hchen@redhat.com> wrote:

> Bad news, still there ...
> msg/Pipe.cc: In function 'int Pipe::connect()' thread 7f30c4511700 time 2014-08-14 15:16:44.659312
> msg/Pipe.cc: 1080: FAILED assert(m)
> ceph version 0.80.5 (38b73c67d375a2552d8ed67843c8a65c2c0feba6)
> 1: (Pipe::connect()+0x3d0c) [0x7f327552a2ac]
> 2: (Pipe::writer()+0x9f3) [0x7f327552aff3]
> 3: (Pipe::Writer::entry()+0xd) [0x7f327553748d]
> 4: (()+0x79d1) [0x7f32953449d1]
> 5: (clone()+0x6d) [0x7f3294c89b5d]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> 
> Attached please find all related logs
> 
> ----- Original Message -----
> From: "Guang Yang" <yguang11@outlook.com>
> To: "Huamin Chen" <hchen@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Wednesday, August 13, 2014 10:39:10 PM
> Subject: Re: assert failure
> 
> Hi Huamin,
> At least one known issue in 0.80.1 with the same failing pattern has been fixed in the latest 0.80.4 release of firefly. Here is the tracking ticket - http://tracker.ceph.com/issues/8232.
> 
> Can you compare the log snippets from within the bug and see if they are the same issue?
> 
> Thanks,
> Guang
> 
> On Aug 14, 2014, at 4:29 AM, Huamin Chen <hchen@redhat.com> wrote:
> 
>> Is the following assert failure an known issue?
>> 
>> msg/Pipe.cc: In function 'int Pipe::connect()' thread 7fed3d2dd700 time 2014-08-13 16:26:06.039799
>> msg/Pipe.cc: 1070: FAILED assert(m)
>> ceph version 0.80.1 (a38fe1169b6d2ac98b427334c12d7cf81f809b74)
>> 1: (Pipe::connect()+0x390e) [0x7feee89cf99e]
>> 2: (Pipe::writer()+0x511) [0x7feee89d0fd1]
>> 3: (Pipe::Writer::entry()+0xd) [0x7feee89d5d0d]
>> 4: (()+0x7df3) [0x7fef336cadf3]
>> 5: (clone()+0x6d) [0x7fef32fe63dd]
>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 
> <ceph-error-log.tgz>

