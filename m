From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Re: Bucket name restrictions in RGW
Date: Mon, 15 Jun 2015 22:56:28 +0530
Message-ID: <CAPRac-a=Z=y2ViuHCzVUE1uAMXv+vAH3w05ApojoByCsMkUtXA@mail.gmail.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
 <557B2875.1090505@42on.com> <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
 <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
 <robbat2-20150612T232131-467242919Z@orbis-terrarum.net> <557C9185.1050305@42on.com>
 <87lhfmx3f4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35605 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbbFOR0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 13:26:50 -0400
Received: by wiga1 with SMTP id a1so85044954wig.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 10:26:49 -0700 (PDT)
In-Reply-To: <87lhfmx3f4.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, according to the inputs from the thread, I have included following
changes for adding more restrictions to the RGW bucket name :

1. removed previous boolean flag for specifying bucket naming rule and
added a int option with values 0,1,2

-OPTION(rgw_relaxed_s3_bucket_names, OPT_BOOL, false) // enable
relaxed bucket name rules for US region buckets
+
+/*
+ * RGW Bucket name restriction option. values can be {0,1,2). Default
value is 1.
+ * Setting value as 0 : enable relaxed bucket name rules for US region buckets.
+ * Setting as 1 : name can't start with a non-alphanumeric. rest same
as value =1.
+ * Setting as 2 : further restricts name so as to follow AWS S3
bucket naming conventions for non-standard regions.
+ */
+OPTION(rgw_s3_bucket_names_strictness, OPT_INT, 1)

As per my understanding existing users can change the options in
configuration file anytime, so just by giving an update in
documentation for this, we can enable old users to continue as it is.
Please correct me if I am wrong.

2. As suggested by Robin, added two functions which will take care of
validating bucket name according to the above 3 values, to avoid
repetitive code in
RGWHandler_ObjStore_S3::validate_bucket_name(const string& bucket, int
name_strictness)

You can find the changes here :

https://github.com/ceph/ceph/commit/ae33e144a10d170823641bdf750628857912f656?diff=split

Please review it and if you find it OK, I will go ahead and raise a
pull request.

@Abhishek, I think instead of having two boolean flags with almost
same function, it is better to have only an integer one. With an int
Option, we can further configure more rules in future, if needed. What
is your opinion about it.

Thanks,

On Sun, Jun 14, 2015 at 11:00 AM, Abhishek L
<abhishek.lekshmanan@gmail.com> wrote:
>
> Wido den Hollander writes:
>
>> On 06/13/2015 01:29 AM, Robin H. Johnson wrote:
>>> On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
>>>> Whatever we end up doing, we need to make it configurable, and also
>>>> keep backward compatibility, so that buckets that were created prior
>>>> to such a change will still remain accessible. Some setups would not
>>>> need this limitation and will find it too restricting so I'm not sure
>>>> that it's really that needed. In short, make it configurable.
>>> Configurable:
>>> - Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
>>>   option: 'rgw s3 bucket name create strictness'
>>>   Value '0' => existing 'rgw relaxed s3 bucket names = true' logic
>>>   Value '1' => existing 'rgw relaxed s3 bucket names = false' logic
>>>   Value '2' => compliance with AmazonS3 DNS rules
>
> Alternatively we could just add an opt `rgw s3 bucket name create
> strictness` (maybe `rgw s3 bucket dns comply` instead) as a bool which
> would set your value '2' logic when both `relaxed s3 bucket names` and
> this value are set, so that we dont break backwards compatibility?
>>>
>>> Backwards-Compatibility:
>>> - Make a new option 'rgw s3 bucket name access strictness'
>>>   Same values as above, but used to access buckets, not create new ones.
>>> - Proposed default values:
>>>   rgw s3 bucket name create strictness = 2
>>>   rgw s3 bucket name access strictness = 1
>>>
>>> So you can only create DNS-compliant buckets, but still access your
>>> existing non-compliant buckets. Maybe also have keywords of major
>>> releases and 'relaxed' supported in addition to the integer values.
>>>
>>> I don't like the names of the config keys, but I'm coming up blank on
>>> something that is shorter while still being immediately clear.
>>>
>>
>> Seems like a good plan to me. I would like to restrict them as much as
>> possible, but we shouldn't break anything which is online now.
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>
> --
> Abhishek



-- 
HARSHAL GUPTA
Software Engineer
KIWI Inc.
