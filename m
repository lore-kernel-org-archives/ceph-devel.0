From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: c++17: compilation failures with cryptopp (when cmake -DWITH_NSS=OFF)
Date: Wed, 17 Jan 2018 14:00:23 -0800
Message-ID: <CADRKj5S_0iAJhfNHO0OHhUmnhcPpCm8HrOnLBnK=RWb8Jj84Qg@mail.gmail.com>
References: <0e6e3365-714d-0752-db17-6b823185451a@redhat.com>
 <CAJ4mKGbmw7dSpeY7nU=w7SoquOq0=r6qmtC9RopwpQRyaNNN5g@mail.gmail.com>
 <CADRKj5SnojKXR8UQoAbdBvATQMeJWzLvnrDv_2qm1q96Vu6_HA@mail.gmail.com> <CAKOnarmf1TBtEdt0aJYesgjWK_v-4GnGE1o+RkwaKaxnYzBHTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43633 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeAQWAZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 17:00:25 -0500
Received: by mail-oi0-f49.google.com with SMTP id t16so14211431oif.10
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 14:00:25 -0800 (PST)
In-Reply-To: <CAKOnarmf1TBtEdt0aJYesgjWK_v-4GnGE1o+RkwaKaxnYzBHTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

At this point, probably better than the c++17 platform portability.
But I'm not qualified to answer.

On Wed, Jan 17, 2018 at 1:59 PM, Matt Benjamin <mbenjami@redhat.com> wrote:
> Just offhand, what does platform portability of NSS look like?
>
> Matt
>
> On Wed, Jan 17, 2018 at 4:54 PM, Yehuda Sadeh-Weinraub
> <ysadehwe@redhat.com> wrote:
>> On Wed, Jan 17, 2018 at 11:33 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Wed, Jan 17, 2018 at 10:36 AM, Casey Bodley <cbodley@redhat.com> wrote:
>>>> I'm trying to pick up Adam's crypto rework branch
>>>> (https://github.com/ceph/ceph/pull/14498), and found that our cryptopp
>>>> implementation was broken with the switch to c++17. Cryptopp adds a 'typedef
>>>> unsigned char byte' to the global namespace that conflicts with std::byte
>>>> whenever 'using namespace std' is present (which is almost everywhere in
>>>> ceph).
>>>>
>>>> I've been able to fix some parts of the codebase by shuffling around the
>>>> #include order for ceph_crypto.h to get it above any other ceph headers. For
>>>> radosgw, though, it's included by rgw_common.h and pulled into every source
>>>> file. I worry that if I go through and fix everything so it builds, it will
>>>> just break again without regular testing.
>>>>
>>>> Do we know of anyone that still relies on this cryptopp implementation? It
>>>> doesn't look like we use it in any of our packaging.
>>>
>>> Searching through my mail we discussed removing cryptopp in summer
>>> 2016 (subject "remove cryptopp support?"), and it looks like we only
>>> kept it in because it was easy and Matt and Marcus didn't like going
>>> all-in on NSS.
>>>
>>> But I think the only reason we ever had cryptopp was because it was an
>>> easier library to program against, and once we had the NSS
>>> implementation we shifted to it thanks to the certifications involved.
>>
>> Kinda, it was definitely easier to use, and didn't have the license
>> issues that we had with openssl iirc. We weren't even aware of nss
>> when we started using it, and it was definitely easier to use. The
>> need for nss came because of certification issues.
>>
>>> And I'm not seeing any real references to it in the last several years
>>
>> Yeah, if no one objects.
>>
>> Yehuda
>>
>>> in our archives. So I think you should just zap it away. :)
>>> -Greg
>>>
>>>>
>>>>
>>>> Example compilation failure:
>>>>
>>>> In file included from /usr/include/cryptopp/iterhash.h:4:0,
>>>>                  from /usr/include/cryptopp/md5.h:4,
>>>>                  from /home/cbodley/ceph/src/common/ceph_crypto.h:15,
>>>>                  from /home/cbodley/ceph/src/common/ceph_context.cc:27:
>>>> /usr/include/cryptopp/cryptlib.h:523:28: error: reference to ‘byte’ is
>>>> ambiguous
>>>>   virtual void SetKey(const byte *key, size_t length, const NameValuePairs
>>>> &params = g_nullNameValuePairs);
>>>> ^~~~
>>>> In file included from /usr/include/cryptopp/cryptlib.h:86:0,
>>>>                  from /usr/include/cryptopp/iterhash.h:4,
>>>>                  from /usr/include/cryptopp/md5.h:4,
>>>>                  from /home/cbodley/ceph/src/common/ceph_crypto.h:15,
>>>>                  from /home/cbodley/ceph/src/common/ceph_context.cc:27:
>>>> /usr/include/cryptopp/config.h:172:23: note: candidates are: typedef
>>>> unsigned char byte
>>>>  typedef unsigned char byte;  // put in global namespace to avoid ambiguity
>>>> with other byte typedefs
>>>> ^~~~
>>>> In file included from
>>>> /home/cbodley/ceph/build/boost/include/boost/config/compiler/gcc.hpp:165:0,
>>>>                  from
>>>> /home/cbodley/ceph/build/boost/include/boost/config.hpp:39,
>>>>                  from
>>>> /home/cbodley/ceph/build/boost/include/boost/algorithm/string/std_containers_traits.hpp:18,
>>>>                  from
>>>> /home/cbodley/ceph/build/boost/include/boost/algorithm/string.hpp:18,
>>>>                  from /home/cbodley/ceph/src/common/ceph_context.cc:21:
>>>> /usr/include/c++/7/cstddef:64:14: note:                 enum class std::byte
>>>>    enum class byte : unsigned char {};
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
