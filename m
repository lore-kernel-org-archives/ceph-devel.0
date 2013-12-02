From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH 17/18] client: Write inline data path
Date: Mon, 02 Dec 2013 16:03:58 +0800
Message-ID: <529C3EEE.3080604@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com> <8bc8c758bb5058a10965d422fb99d5bc29f85a71.1385558324.git.liwang@ubuntukylin.com> <CAAM7YAnwL4xdY0wysN46yVgb2=MciNA5DGV4Ac=nYgQi4vcfPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:52547 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3LBIEG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Dec 2013 03:04:06 -0500
In-Reply-To: <CAAM7YAnwL4xdY0wysN46yVgb2=MciNA5DGV4Ac=nYgQi4vcfPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Hi Zheng,
   Thanks for your comments.
   Regarding the configuration option, it is in our original plan, and 
we will make it appear soon in the incoming next version :)
   For the write optimization, it does remind us to do an optimization, 
that is, if the inline data length is zero, we won't bother to do the 
migration. This will capture the situation that application has a write 
buffer larger than the inline threshold, the sequential write will not 
incur migration. And another situation that client performs some inline 
read/write, then truncate it to zero, then start write after the inline 
threshold.

Cheers,
Li Wang

On 11/28/2013 11:02 AM, Yan, Zheng wrote:
> On Wed, Nov 27, 2013 at 9:40 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
>> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
>> ---
>>   src/client/Client.cc |   55 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/client/Client.cc b/src/client/Client.cc
>> index 6b08155..c913e35 100644
>> --- a/src/client/Client.cc
>> +++ b/src/client/Client.cc
>> @@ -6215,6 +6215,41 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
>>
>>     ldout(cct, 10) << " snaprealm " << *in->snaprealm << dendl;
>>
>> +  Mutex uninline_flock("Clinet::_write_uninline_data flock");
>> +  Cond uninline_cond;
>> +  bool uninline_done = false;
>> +  int uninline_ret = 0;
>> +  Context *onuninline = NULL;
>> +
>> +  if (in->inline_version < CEPH_INLINE_NONE) {
>> +    if (endoff > CEPH_INLINE_SIZE || !(have & CEPH_CAP_FILE_BUFFER)) {
>> +      onuninline = new C_SafeCond(&uninline_flock,
>> +                                  &uninline_cond,
>> +                                  &uninline_done,
>> +                                  &uninline_ret);
>> +      uninline_data(in, onuninline);
>
> If client does 4k sequence write, the second write always trigger the
> "uninline" procedure, this is suboptimal. It's better to just copy the
> inline data to the object cacher.
>
> Besides, this feature should be disabled by default because it's not
> compatible with old clients and it imposes overhead on the mds. we
> need to use a config option or directory attribute to enable it.
>
> Regards
> Yan, Zheng
>
>
>> +    } else {
>> +      get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
>> +
>> +      uint32_t len = in->inline_data.length();
>> +
>> +      if (endoff < len)
>> +        in->inline_data.copy(endoff, len - endoff, bl);
>> +
>> +      if (offset < len)
>> +        in->inline_data.splice(offset, len - offset);
>> +      else if (offset > len)
>> +        in->inline_data.append_zero(offset - len);
>> +
>> +      in->inline_data.append(bl);
>> +      in->inline_version++;
>> +
>> +      put_cap_ref(in, CEPH_CAP_FILE_BUFFER);
>> +
>> +      goto success;
>> +    }
>> +  }
>> +
>>     if (cct->_conf->client_oc && (have & CEPH_CAP_FILE_BUFFER)) {
>>       // do buffered write
>>       if (!in->oset.dirty_or_tx)
>> @@ -6265,7 +6300,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
>>     }
>>
>>     // if we get here, write was successful, update client metadata
>> -
>> +success:
>>     // time
>>     lat = ceph_clock_now(cct);
>>     lat -= start;
>> @@ -6293,6 +6328,24 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
>>     mark_caps_dirty(in, CEPH_CAP_FILE_WR);
>>
>>   done:
>> +
>> +  if (onuninline) {
>> +    client_lock.Unlock();
>> +    uninline_flock.Lock();
>> +    while (!uninline_done)
>> +      uninline_cond.Wait(uninline_flock);
>> +    uninline_flock.Unlock();
>> +    client_lock.Lock();
>> +
>> +    if (uninline_ret >= 0 || uninline_ret == -ECANCELED) {
>> +      in->inline_data.clear();
>> +      in->inline_version = CEPH_INLINE_NONE;
>> +      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
>> +      check_caps(in, false);
>> +    } else
>> +      r = uninline_ret;
>> +  }
>> +
>>     put_cap_ref(in, CEPH_CAP_FILE_WR);
>>     return r;
>>   }
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
