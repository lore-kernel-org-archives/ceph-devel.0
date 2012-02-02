From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC PATCH 3/6] common/Throttle: throttle in FIFO order
Date: Thu, 2 Feb 2012 11:01:05 -0800
Message-ID: <CAF3hT9BKwBTQD0qF3WV2NGZ5c9DnzsC60ETkP1YDiOHp+saKFA@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<1328111668-10068-4-git-send-email-jaschut@sandia.gov>
	<CAF3hT9ABvoTmmA7+6KQ_rBJZdqH44nGQL+fLAXCdkYR1pbRqOQ@mail.gmail.com>
	<4F2AD669.4080703@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55443 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab2BBTBG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 14:01:06 -0500
Received: by iacb35 with SMTP id b35so3505366iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 11:01:05 -0800 (PST)
In-Reply-To: <4F2AD669.4080703@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 2, 2012 at 10:31 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 02/02/2012 10:53 AM, Gregory Farnum wrote:
>>
>> I went to merge this but then had a question on part of it (below).
>>
>> On Wed, Feb 1, 2012 at 7:54 AM, Jim Schutt<jaschut@sandia.gov> =A0wr=
ote:
>>>
>>> Under heavy write load from many clients, many reader threads will
>>> be waiting in the policy throttler, all on a single condition varia=
ble.
>>> When a wakeup is signalled, any of those threads may receive the
>>> signal. =A0This increases the variance in the message processing
>>> latency, and in extreme cases can significantly delay a message.
>>>
>>> This patch causes threads to exit a throttler in the same order
>>> they entered.
>>>
>>> Signed-off-by: Jim Schutt<jaschut@sandia.gov>
>>> ---
>>> =A0src/common/Throttle.h | =A0 42 ++++++++++++++++++++++++++++-----=
---------
>>> =A01 files changed, 28 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/src/common/Throttle.h b/src/common/Throttle.h
>>> index 10560bf..ca72060 100644
>>> --- a/src/common/Throttle.h
>>> +++ b/src/common/Throttle.h
>>> @@ -3,23 +3,31 @@
>>>
>>> =A0#include "Mutex.h"
>>> =A0#include "Cond.h"
>>> +#include<list>
>>>
>>> =A0class Throttle {
>>> - =A0int64_t count, max, waiting;
>>> + =A0int64_t count, max;
>>> =A0 uint64_t sseq, wseq;
>>> =A0 Mutex lock;
>>> - =A0Cond cond;
>>> + =A0list<Cond*> =A0cond;
>>>
>>> =A0public:
>>> - =A0Throttle(int64_t m =3D 0) : count(0), max(m), waiting(0), sseq=
(0),
>>> wseq(0),
>>> + =A0Throttle(int64_t m =3D 0) : count(0), max(m), sseq(0), wseq(0)=
,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lock("Throttle::=
lock") {
>>> =A0 =A0 assert(m>=3D 0);
>>> =A0 }
>>> + =A0~Throttle() {
>>> + =A0 =A0while (!cond.empty()) {
>>> + =A0 =A0 =A0Cond *cv =3D cond.front();
>>> + =A0 =A0 =A0delete cv;
>>> + =A0 =A0 =A0cond.pop_front();
>>> + =A0 =A0}
>>> + =A0}
>>>
>>> =A0private:
>>> =A0 void _reset_max(int64_t m) {
>>> - =A0 =A0if (m< =A0max)
>>> - =A0 =A0 =A0cond.SignalOne();
>>> + =A0 =A0if (m< =A0max&& =A0!cond.empty())
>>>
>>> + =A0 =A0 =A0cond.front()->SignalOne();
>>> =A0 =A0 max =3D m;
>>> =A0 }
>>> =A0 bool _should_wait(int64_t c) {
>>> @@ -28,19 +36,24 @@ private:
>>> =A0 =A0 =A0 ((c< =A0max&& =A0count + c> =A0max) || =A0 // normally =
stay under max
>>> =A0 =A0 =A0 =A0(c>=3D max&& =A0count> =A0max)); =A0 =A0 =A0 // exce=
pt for large c
>>>
>>> =A0 }
>>> +
>>> =A0 bool _wait(int64_t c) {
>>> =A0 =A0 bool waited =3D false;
>>> - =A0 =A0if (_should_wait(c)) {
>>> - =A0 =A0 =A0waiting +=3D c;
>>> + =A0 =A0if (_should_wait(c) || !cond.empty()) { // always wait beh=
ind other
>>> waiters.
>>> + =A0 =A0 =A0Cond *cv =3D new Cond;
>>> + =A0 =A0 =A0cond.push_back(cv);
>>> =A0 =A0 =A0 do {
>>> + =A0 =A0 =A0 =A0if (cv !=3D cond.front())
>>> + =A0 =A0 =A0 =A0 =A0cond.front()->SignalOne(); =A0// wake up the o=
ldest.
>>
>>
>> What's this extra wakeup for? Unless I'm missing something it's alwa=
ys
>> going to be gratuitous. :/
>
>
> I think it was a poorly thought-out attempt at
> defensive programming. =A0Now that I'm thinking about
> it harder, I agree it is gratuitous.
>
> Thanks -- Jim

Awesome. Applied to master in commit:83432af2adce75676b734d2b99dd88372e=
de833a.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
