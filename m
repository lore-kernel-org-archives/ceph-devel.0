From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH 2/3] common/Throttle: Add timed_wait().
Date: Thu, 23 Jun 2011 04:02:15 -0700
Message-ID: <BANLkTi=ehh8uK_8Zj08jFZGPH7nGU3AFsg@mail.gmail.com>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
	<1308767187-10376-4-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32916 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224Ab1FWLCQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2011 07:02:16 -0400
Received: by fxm17 with SMTP id 17so1197981fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2011 04:02:15 -0700 (PDT)
In-Reply-To: <1308767187-10376-4-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 22, 2011 at 11:26 AM, Jim Schutt <jaschut@sandia.gov> wrote=
:
> This will enable SimpleMessenger to send keepalives to clients while
> blocked in the policy throttler.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0src/common/Throttle.h | =A0 40 +++++++++++++++++++++++++++++++++++=
+++++
> =A01 files changed, 40 insertions(+), 0 deletions(-)

This looks good. Only a small nitpick-- it's better not to pass
utime_t by value, since it's a struct. There's a bunch of other code
doing it, but it's better to pass a const reference. Also, I guess we
need to rebase this because g_clock has been replaced by
ceph_clock_now() in master. Should be easy though.

cheers,
Colin


>
> diff --git a/src/common/Throttle.h b/src/common/Throttle.h
> index 8fd2625..5a028cc 100644
> --- a/src/common/Throttle.h
> +++ b/src/common/Throttle.h
> @@ -27,6 +27,9 @@ private:
> =A0 =A0 =A0 ((c < max && count + c > max) || =A0 // normally stay und=
er max
> =A0 =A0 =A0 =A0(c >=3D max && count > max)); =A0 =A0 =A0 // except fo=
r large c
> =A0 }
> +
> + =A0/* Returns true if it had to block/wait, false otherwise.
> + =A0 */
> =A0 bool _wait(int64_t c) {
> =A0 =A0 bool waited =3D false;
> =A0 =A0 if (_should_wait(c)) {
> @@ -44,6 +47,28 @@ private:
> =A0 =A0 return waited;
> =A0 }
>
> + =A0/* Returns true if it timed out while blocked/waiting,
> + =A0 * false otherwise.
> + =A0 */
> + =A0bool _timed_wait(utime_t interval, int64_t c) {
> + =A0 =A0if (_should_wait(c)) {
> + =A0 =A0 =A0utime_t timeout_at =3D g_clock.now() + interval;
> + =A0 =A0 =A0waiting +=3D c;
> + =A0 =A0 =A0do {
> + =A0 =A0 =A0 if (cond.WaitUntil(lock, timeout_at)) {
> + =A0 =A0 =A0 =A0 waiting -=3D c;
> + =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0} while (_should_wait(c));
> + =A0 =A0 =A0waiting -=3D c;
> +
> + =A0 =A0 =A0// wake up the next guy
> + =A0 =A0 =A0if (waiting)
> + =A0 =A0 =A0 cond.SignalOne();
> + =A0 =A0}
> + =A0 =A0return false;
> + =A0}
> +
> =A0public:
> =A0 int64_t get_current() {
> =A0 =A0 Mutex::Locker l(lock);
> @@ -79,6 +104,21 @@ public:
> =A0 =A0 count +=3D c;
> =A0 }
>
> + =A0/* Returns true if it got the requested amount within
> + =A0 * the specified interval, false otherwise.
> + =A0 */
> + =A0bool timed_get(utime_t interval, int64_t c =3D 1, int64_t m =3D =
0) {
> + =A0 =A0assert(c >=3D 0);
> + =A0 =A0Mutex::Locker l(lock);
> + =A0 =A0if (m) {
> + =A0 =A0 =A0assert(m > 0);
> + =A0 =A0 =A0_reset_max(m);
> + =A0 =A0}
> + =A0 =A0if (_timed_wait(interval, c)) return false;
> + =A0 =A0count +=3D c;
> + =A0 =A0return true;
> + =A0}
> +
> =A0 /* Returns true if it successfully got the requested amount,
> =A0 =A0* or false if it would block.
> =A0 =A0*/
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
