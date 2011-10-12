From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [PATCH 4/5] buf: implement generic virBufferEscape
Date: Wed, 12 Oct 2011 11:09:04 -0600
Message-ID: <4E95C9B0.5020205@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>	<1316492023-17749-5-git-send-email-sage@newdream.net> <20111011103935.GB16057@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab1JLRJL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 13:09:11 -0400
In-Reply-To: <20111011103935.GB16057@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/11/2011 04:39 AM, Daniel P. Berrange wrote:
> On Mon, Sep 19, 2011 at 09:13:42PM -0700, Sage Weil wrote:
>> Implement a generic helper to escape a given set of characters with a
>> leading '\'.  Generalizes virBufferEscapeSexpr().
>>
>> Signed-off-by: Sage Weil<sage@newdream.net>
>> @@ -408,14 +428,13 @@ virBufferEscapeSexpr(const virBufferPtr buf,
>>       cur = str;
>>       out = escaped;
>>       while (*cur != 0) {
>> -        switch (*cur) {
>> -        case '\\':
>> -        case '\'':
>> -            *out++ = '\\';
>> -            /* fallthrough */
>> -        default:
>> -            *out++ = *cur;
>> +        for (p = toescape; *p; ++p) {
>> +            if (*cur == *p) {

strchr is slightly more efficient than hand-rolling this loop.

More importantly, you had a logic bug, where you replaced one hard-coded 
instance of "\\'", but not the other (the strcspn optimization).  Also, 
I tend to use "'" instead of "\'", although both work, since I favor 
concise code (I save my ramblings for my emails :).

>
> ACK, trivial isolated patch

I added you to AUTHORS, squashed this in, then pushed.

diff --git i/src/util/buf.c w/src/util/buf.c
index 7d0d2d3..5627d8f 100644
--- i/src/util/buf.c
+++ w/src/util/buf.c
@@ -383,7 +383,7 @@ virBufferEscapeSexpr(const virBufferPtr buf,
                       const char *format,
                       const char *str)
  {
-    virBufferEscape(buf, "\\\'", format, str);
+    virBufferEscape(buf, "\\'", format, str);
  }

  /**
@@ -414,7 +414,7 @@ virBufferEscape(const virBufferPtr buf,
          return;

      len = strlen(str);
-    if (strcspn(str, "\\'") == len) {
+    if (strcspn(str, toescape) == len) {
          virBufferAsprintf(buf, format, str);
          return;
      }
@@ -428,12 +428,8 @@ virBufferEscape(const virBufferPtr buf,
      cur = str;
      out = escaped;
      while (*cur != 0) {
-        for (p = toescape; *p; ++p) {
-            if (*cur == *p) {
-                *out++ = '\\';
-                break;
-            }
-        }
+        if (strchr(toescape, *cur))
+            *out++ = '\\';
          *out++ = *cur;
          cur++;
      }
-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
