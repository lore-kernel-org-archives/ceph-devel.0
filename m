From: Abhishek Dixit <dixitabhi@gmail.com>
Subject: Re: Multipart Upload : Limit on no of parts
Date: Sun, 14 Jun 2015 23:43:55 +0530
Message-ID: <CAGoDY9kLTKCH6ArJO3UxXETy=Gt3ayevkTKYEy=mdijDrZyUNg@mail.gmail.com>
References: <CAGoDY9mQJLW99FvNP-JrM-NGHs3k=Fn9BGJBpXRHFvwP5xg=HQ@mail.gmail.com>
 <1525576271.13174633.1434039312262.JavaMail.zimbra@redhat.com>
 <CAGoDY9=Npb-fa5y7tfi4JOcPusT=w4bZQe86BDM491a1ifJ9zQ@mail.gmail.com> <1482089904.13190159.1434040792915.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35531 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbFNSOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Jun 2015 14:14:16 -0400
Received: by pdbnf5 with SMTP id nf5so56689135pdb.2
        for <ceph-devel@vger.kernel.org>; Sun, 14 Jun 2015 11:14:15 -0700 (PDT)
In-Reply-To: <1482089904.13190159.1434040792915.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 11, 2015 at 10:09 PM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Abhishek Dixit" <dixitabhi@gmail.com>
>> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
>> Sent: Thursday, June 11, 2015 9:35:57 AM
>> Subject: Re: Multipart Upload : Limit on no of parts
>>
>> On Thu, Jun 11, 2015 at 9:45 PM, Yehuda Sadeh-Weinraub
>> <yehuda@redhat.com> wrote:
>> >
>> >
>> > ----- Original Message -----
>> >> From: "Abhishek Dixit" <dixitabhi@gmail.com>
>> >> To: "ceph-devel" <ceph-devel@vger.kernel.org>
>> >> Sent: Thursday, June 11, 2015 8:28:14 AM
>> >> Subject: Multipart Upload : Limit on no of parts
>> >>
>> >> Hi,
>> >>
>> >> I was looking into limit imposed on no of uploads for multipart upload.
>> >> The way it works currently seems as below:
>> >> 1. RGWCompleteMultipart::get_params does following
>> >> ______________________________________________
>> >> #define COMPLETE_MULTIPART_MAX_LEN (1024 * 1024) /* api defines max
>> >> 10,000 parts, this should be enough */
>> >>    ret = rgw_rest_read_all_input(s, &data, &len,
>> >>    COMPLETE_MULTIPART_MAX_LEN);
>> >> ___________________________________________________________
>> >>
>> >> 2. rgw_rest_read_all_input compares cl with max_len where
>> >> cl is Content Length value from POST multipart complete request header and
>> >> max_len is COMPLETE_MULTIPART_MAX_LEN as defined above.
>> >>
>> >> 3. For chunked input, again the length read is compared with
>> >> COMPLETE_MULTIPART_MAX_LEN.
>> >>
>> >> For 10104 parts POST request, we had cl:1039762 and max_len:1048576
>> >> which worked.
>> >> Limit on no of parts seems to be imposed by this mechanism rather than
>> >> an explicit parts check.
>> >>
>> >> Kindly let me know if the understanding is correct.
>> >> In case it is, should we not impose a limit via explicit checking for
>> >> total no of parts?
>> >> Also, can we make this parts limit a configurable option via config_opts?
>> >>
>> >
>> > I thought we had an explicit check for that, but I can't really find it, so
>> > I might have gotten it wrong. We should enforce some limit on that number.
>> > First, the way we index the parts in the omap assumes a certain max so it
>> > pads the keys with a specific amount of zeros. Second, in the case where
>> > users are uploading parts with different sizes, the created manifest will
>> > be too large. Is there a real need to have more than 10k parts?
>> >
>> > Yehuda
>>
>> My initial requirement was to bring down the no of the parts allowed
>> and to make it configurable. But since it was not configurable, I had
>> to dig the code to see how part limit is enforced.
>> Also, current implementation is not enforcing it accurately as more
>> than 10000 parts goes through.
>>
>> I think we can make a check on parts->part.size map to be 10000 and we
>> can configure it via config_opts. In this case, final POST call to
>> complete upload would mention all part nos which we can check to be
>> less than allowed limit which could be configurable
>> Please let me know if we can proceed to implement same or if you see
>> some issue in this approach.
>
> Sounds good.

Pull request https://github.com/ceph/ceph/pull/4953 created for above.
Please review

Thanks
Abhishek

>
>
>>
>> Also, can you please review one pull request #4900 for Transaction Id.
>> #4277 got closed due to some git cmd issue from my side.
>>
>
> Sure, I'll get to that soon.
>
> Thanks,
> Yehuda
