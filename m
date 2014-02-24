From: Joe Landman <landman@scalableinformatics.com>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 16:30:04 -0500
Message-ID: <530BB9DC.1070305@scalableinformatics.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net> <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com> <530BB920.1040605@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:59357 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaBXVaG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 16:30:06 -0500
Received: by mail-ig0-f182.google.com with SMTP id l13so641492iga.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 13:30:06 -0800 (PST)
In-Reply-To: <530BB920.1040605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Jean-Charles LOPEZ <jc.lopez@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/24/2014 04:26 PM, Loic Dachary wrote:
>
>
> On 24/02/2014 21:59, Jean-Charles LOPEZ wrote:
>> Hi Sage,
>>
>> I think this is a great idea.
>>
>> However, I would recommend that two options to be available: 1)
>> First options is a standalone package as you describe it 2) Second
>> option is a prepackaged VM in OVA format people can just download
>> and import using VirtualBox, Fusion or VMWarePlayer.
>>
> Hi Jean-Charles,
>
> I like the idea of a ready-to-run VM. The "raw" format (i.e. a file
> which is a disk with partitions and bootloader) is universal and all
> hypervisor/cloud infrastructures are able to load it natively.
>
> My 2cts ;-)

Are you looking for someone to work on building this (VM) or a script to 
generate one?  Or a script to build a simple to play with getup?



-- 
Joseph Landman, Ph.D
Founder and CEO
Scalable Informatics, Inc.
email: landman@scalableinformatics.com
web  : http://scalableinformatics.com
twtr : @scalableinfo
phone: +1 734 786 8423 x121
cell : +1 734 612 4615
