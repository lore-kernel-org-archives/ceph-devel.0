From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Re: Bucket name restrictions in RGW
Date: Fri, 19 Jun 2015 09:43:53 +0530
Message-ID: <CAPRac-aaq-8eaxrH2D3SUAiKg9UGDEwrCKkuE2X5Mk0E=QknjA@mail.gmail.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
 <557B2875.1090505@42on.com> <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
 <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
 <robbat2-20150612T232131-467242919Z@orbis-terrarum.net> <557C9185.1050305@42on.com>
 <87lhfmx3f4.fsf@gmail.com> <CAPRac-a=Z=y2ViuHCzVUE1uAMXv+vAH3w05ApojoByCsMkUtXA@mail.gmail.com>
 <CAPRac-Z7QvMTmsj-CyQZwmxgBnrydxXomQmddvX8SgUkdGphzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35955 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbFSEOP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 00:14:15 -0400
Received: by wguu7 with SMTP id u7so7060203wgu.3
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 21:14:13 -0700 (PDT)
In-Reply-To: <CAPRac-Z7QvMTmsj-CyQZwmxgBnrydxXomQmddvX8SgUkdGphzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Wido den Hollander <wido@42on.com>, "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I will be raising a pull request. Please merge the code if you feel
everything fine.

On Thu, Jun 18, 2015 at 11:28 PM, Harshal Gupta
<harshal.gupta001@gmail.com> wrote:
> Hi,
> I collaborated with Robin on this and finally came with the
> implementation which will provide backward compatibility for the
> existing users and is configurable for new users.
>
> Also the strictness levels can be further extended if we wish to
> further impose more restrictions over naming convention of buckets.
> The current solutions is as follows:
>
> 1. Created two configurable options.
> a. rgw_s3_bucket_name_access_strictness b. rgw_s3_bucket_name_create_strictness
> Both can have values 0, 1 and 2 which signifies :
> 0 - Follows same validation rules as already present with flag
> relaxed_name=true.
> 1 - Follows same validation rules as already present with flag
> relaxed_names=false.
> 2 - Follows new naming rules as per DNS compliance. (similar to what S3 follows)
>
> 2. Users can configure both flags independently so as to access
> already created buckets and to create new buckets, with creation
> always more or equally stricter than access. and can pass those
> options in existing
> RGWHandler_ObjStore_s3::validate_bucket_name(bucket, relaxed_names) in
> place of 'relaxed_names' and appropriate checks will be then applied
> to bucket name depending upon the value of strictness option.
>
> 3. Implemented a new method call to
> RGWHandler_ObjStore_s3::validate_bucket_name(bucket, name_strictness)
> from RGWCreateBucket::pre_exec() so as to avoid interference with
> already running functionality. This call will pass create strictness
> option for further validation of bucket name specifically for
> creation, based on the configured create strictness level
>
> 4. Added virtual method validate_bucket_name(const string&, int) in
> RGWHandler for polymorphism and compile time check.
>
> You can find the changes here :
>
> https://github.com/ceph/ceph/compare/master...harshalgupta:wip-bucket_name_restrictions
>
> Please review it and let me know your concerns and suggestions. I am
> thinking about raising a pull request by EOD.
>
> Thanks,
>
> On Mon, Jun 15, 2015 at 10:56 PM, Harshal Gupta
> <harshal.gupta001@gmail.com> wrote:
>> Hi, according to the inputs from the thread, I have included following
>> changes for adding more restrictions to the RGW bucket name :
>>
>> 1. removed previous boolean flag for specifying bucket naming rule and
>> added a int option with values 0,1,2
>>
>> -OPTION(rgw_relaxed_s3_bucket_names, OPT_BOOL, false) // enable
>> relaxed bucket name rules for US region buckets
>> +
>> +/*
>> + * RGW Bucket name restriction option. values can be {0,1,2). Default
>> value is 1.
>> + * Setting value as 0 : enable relaxed bucket name rules for US region buckets.
>> + * Setting as 1 : name can't start with a non-alphanumeric. rest same
>> as value =1.
>> + * Setting as 2 : further restricts name so as to follow AWS S3
>> bucket naming conventions for non-standard regions.
>> + */
>> +OPTION(rgw_s3_bucket_names_strictness, OPT_INT, 1)
>>
>> As per my understanding existing users can change the options in
>> configuration file anytime, so just by giving an update in
>> documentation for this, we can enable old users to continue as it is.
>> Please correct me if I am wrong.
>>
>> 2. As suggested by Robin, added two functions which will take care of
>> validating bucket name according to the above 3 values, to avoid
>> repetitive code in
>> RGWHandler_ObjStore_S3::validate_bucket_name(const string& bucket, int
>> name_strictness)
>>
>> You can find the changes here :
>>
>> https://github.com/ceph/ceph/commit/ae33e144a10d170823641bdf750628857912f656?diff=split
>>
>> Please review it and if you find it OK, I will go ahead and raise a
>> pull request.
>>
>> @Abhishek, I think instead of having two boolean flags with almost
>> same function, it is better to have only an integer one. With an int
>> Option, we can further configure more rules in future, if needed. What
>> is your opinion about it.
>>
>> Thanks,
>>
>> On Sun, Jun 14, 2015 at 11:00 AM, Abhishek L
>> <abhishek.lekshmanan@gmail.com> wrote:
>>>
>>> Wido den Hollander writes:
>>>
>>>> On 06/13/2015 01:29 AM, Robin H. Johnson wrote:
>>>>> On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
>>>>>> Whatever we end up doing, we need to make it configurable, and also
>>>>>> keep backward compatibility, so that buckets that were created prior
>>>>>> to such a change will still remain accessible. Some setups would not
>>>>>> need this limitation and will find it too restricting so I'm not sure
>>>>>> that it's really that needed. In short, make it configurable.
>>>>> Configurable:
>>>>> - Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
>>>>>   option: 'rgw s3 bucket name create strictness'
>>>>>   Value '0' => existing 'rgw relaxed s3 bucket names = true' logic
>>>>>   Value '1' => existing 'rgw relaxed s3 bucket names = false' logic
>>>>>   Value '2' => compliance with AmazonS3 DNS rules
>>>
>>> Alternatively we could just add an opt `rgw s3 bucket name create
>>> strictness` (maybe `rgw s3 bucket dns comply` instead) as a bool which
>>> would set your value '2' logic when both `relaxed s3 bucket names` and
>>> this value are set, so that we dont break backwards compatibility?
>>>>>
>>>>> Backwards-Compatibility:
>>>>> - Make a new option 'rgw s3 bucket name access strictness'
>>>>>   Same values as above, but used to access buckets, not create new ones.
>>>>> - Proposed default values:
>>>>>   rgw s3 bucket name create strictness = 2
>>>>>   rgw s3 bucket name access strictness = 1
>>>>>
>>>>> So you can only create DNS-compliant buckets, but still access your
>>>>> existing non-compliant buckets. Maybe also have keywords of major
>>>>> releases and 'relaxed' supported in addition to the integer values.
>>>>>
>>>>> I don't like the names of the config keys, but I'm coming up blank on
>>>>> something that is shorter while still being immediately clear.
>>>>>
>>>>
>>>> Seems like a good plan to me. I would like to restrict them as much as
>>>> possible, but we shouldn't break anything which is online now.
>>>>
>>>> --
>>>> Wido den Hollander
>>>> 42on B.V.
>>>> Ceph trainer and consultant
>>>>
>>>> Phone: +31 (0)20 700 9902
>>>> Skype: contact42on
>>>
>>> --
>>> Abhishek
>>
>>
>>
>> --
>> HARSHAL GUPTA
>> Software Engineer
>> KIWI Inc.
>
>
>
> --
> HARSHAL GUPTA
> Software Engineer
> KIWI Inc.



-- 
HARSHAL GUPTA
Software Engineer
KIWI Inc.
