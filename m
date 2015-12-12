From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Re: Rbd map failure in 3.16.0-55
Date: Sat, 12 Dec 2015 19:10:45 +0000
Message-ID: <66E92FE2-8E0F-44EE-974E-FCA656932A36@sandisk.com>
References: <BLUPR0201MB1908E516F6CE6529654476ECE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
	<CAOi1vP9=szuwrgLjaqXa9Pq6CrwLhKu-J0D4_xCQQi_h_-VhYQ@mail.gmail.com>
	<CO1PR02MB2085A0DBA135C58BFB94441F4EB0@CO1PR02MB208.namprd02.prod.outlook.com>,<CAOi1vP_hjcp4rs+hZRHekVjmoWK7U0T60Gbx1WjXfcbwf9hu7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0070.outbound.protection.outlook.com ([157.56.110.70]:13805
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752246AbbLLTKu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Dec 2015 14:10:50 -0500
In-Reply-To: <CAOi1vP_hjcp4rs+hZRHekVjmoWK7U0T60Gbx1WjXfcbwf9hu7A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, this happened post Giant..So far our testing was with disabled crc...we will check the impact with crc and let you know..Initially when we started it was bad but porting to new instruction set improved crc could time significantly..we r yet to test that out end-to-end..Also, having that crc enabled is recommended..we will come back for your help if it is really hurting performance..

Thanks 
Somnath

Sent from my iPhone

> On Dec 12, 2015, at 10:56 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
>> On Sat, Dec 12, 2015 at 6:42 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Ilya,
>> If we map with 'nocrc' would that help ?
> 
> No, it will disable data crcs, header and middle crcs will still be
> checked.  The header/data separation in userspace is fairly new, if
> that's something you care about, I can port it for 4.5 - it should be
> trivial enough.
> 
> Thanks,
> 
>                Ilya
