From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/3] common/Throttle: Add timed_wait().
Date: Thu, 23 Jun 2011 09:53:09 -0600
Message-ID: <4E036165.4000400@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
 <1308767187-10376-4-git-send-email-jaschut@sandia.gov>
 <BANLkTi=ehh8uK_8Zj08jFZGPH7nGU3AFsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54183 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428Ab1FWPxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2011 11:53:44 -0400
In-Reply-To: <BANLkTi=ehh8uK_8Zj08jFZGPH7nGU3AFsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Hi Colin,

Colin McCabe wrote:
> On Wed, Jun 22, 2011 at 11:26 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>> This will enable SimpleMessenger to send keepalives to clients while
>> blocked in the policy throttler.
>>
>> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
>> ---
>>  src/common/Throttle.h |   40 ++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> This looks good. Only a small nitpick-- it's better not to pass
> utime_t by value, since it's a struct. There's a bunch of other code
> doing it, but it's better to pass a const reference. Also, I guess we
> need to rebase this because g_clock has been replaced by
> ceph_clock_now() in master. Should be easy though.

Given Sage's much cleaner approach to fixing the osd reset
issue, is this change useful on its own?  If so, I'm happy
to fix it up and resubmit.

Let me know.

-- Jim

> 
> cheers,
> Colin
> 
> 
>> diff --git a/src/common/Throttle.h b/src/common/Throttle.h
>> index 8fd2625..5a028cc 100644
>> --- a/src/common/Throttle.h
>> +++ b/src/common/Throttle.h
>> @@ -27,6 +27,9 @@ private:
>>       ((c < max && count + c > max) ||   // normally stay under max
>>        (c >= max && count > max));       // except for large c
>>   }
>> +
>> +  /* Returns true if it had to block/wait, false otherwise.
>> +   */
>>   bool _wait(int64_t c) {
>>     bool waited = false;
>>     if (_should_wait(c)) {
>> @@ -44,6 +47,28 @@ private:
>>     return waited;
>>   }
>>
>> +  /* Returns true if it timed out while blocked/waiting,
>> +   * false otherwise.
>> +   */
>> +  bool _timed_wait(utime_t interval, int64_t c) {
>> +    if (_should_wait(c)) {
>> +      utime_t timeout_at = g_clock.now() + interval;
>> +      waiting += c;
>> +      do {
>> +       if (cond.WaitUntil(lock, timeout_at)) {
>> +         waiting -= c;
>> +         return true;
>> +       }
>> +      } while (_should_wait(c));
>> +      waiting -= c;
>> +
>> +      // wake up the next guy
>> +      if (waiting)
>> +       cond.SignalOne();
>> +    }
>> +    return false;
>> +  }
>> +
>>  public:
>>   int64_t get_current() {
>>     Mutex::Locker l(lock);
>> @@ -79,6 +104,21 @@ public:
>>     count += c;
>>   }
>>
>> +  /* Returns true if it got the requested amount within
>> +   * the specified interval, false otherwise.
>> +   */
>> +  bool timed_get(utime_t interval, int64_t c = 1, int64_t m = 0) {
>> +    assert(c >= 0);
>> +    Mutex::Locker l(lock);
>> +    if (m) {
>> +      assert(m > 0);
>> +      _reset_max(m);
>> +    }
>> +    if (_timed_wait(interval, c)) return false;
>> +    count += c;
>> +    return true;
>> +  }
>> +
>>   /* Returns true if it successfully got the requested amount,
>>    * or false if it would block.
>>    */
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 


