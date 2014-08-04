From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Non existing monitor
Date: Mon, 04 Aug 2014 14:40:36 +0000
Message-ID: <53DF9B64.7070805@inktank.com>
References: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2FE35@SACMBXIP01.sdcorp.global.sandisk.com> <CAPYLRzjRw-wTcv3Q2ZAKjmXKwNsLwL6gsj5BAJfSVSNcEg3New@mail.gmail.com> <68A06213B74F1742A2C48216AE1BB6B803FEDE4F@SACMBXIP02.sdcorp.global.sandisk.com> <53DCE506.6050106@inktank.com> <7F4FDDF05D5B3241ABA5EB82D169E31E04B301BC@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46983 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbaHDOkq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 10:40:46 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so7758120wgh.29
        for <ceph-devel@vger.kernel.org>; Mon, 04 Aug 2014 07:40:41 -0700 (PDT)
In-Reply-To: <7F4FDDF05D5B3241ABA5EB82D169E31E04B301BC@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>, Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>, Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Hello Aanchal,

On 04/08/14 06:43, Aanchal Agrawal wrote:
> Hi Joao,
>
> I have already fixed this issue(let me know if the fix looks good) and was about to send the pull request with the following diff.
> But I still had couple of unanswered questions, hence this mail chain. And they were:

I was in the middle of finishing a patch when I read your email. 
Although your patch looks good as a fix for the incorrect behaviour, I 
believe how the code itself was structured and the holes it left opened 
was concerning, so I pushed my branch nonetheless.  You can find it in 
ceph's github repository, branch name 'wip-mon-empty-store'.  A review 
would be appreciated, and any concerns you may have will be welcome.

>
> 1) Though in case of mkfs not being set, what is the reason for creating a new levelDB store in case an attempt to open the 'store.db' is a failure, as levelDB anyways seem to be throwing 'magic' error going forward. Are there any use cases for this scenario?
> 2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?

With regard to 1), it is a bug.  On open we specified that leveldb 
should not create a new database (see db->open() vs 
db->create_and_open()).  However, leveldb will create the directory 
structure if it is missing nonetheless, and this is what was creating 
those issues.  The patch in the branch I mentioned above will work 
around that by checking whether the monitor's data directory is empty 
before opening the database -- thus, if it is indeed empty, it will not 
call on db->open() and therefore avoid populating the directory with 
senseless noise.

About 2), 'store.db' may not be present if we are upgrading a release 
prior to cuttlefish, as at the time the monitor store format was 
different.  We use the absence of 'store.db' as an indicator to check 
for a possible need for a format upgrade (which will then be performed 
by Monitor::StoreConverter).  However, we can use the total and complete 
absence of files in the monitor's data directory as a definite indicator 
that there's no monitor store at that path.

Hope this sheds some light on your questions.

   -Joao




> ========================
> <snip>
>
> @@ -152,11 +152,20 @@ int mon_data_empty(bool *r)
>     return code;
>   }
>
> -int mon_exists(bool *r)
> +int mon_exists(bool *r, bool mkfs)
>   {
>     int code = mon_data_exists(r);
> -  if (code || *r == false)
> +  if (code)
>       return code;
> +  // If mon_data(directory) not present, check for mkfs
> +  if (*r == false) {
> +    if (!mkfs) {
> +      cerr << "No monitor with ID " << g_conf->name.get_id() << " in cluster" << std::endl;
> +      return 1;
> +    }
> +    // If mkfs is true, we want to create a new directory, hence return 0
> +    return code;
> +  }
>     return mon_data_empty(r);
>   }
>
> @@ -268,7 +277,7 @@ int main(int argc, const char **argv)
>     }
>
>     bool exists;
> -  if (mon_exists(&exists))
> +  if (mon_exists(&exists, mkfs))
>       exit(1);
>
>     if (mkfs && exists) {
> @@ -452,7 +461,7 @@ int main(int argc, const char **argv)
>
> <\snip>
> ==========================
>
> Thanks,
> Aanchal
>
> -----Original Message-----
> From: Joao Eduardo Luis [mailto:joao.luis@inktank.com]
> Sent: Saturday, August 02, 2014 6:48 PM
> To: Pavan Rallabhandi; Gregory Farnum; Aanchal Agrawal
> Cc: ceph-devel@vger.kernel.org; Samuel Just
> Subject: Re: Non existing monitor
>
> On 01/08/14 18:20, Pavan Rallabhandi wrote:
>> Greg,
>>
>> The commands used were to start monitor for an instance id that is non existing, for which a leveldb store error is thrown:
>>
>> <snip>
>>
>> src/ceph-mon -i foo
>> 2014-08-01 02:47:08.210208 7f7341c3c800 -1 failed to create new
>> leveldb store
>>
>> <\snip>
>>
>> The idea is to fix this behavior by throwing a relevant error.
>
> The infrastructure is there (ceph_mon.cc) but is not doing what I believe it should.  It was introduced in 1eafe8dc45419a6b7d319345cac7fbc0d684d1b1.  I'm fixing it now.
>
>     -Joao
>
>>
>> Thanks,
>> -Pavan.
>>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@inktank.com]
>> Sent: Friday, August 01, 2014 6:16 PM
>> To: Aanchal Agrawal
>> Cc: ceph-devel@vger.kernel.org; Pavan Rallabhandi; Samuel Just; Joao
>> Luis
>> Subject: Re: Non existing monitor
>>
>> On Fri, Aug 1, 2014 at 6:03 AM, Aanchal Agrawal <Aanchal.Agrawal@sandisk.com> wrote:
>>> Any help on this ...
>>>
>>> -----Original Message-----
>>> From: Aanchal Agrawal
>>> Sent: Wednesday, July 30, 2014 3:37 PM
>>> To: 'ceph-devel@vger.kernel.org'
>>> Cc: Pavan Rallabhandi
>>> Subject: Non existing monitor
>>>
>>> Hi,
>>>
>>> We found a case(bug?) in ceph mon code, where in, an attempt to start a non-existing monitor is throwing up a levelDB error saying "failed to create new leveldb store", instead we thought an appropriate message say "No Monitor present with that id" would do, by checking for the monitor existence way ahead.
>>>
>>> It seems that 'mon_exists()' checks for the existence of the mon data directory(via 'mon_data_exists()') and also for the non-empty nature of that directory(via 'mon_data_empty()'). The fix seemed pretty simple, as to flag the appropriate message if 'mon_data_exists()' were to set 'exists' to 'false', in case mkfs is not set.
>>>
>>> The other behavior that we are seeking clarity, again in case of mkfs not being set is, if 'mon_data_exists()' sets 'exists' to 'true' and 'mon_data_empty()' sets 'exists' to 'false' (meaning the mon data directory is present, but it is empty), then the current code seems to be going ahead in an attempt to open the 'store.db', and when open fails, it tries to create a new 'store.db' (though mkfs is not set) and eventually gives up throwing "unable to read magic from mon data".
>>>
>>> The questions we had around this were:
>>>
>>> 1) Though in case of mkfs not being set, what is the reason for creating a new levelDB store in case an attempt to open the 'store.db' is a failure, as levelDB anyways seem to be throwing 'magic' error going forward. Are there any use cases for this scenario?
>>> 2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?
>>
>> This is a little unclear to me. Can you describe exactly what commands you're running and what the response from the monitor is?
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>
>
> --
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
