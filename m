From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 15:53:06 -0800
Message-ID: <CAND_vCbtiHQ=ujGs=UHf2m3HoWud9wS8kj4FpctvaWUDze4GnQ@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
 <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
 <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com> <CAKfXD0x=ujYL9mr09tQzc2UZp4QRszEPyJWp3a+e01dYvsXufA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54977 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1KWXxh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 18:53:37 -0500
Received: by iage36 with SMTP id e36so2249931iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 15:53:37 -0800 (PST)
In-Reply-To: <CAKfXD0x=ujYL9mr09tQzc2UZp4QRszEPyJWp3a+e01dYvsXufA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kelly Kane <kelly@hawknetworks.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Hi Kelly,

I used m1.large instances. I tried both EBS and local storage. I did
IO test on the EBS and local devices. It is not bad. I also tested
HDFS on these instances. it showed much better aggregate writing
throughput. So I guess it is not disk IO problems. Yeah, EC2 disk IO
does have fluctuations, but the throughput is not so bad.

Best,
Xiaofei

On Wed, Nov 23, 2011 at 2:33 PM, Kelly Kane <kelly@hawknetworks.com> wr=
ote:
> On Wed, Nov 23, 2011 at 12:07, Xiaofei Du <xiaofei.du008@gmail.com> w=
rote:
>>
>> I installed Ceph on 10 ec2 instances.
>
> Can you go into more detail about your EC2 instances and where you ar=
e
> storing your data? If you are storing them on standard EBS then you
> are competing for non-guaranteed bandwidth. The information contained
> on the AWS product description page is basically a lie (
> http://aws.amazon.com/ebs/ ) unless things have changed substantially
> since I last used them. =A0If you are storing data on the ephemeral
> disks then unless you are on a "whole machine" instance
> (m1.xlarge/c1.xlarge/m2.4xlarge) you are competing for SATA resources
> on the ephemeral disks. If your machine neighbors are doing some heav=
y
> disk workload you may simply be starved for resources.
>
> Kelly
>



--=20
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
