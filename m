From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Building for Clang is broken for snap-types
Date: Fri, 21 Oct 2016 16:30:28 +0200
Message-ID: <e941a13c-84b5-ffa0-82bb-c2a32489d65d@digiware.nl>
References: <0e42917f-707d-a5a2-141a-6c5c971ff021@digiware.nl>
 <CAJE9aOP7gYJzgZaT25bJy1y8nOS8Hqmmb0wttc63KN+hg=AoTA@mail.gmail.com>
 <d2873553-7338-dc43-c98d-2ce0e6a7c956@digiware.nl>
 <13220e29-4827-c2c9-5c88-0f4a88c2c244@digiware.nl>
 <1dd0cd11-aa96-5d53-5623-bfe856ffd6ff@digiware.nl>
 <CAJ4mKGbAjqUR1HNEm88e3ZO+Px64Gz+2aVqMq0jkJGCU--xrYg@mail.gmail.com>
 <4c6e85cd-00f2-2bc3-3ed9-17d136b40b62@digiware.nl>
 <alpine.DEB.2.11.1610211348470.3288@piezo.us.to>
 <e8965c6a-e92f-128a-7e89-ebb74cf7a817@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:61226 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932814AbcJUOae (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Oct 2016 10:30:34 -0400
In-Reply-To: <e8965c6a-e92f-128a-7e89-ebb74cf7a817@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 21-10-2016 16:19, Willem Jan Withagen wrote:
> On 21-10-2016 15:53, Sage Weil wrote:
>> On Fri, 21 Oct 2016, Willem Jan Withagen wrote:
>>> On 20-10-2016 18:53, Gregory Farnum wrote:
>>>> On Thu, Oct 20, 2016 at 3:21 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>> On 20-10-2016 02:49, Willem Jan Withagen wrote:
>>>>>> On 20-10-2016 02:21, Willem Jan Withagen wrote:
>>>>>>> On 19-10-2016 20:58, kefu chai wrote:
>>>>>>>> should have been fixed in master.
>>>>>>>
>>>>>>> Ehh,
>>>>>>>
>>>>>>> Not really.
>>>>>>> Just tested by running
>>>>>>> cd Ceph/master/ceph
>>>>>>> git pull
>>>>>>> ./do_freebsd.sh
>>>>>>>
>>>>>>> And I still get the same error.
>>>>>>>
>>>>>>> Guess I'll have to start bisecting to see where it went wrong.
>>>>>>
>>>>>> This is the actual commit going wrong
>>>>>>
>>>>>> commit c9c5235ef7d563b92f44dab63a8ac2b694e69d4f
>>>>>> Author: Sage Weil <sage@redhat.com>
>>>>>> Date:   Wed Sep 14 13:32:20 2016 -0400
>>>>>>
>>>>>>     include/object: conditional denc_traits for snapid_t
>>>>>>
>>>>>>     Signed-off-by: Sage Weil <sage@redhat.com>
>>>>>
>>>>> This all was in pull #11027
>>>>> Last commit that works is: dec0f05288dc4fce0f5ae2de7cf4dd8f9281fe1f
>>>>>
>>>>> That code is changing all kind of templates... And to be honest, I not
>>>>> very comfortable with that.
>>>>>
>>>>> But obviously GCC seems to able to promote type
>>>>>         'const vector<snapid_t>'
>>>>> in such a way that it can find a matching function, where as Clang is
>>>>> being more selective (as usual)
>>>>
>>>> That's odd; isn't snapid_t a typedef for uint64_t?
>>>> There are a few things like that which are wrapped structs with
>>>> implicit conversions, in which case maybe it needs to be defined more
>>>> clearly for Clang in this case, or just give it an explicit template
>>>> wrapper pointing at le64 (or whichever one it's supposed to be).
>>>
>>> The other value I see being used in dencode is indeed ceph_le64.
>>>
>>> Although I understand what you are saying. It is not something that I
>>> can just pull out of my hat, since templates still are a large learning
>>> field for me.
>>>
>>> So a hint would be appreciated.
>>
>> It looks like clang is buggy.  At leasy, my fedora 23 version is
> 
> Hi Sage,
> 
> I do not exclude that....
> It is going to be either buggy of picky. :)
> 
>> $ clang --version
>> clang version 3.7.0 (tags/RELEASE_370/final)
>> Target: x86_64-redhat-linux-gnu
>> Thread model: posix
> 
> I'm already at 3.8.0 because that is the default compiler for
> 11.0-RELEASE and futher.
> 
>> This fixes the snapid_t compilation:
>>
>> diff --git a/src/include/denc.h b/src/include/denc.h
>> index 59f7686..caa095b 100644
>> --- a/src/include/denc.h
>> +++ b/src/include/denc.h
>> @@ -722,7 +722,7 @@ struct denc_traits<
>>  template<typename T>
>>  struct denc_traits<
>>    std::vector<T>,
>> -  typename std::enable_if<denc_traits<T>::supported>::type> {
>> +  typename std::enable_if<denc_traits<T>::supported != 0>::type> {
>>    typedef denc_traits<T> traits;
>>  
>>    enum { supported = true };
>> @@ -831,7 +831,7 @@ struct denc_traits<
>>  template<typename T>
>>  struct denc_traits<
>>    std::set<T>,
>> -  typename std::enable_if<denc_traits<T>::supported>::type> {
>> +  typename std::enable_if<denc_traits<T>::supported != 0>::type> {
>>    typedef denc_traits<T> traits;
>>  
>>    enum { supported = true };
>>
>> which, AFAICS, is nonsense... supported is either a bool or int, and in 
>> either case "supported" and "supported != 0" should be equivalent 
>> (right?).  But once I get past that clang crashes a few files later... see 
>> attached.
>>
>> Maybe start by trying to upgrade clang?  Or submit a clang bug report? :/
> 
> I'll see if I can get that somewhere reported as bug since it also
> hampers 3.8.0 .... Probably one of the tool-chain people will know.
> 
>> (Perhaps you can use gcc for the time being?)
> 
> Don't need to!! 8=) since 3.8.0 takes it without crash.
> Some at least something improved in this corner of the compiler.
> 
> But I owe you (lots of) beer, next time we meet...
> 
> Going to check if it now completes all the way thru.

It breaks at a different point, in a different source file, but I guess
for the same reasons. Going to grep the code for 'supported>' and
replace more of the same.

/usr/srcs/Ceph/work/ceph/src/mon/MonClient.cc:666:3: error: no matching
function for call to 'encode'
  ::encode(auth_supported->get_supported_set(), m->auth_payload);

--WjW


