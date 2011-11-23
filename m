From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] debian init: Do not stop or start daemons when installing
 or upgrading
Date: Wed, 23 Nov 2011 20:59:24 +0100
Message-ID: <4ECD509C.4020108@widodh.nl>
References: <1321472475-19115-1-git-send-email-wido@widodh.nl> <1321472475-19115-2-git-send-email-wido@widodh.nl> <Pine.LNX.4.64.1111161152550.22555@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42116 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1KWT71 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 14:59:27 -0500
In-Reply-To: <Pine.LNX.4.64.1111161152550.22555@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: gcs@debian.hu, ceph-devel@vger.kernel.org



On 11/16/2011 08:53 PM, Sage Weil wrote:
> Ooh, that would certainly make things less annoying for me as well.
> Unless that's contrary to some debian policy/best practice, Laszlo?
>

Laszlo, have you been able to look at this yet?

Thanks!

Wido

> sage
>
>
> On Wed, 16 Nov 2011, Wido den Hollander wrote:
>
>>
>> Signed-off-by: Wido den Hollander<wido@widodh.nl>
>> ---
>>   debian/rules |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/debian/rules b/debian/rules
>> index a20258d..4f3fe62 100755
>> --- a/debian/rules
>> +++ b/debian/rules
>> @@ -98,7 +98,7 @@ binary-arch: build install
>>   	dh_installexamples
>>   	dh_install --sourcedir=$(DESTDIR) --list-missing
>>   	dh_installlogrotate
>> -	dh_installinit
>> +	dh_installinit --no-start
>>   	dh_installman
>>   	dh_lintian
>>   	dh_link
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
