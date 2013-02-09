From: Wido den Hollander <wido@42on.com>
Subject: Re: Links to various language bindings
Date: Sat, 09 Feb 2013 10:50:02 +0100
Message-ID: <51161BCA.6060005@42on.com>
References: <5114BFFD.1060807@widodh.nl> <7ADDC8C0-BB74-44DC-8BE7-2837796DDCCF@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:36815 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab3BIJ6i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 04:58:38 -0500
In-Reply-To: <7ADDC8C0-BB74-44DC-8BE7-2837796DDCCF@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Noah,

On 02/08/2013 04:42 PM, Noah Watkins wrote:
>
> On Feb 8, 2013, at 1:06 AM, Wido den Hollander <wido@widodh.nl> wrote:
>
>> Hi,
>>
>> I knew that there were Java bindings for RADOS, but they weren't linked.
>>
>> Well, some searching on Github lead me to Noah's bindings [0], but it was a bit of searching.
>
> The RADOS Java bindings on my Github page should be taken down--they are very old and not stable. Any links to it should probably be taken down. If there is interest in the RADOS Java bindings, I'd be happy to get that ball rolling.
>

Could you then update the README?

I did a quick test yesterday with them and they worked fine, but I just 
created a Cluster object and a pool, didn't do anything fancy.

rados4j is also on Github, does anyone know the status of that?

Anyway, what about making these language bindings more clear to end 
users so they can experience the full power of RADOS?

Wido

> - Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
