From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC PATCH 3/6] common/Throttle: throttle in FIFO order
Date: Thu, 2 Feb 2012 09:53:47 -0800
Message-ID: <CAF3hT9ABvoTmmA7+6KQ_rBJZdqH44nGQL+fLAXCdkYR1pbRqOQ@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<1328111668-10068-4-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49706 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab2BBRxs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 12:53:48 -0500
Received: by iacb35 with SMTP id b35so3430593iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 09:53:48 -0800 (PST)
In-Reply-To: <1328111668-10068-4-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

I went to merge this but then had a question on part of it (below).

On Wed, Feb 1, 2012 at 7:54 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Under heavy write load from many clients, many reader threads will
> be waiting in the policy throttler, all on a single condition variabl=
e.
> When a wakeup is signalled, any of those threads may receive the
> signal. =A0This increases the variance in the message processing
> latency, and in extreme cases can significantly delay a message.
>
> This patch causes threads to exit a throttler in the same order
> they entered.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0src/common/Throttle.h | =A0 42 ++++++++++++++++++++++++++++-------=
-------
> =A01 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/src/common/Throttle.h b/src/common/Throttle.h
> index 10560bf..ca72060 100644
> --- a/src/common/Throttle.h
> +++ b/src/common/Throttle.h
> @@ -3,23 +3,31 @@
>
> =A0#include "Mutex.h"
> =A0#include "Cond.h"
> +#include <list>
>
> =A0class Throttle {
> - =A0int64_t count, max, waiting;
> + =A0int64_t count, max;
> =A0 uint64_t sseq, wseq;
> =A0 Mutex lock;
> - =A0Cond cond;
> + =A0list<Cond*> cond;
>
> =A0public:
> - =A0Throttle(int64_t m =3D 0) : count(0), max(m), waiting(0), sseq(0=
), wseq(0),
> + =A0Throttle(int64_t m =3D 0) : count(0), max(m), sseq(0), wseq(0),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lock("Throttle::lo=
ck") {
> =A0 =A0 assert(m >=3D 0);
> =A0 }
> + =A0~Throttle() {
> + =A0 =A0while (!cond.empty()) {
> + =A0 =A0 =A0Cond *cv =3D cond.front();
> + =A0 =A0 =A0delete cv;
> + =A0 =A0 =A0cond.pop_front();
> + =A0 =A0}
> + =A0}
>
> =A0private:
> =A0 void _reset_max(int64_t m) {
> - =A0 =A0if (m < max)
> - =A0 =A0 =A0cond.SignalOne();
> + =A0 =A0if (m < max && !cond.empty())
> + =A0 =A0 =A0cond.front()->SignalOne();
> =A0 =A0 max =3D m;
> =A0 }
> =A0 bool _should_wait(int64_t c) {
> @@ -28,19 +36,24 @@ private:
> =A0 =A0 =A0 ((c < max && count + c > max) || =A0 // normally stay und=
er max
> =A0 =A0 =A0 =A0(c >=3D max && count > max)); =A0 =A0 =A0 // except fo=
r large c
> =A0 }
> +
> =A0 bool _wait(int64_t c) {
> =A0 =A0 bool waited =3D false;
> - =A0 =A0if (_should_wait(c)) {
> - =A0 =A0 =A0waiting +=3D c;
> + =A0 =A0if (_should_wait(c) || !cond.empty()) { // always wait behin=
d other waiters.
> + =A0 =A0 =A0Cond *cv =3D new Cond;
> + =A0 =A0 =A0cond.push_back(cv);
> =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0if (cv !=3D cond.front())
> + =A0 =A0 =A0 =A0 =A0cond.front()->SignalOne(); =A0// wake up the old=
est.

What's this extra wakeup for? Unless I'm missing something it's always
going to be gratuitous. :/

> =A0 =A0 =A0 =A0waited =3D true;
> - =A0 =A0 =A0 cond.Wait(lock);
> - =A0 =A0 =A0} while (_should_wait(c));
> - =A0 =A0 =A0waiting -=3D c;
> + =A0 =A0 =A0 =A0cv->Wait(lock);
> + =A0 =A0 =A0} while (_should_wait(c) || cv !=3D cond.front());
> + =A0 =A0 =A0delete cv;
> + =A0 =A0 =A0cond.pop_front();
>
> =A0 =A0 =A0 // wake up the next guy
> - =A0 =A0 =A0if (waiting)
> - =A0 =A0 =A0 cond.SignalOne();
> + =A0 =A0 =A0if (!cond.empty())
> + =A0 =A0 =A0 =A0cond.front()->SignalOne();
> =A0 =A0 }
> =A0 =A0 return waited;
> =A0 }
> @@ -101,7 +114,7 @@ public:
> =A0 bool get_or_fail(int64_t c =3D 1) {
> =A0 =A0 assert (c >=3D 0);
> =A0 =A0 Mutex::Locker l(lock);
> - =A0 =A0if (_should_wait(c)) return false;
> + =A0 =A0if (_should_wait(c) || !cond.empty()) return false;
> =A0 =A0 count +=3D c;
> =A0 =A0 return true;
> =A0 }
> @@ -110,7 +123,8 @@ public:
> =A0 =A0 assert(c >=3D 0);
> =A0 =A0 Mutex::Locker l(lock);
> =A0 =A0 if (c) {
> - =A0 =A0 =A0cond.SignalOne();
> + =A0 =A0 =A0if (!cond.empty())
> + =A0 =A0 =A0 =A0cond.front()->SignalOne();
> =A0 =A0 =A0 count -=3D c;
> =A0 =A0 =A0 assert(count >=3D 0); //if count goes negative, we failed=
 somewhere!
> =A0 =A0 }
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
