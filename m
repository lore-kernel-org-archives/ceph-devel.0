From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: Re: Article about Object Store API
Date: Fri, 30 Jan 2015 09:33:56 +0800
Message-ID: <CA+U0gVg7RWsJNHW+qKa0NLZzePiBOUQ8uu3=hqaP_-dc04thNA@mail.gmail.com>
References: <871tmgvtje.fsf@irq0.org> <CA+U0gViEieTP0vL+NYSBL7iHkOgBR1jnu_SsbZtQv8-Ci+BBgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41434 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbbA3BeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 20:34:17 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so45719388pad.8
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 17:34:16 -0800 (PST)
In-Reply-To: <CA+U0gViEieTP0vL+NYSBL7iHkOgBR1jnu_SsbZtQv8-Ci+BBgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello, marcel,

Below is the email sent to the ceph-users mail list regarding ceph
class question, but seems it's in pending state since I am not the
member of that list.
>>
Hello,

I found the document of ceph class usage is very few, below is the
only one which can almost address my needs--
http://ceph.com/rados/dynamic-object-interfaces-with-lua/

But still some questions confusing me left there:

1. How to make the OSD to load the class lib? or what's the process
for an OSD deamon to load a customized class lib?
I checked my OSD log file(/var/log/ceph/ceph-osd.2.
log), I can't find
the log message "loading cls_hello", does that mean the "hello" class
lib hasn't been loaded by the osd deamon yet? But I can see the
'libcls_hello.so' is really under /usr/lib64/rados-classes folder of
that OSD.

2. Suppose I have an object named "testobj" stored into OSD0 and OSD1,
what will happen if I call the rados_exec(..., "testobj", "hello",
"say_hello",...) in client side? Will the say_hello() function be
called twice in OSD0 and OSD1 respectively?

On Thu, Jan 29, 2015 at 4:14 PM, Dennis Chen <kernel.org.gnu@gmail.com> wrote:
> Hello marcel,
>
> Very good article though I am still reading it. Do you have a clear
> picture of the relationship between class and
> librados API - rados_exec()?
>
> On Wed, Jan 28, 2015 at 4:48 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>>
>> Hi,
>>
>> I wrote an article about the object store API - How it works and looks
>> like with a focus on how to add something new.
>>
>> http://irq0.org/articles/ceph/objectstore
>>
>> Maybe its useful for somebody.. Feedback is greatly appreciated!
>>
>>
>>
>> [ I'm working on a Master's Thesis about Cold Storage / Archives using Ceph
>> and will probably write something more about other parts of Ceph
>> crossing my way in the near future :) ]
>>
>>
>> ~marcel
>>
>>
>> --
>> Marcel Lauhoff
>> Mail/XMPP: ml@irq0.org
>> http://irq0.org
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Den



-- 
Den
