From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: portability issue with gmtime method in utime_t
Date: Sat, 9 Nov 2013 08:38:19 -0800
Message-ID: <CA+Hcz5-5ZseyNx7E2-TCcaKFzctsEmqqhvP3hYcgY3AJJg1feg@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B665E2149@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:45620 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3KIQiU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 11:38:20 -0500
Received: by mail-qa0-f53.google.com with SMTP id k4so584689qaq.19
        for <ceph-devel@vger.kernel.org>; Sat, 09 Nov 2013 08:38:19 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B665E2149@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

I think my vote would be to rename `ostream& gmtime(ostream& out)
const` to something like `write_gmtime`, but the global namespace
approach seems OK too. Maybe someone else has a strong opinion.

---

sort of related: while we are on the subject of utime_t, `timegm`
isn't portable. This is the hack I'm using in `wip-port`, but I don't
think it should stay this way:

diff --git a/src/include/utime.h b/src/include/utime.h
index 5bebc70..1a74a85 100644
--- a/src/include/utime.h
+++ b/src/include/utime.h
@@ -238,6 +238,22 @@ class utime_t {
     bdt.tm_hour, bdt.tm_min, bdt.tm_sec, usec());
   }

+  static time_t my_timegm (struct tm *tm) {
+    time_t ret;
+    char *tz;
+
+    tz = getenv("TZ");
+    setenv("TZ", "", 1);
+    tzset();
+    ret = mktime(tm);
+    if (tz)
+      setenv("TZ", tz, 1);
+    else
+      unsetenv("TZ");
+    tzset();
+    return ret;
+  }
+
   static int parse_date(const string& date, uint64_t *epoch, uint64_t *nsec,
                         string *out_date=NULL, string *out_time=NULL) {
     struct tm tm;
@@ -274,7 +290,7 @@ class utime_t {
     } else {
       return -EINVAL;
     }
-    time_t t = timegm(&tm);
+    time_t t = my_timegm(&tm);
     if (epoch)
       *epoch = (uint64_t)t;


On Sat, Nov 9, 2013 at 12:24 AM, James Harper
<james.harper@bendigoit.com.au> wrote:
> utime.h defines a utime_t class with a gmtime() method, and also calls the library function gmtime_r().
>
> mingw implements gmtime_r() as a macro in pthread.h that in turn calls gmtime(), and gcc bails because it gets confused about which is being called:
>
> utime.h: In member function 'utime_t utime_t::round_to_minute()':
> utime.h:113:5: error: no matching function for call to 'utime_t::gmtime(time_t*)'
> utime.h:113:5: note: candidate is:
> utime.h:146:12: note: std::ostream& utime_t::gmtime(std::ostream&) const
> utime.h:146:12: note:   no known conversion for argument 1 from 'time_t* {aka long long int*}' to 'std::ostream& {aka std::basic_ostream<char>&}'
>
> Same for asctime and localtime. I can work around it by creating a static method that in turn calls ::gmtime() etc, but I'm not sure that's the best way to do it.
>
> There's a bunch of other build errors in there too so it may be a lost cause...
>
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
