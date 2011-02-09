From: Hannu Valtonen <me@ormod.com>
Subject: Re: Python-rados announcement
Date: Wed, 09 Feb 2011 21:38:58 +0200
Message-ID: <4D52ED52.1070202@ormod.com>
References: <4D4E9B93.2070901@ormod.com> <AANLkTimqmEa6TbXXxKmscXgJPmGGE69nmHf1bsiRXF_m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:52865 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab1BITjF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Feb 2011 14:39:05 -0500
In-Reply-To: <AANLkTimqmEa6TbXXxKmscXgJPmGGE69nmHf1bsiRXF_m@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On 2/9/11 9:32 PM, Colin McCabe wrote:
Hi,

Ceph's licensing is actually the reason I went for LGPL.

But anyway, as for merging, yeah, sounds good to me.

- Hannu

> Hi Hannu,
>
> This looks like a good start. Since it's under LGPL 2.1 (same license
> as Ceph), we'd like to merge it into Ceph so that the python bindings
> can be used by all. What do you think?
>
> cheers,
> Colin
>
>
> On Sun, Feb 6, 2011 at 5:01 AM, Hannu Valtonen<me@ormod.com>  wrote:
>> Hello,
>>
>> I wrote a basic Python ctypes librados wrapper:
>> https://github.com/Ormod/python-rados
>>
>> It's in very initial stages of development and only supports things like
>> write/read/deletes at this stage.
>>
>> Any patches/bugs/ideas are welcome and can be sent my way.
>>
>> - Hannu Valtonen
>> hannu.valtonen@ormod.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

