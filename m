From: Wido den Hollander <wido@42on.com>
Subject: Re: Switch to RBD format 2 by default after Firefly
Date: Tue, 08 Apr 2014 14:57:45 +0200
Message-ID: <5343F249.5010200@42on.com>
References: <5343EFF4.9010808@42on.com> <CALFYKtD1U_-Ckq0VpvDJ3iaqnmBAjGS4VNmRL+SFPdF5+YdnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56191 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbaDHM5s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Apr 2014 08:57:48 -0400
In-Reply-To: <CALFYKtD1U_-Ckq0VpvDJ3iaqnmBAjGS4VNmRL+SFPdF5+YdnGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/08/2014 02:56 PM, Ilya Dryomov wrote:
> On Tue, Apr 8, 2014 at 4:47 PM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> With Ubuntu 14.04 now shipping with the 3.13 kernel it fully supports Format
>> 2 in both librbd and krbd.
>>
>> For RHEL 7 there will be a extra yum repo with a module which supports
>> format 2, so isn't it that that after Firefly we change 'rbd_default_format'
>> to 2?
>>
>> I still see a lot of images being created with format 1 and that will
>> otherwise be hunting us for a long time.
>>
>> I'd vote for making format 2 the default or at least patch the 'rbd' tool to
>> create format 2 images.
>
> Fancy format 2 striping is not supported by krbd.  We've had a couple
> people who confused format 2 support with the ability to set their own
> stripe settings, so we'll need to be more vocal about it.

Ah, that's something I've missed. Never used that in combination with 
krbd. So yes, we need to be more vocal about that.

Maybe even set a warning in the 'rbd' cli tool? Or at least in the 
help/usage.

>
> Thanks,
>
>                  Ilya
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
