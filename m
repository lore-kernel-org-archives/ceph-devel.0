From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: maximum key size
Date: Wed, 11 Feb 2015 22:49:52 +0800
Message-ID: <CACJqLyYLBnj_R3vgNzFWq3d8qKMqkuJtY2GLYwg2gEe=ZqXW6g@mail.gmail.com>
References: <88C3E003BB3649489ED4ECA6C8041047744801@ORSMSX102.amr.corp.intel.com>
	<CACJqLyZO4goqqPcqDFsHN5xPiOEV670zwzDcGkR-At1ALV-btw@mail.gmail.com>
	<88C3E003BB3649489ED4ECA6C8041047744D12@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:65217 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbBKOtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 09:49:53 -0500
Received: by mail-we0-f178.google.com with SMTP id w62so3874073wes.9
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 06:49:52 -0800 (PST)
In-Reply-To: <88C3E003BB3649489ED4ECA6C8041047744D12@ORSMSX102.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Cook, Nigel" <nigel.cook@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Whatever RBD or object gateway, omap key always used by internal
usage. So the typical key length should be within 100 bytes.

On Wed, Feb 11, 2015 at 10:46 PM, Cook, Nigel <nigel.cook@intel.com> wrote:
> In RBD and Object gateway use cases, can you tell me what the typical key length is?
>
> What is the object name used for vs the omap key?
>
> Regards,
> Nigel Cook
> Intel Fellow & Cloud Chief Architect
> Cloud Platforms Group
> Intel Corporation
> +1 720 319 7508
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Tuesday, February 10, 2015 10:17 PM
> To: Cook, Nigel
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: maximum key size
>
> Hmm, we have object name length limit(osd_max_object_name_len) and attr name length limit(osd_max_attr_name_len) for config and ObjectStore impl setting, but we don't have any limit for omap key length.
>
>
> On Wed, Feb 11, 2015 at 12:47 PM, Cook, Nigel <nigel.cook@intel.com> wrote:
>> Folks,
>>
>> A quick question...
>>
>> In a CEPH OSD ObjectStore implementation, what is the maximum length of the "key" in the key/value store?
>>
>> Regards,
>> Nigel Cook
>> Intel Fellow & Cloud Chief Architect
>> Cloud Platforms Group
>> Intel Corporation
>> +1 720 319 7508
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
